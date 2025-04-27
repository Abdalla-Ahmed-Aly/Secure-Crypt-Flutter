import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;

// توليد مفتاح باستخدام خوارزمية LCG بطول 16 حرف (افتراضي A-Z فقط)
String generateKeyWithLCG({int length = 16}) {
  const m = 256; // المودولس
  const a = 1103515245; // معامل الضرب
  const c = 12345; // معامل الجمع
  int seed = DateTime.now().millisecondsSinceEpoch % m; // البذرة (seed)

  List<int> bytes = [];

  // توليد بايتات المفتاح
  for (int i = 0; i < length; i++) {
    seed = (a * seed + c) % m; // LCG formula
    bytes.add(seed);
  }

  // تحويل البايتات إلى حروف كبيرة A-Z
  return utf8.decode(bytes.map((e) => e % 26 + 65).toList());
}

// تنفيذ تشفير CTR
Map<String, String> CtrAlgorithim(String plainText) {
  final spaceIndices = <int>[]; // لتخزين أماكن الفراغات
  final buffer = StringBuffer(); //علشان نحط فيه النص من غير فراغات.

  // إزالة الفراغات من النص وتخزين مواقعها
  for (int i = 0; i < plainText.length; i++) {
    if (plainText[i] == ' ') {
      spaceIndices.add(i);
    } else {
      buffer.write(plainText[i]);
    }
  }

  final text = buffer.toString(); // النص بدون فراغات
  final keyString = generateKeyWithLCG(length: 16); // توليد المفتاح
  final key = encrypt.Key.fromUtf8(keyString); // تحويل المفتاح لـ Key
  final ivString = '1234567890abcdef'; // IV ثابت
  final ivBytes = utf8.encode(
    ivString,
  ); //الـ IV ثابت هنا (مش متغير)، وتحويله لـ bytes.

  final blockSize = 16;
  final data = utf8.encode(text); // تحويل النص لبنظام UTF8
  List<int> encryptedResult = [];

  // التشفير باستخدام CTR| التشفير بلوك بلوك:

  for (int i = 0; i < data.length; i += blockSize) {
    List<int> block = data.sublist(
      i,
      min(i + blockSize, data.length),
    ); // تقسيم البيانات إلى بلوكات
    List<int> counter = List.from(ivBytes); // عداد (counter)
    int blockIndex = i ~/ blockSize;
    counter[counter.length - 1] ^=
        blockIndex; // تغيير آخر بايت في الـ IV باستخدام XOR

    final aesEcb = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.ecb), // استخدام ECB لتشفير العداد
    );
    final counterEncrypted =
        aesEcb.encryptBytes(counter, iv: encrypt.IV.fromLength(0)).bytes;

    // تنفيذ XOR بين العداد المشفر والبلوك الأصلي
    List<int> xorResult = List.generate(
      block.length,
      (j) => block[j] ^ counterEncrypted[j],
    );
    encryptedResult.addAll(xorResult); // إضافة النتيجة
  }

  final encryptedBase64 = base64.encode(encryptedResult); // تحويل إلى Base64
  final spaces = spaceIndices.join(
    ',',
  ); // تحويل مواقع الفراغات لنص مفصول بفواصل

  return {'key': keyString, 'encrypted': encryptedBase64, 'spaces': spaces};
}

// فك تشفير CTR
String decryptCtr(
  String base64Cipher,
  String keyString,
  String ivString,
  String spaces,
) {
  final key = encrypt.Key.fromUtf8(keyString); // المفتاح
  final ivBytes = utf8.encode(ivString); // IV
  final encryptedBytes = base64.decode(
    base64Cipher,
  ); // تحويل من Base64 إلى بايتات
  final blockSize = 16;
  List<int> decryptedResult = [];

  // فك التشفير باستخدام نفس خطوات التشفير بالضبط
  for (int i = 0; i < encryptedBytes.length; i += blockSize) {
    List<int> block = encryptedBytes.sublist(
      i,
      i + min(blockSize, encryptedBytes.length - i),
    );
    List<int> counter = List.from(ivBytes);
    int blockIndex = i ~/ blockSize;
    counter[counter.length - 1] ^= blockIndex;

    final aesEcb = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.ecb),
    );
    final counterEncrypted =
        aesEcb.encryptBytes(counter, iv: encrypt.IV.fromLength(0)).bytes;

    // XOR بين البيانات المشفرة والعداد المشفر لفك التشفير
    List<int> xorResult = List.generate(
      block.length,
      (j) => block[j] ^ counterEncrypted[j],
    );
    decryptedResult.addAll(xorResult);
  }

  String decryptedText = utf8.decode(decryptedResult); // تحويل البايتات إلى نص

  // استرجاع الفراغات إلى مواقعها الأصلية
  final spaceIndices = spaces
      .split(',')
      .where((s) => s.isNotEmpty)
      .map(int.parse);

  final buffer = StringBuffer();
  int textIndex = 0;

  for (int i = 0; i < decryptedText.length + spaceIndices.length; i++) {
    if (spaceIndices.contains(i)) {
      buffer.write(' '); // إدخال فراغ
    } else {
      buffer.write(decryptedText[textIndex]); // إدخال حرف من النص
      textIndex++;
    }
  }

  return buffer.toString(); // إرجاع النص المفكوك بعد استعادة الفراغات
}
