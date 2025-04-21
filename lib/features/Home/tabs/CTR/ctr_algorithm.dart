import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;

void CtrAlgorithim() {
  final text = 'Hello world 2025'.replaceAll(' ', '');

  // توليد مفتاح عشوائي مكون من 16 حرف
  final keyString = generateKeyWithLCG(length: 16);
  final key = encrypt.Key.fromUtf8(keyString);

  final ivString = '1234567890abcdef'; // IV ثابت بطول 16
  final ivBytes = utf8.encode(ivString);

  print('Generated Key: $keyString');
  print('Generated IV: $ivString');

  final blockSize = 16;
  final data = utf8.encode(text);
  List<int> encryptedResult = [];

  // تشفير باستخدام CTR يدويًا
  for (int i = 0; i < data.length; i += blockSize) {
    List<int> block = data.sublist(i, min(i + blockSize, data.length));

    List<int> counter = List.from(ivBytes);
    int blockIndex = i ~/ blockSize;
    counter[counter.length - 1] ^= blockIndex;

    final aesEcb = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));
    final counterEncrypted = aesEcb.encryptBytes(counter, iv: encrypt.IV.fromLength(0)).bytes;

    List<int> xorResult = List.generate(block.length, (j) => block[j] ^ counterEncrypted[j]);
    encryptedResult.addAll(xorResult);
  }

  final encryptedBase64 = base64.encode(encryptedResult);
  print('Encrypted Message: $encryptedBase64');

  // ============================
  //     فك التشفير اليدوي
  // ============================

  final encryptedBytes = base64.decode(encryptedBase64);
  List<int> decryptedResult = [];

  for (int i = 0; i < encryptedBytes.length; i += blockSize) {
    List<int> block = encryptedBytes.sublist(i, min(i + blockSize, encryptedBytes.length));

    List<int> counter = List.from(ivBytes);
    int blockIndex = i ~/ blockSize;
    counter[counter.length - 1] ^= blockIndex;

    final aesEcb = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));
    final counterEncrypted = aesEcb.encryptBytes(counter, iv: encrypt.IV.fromLength(0)).bytes;

    List<int> xorResult = List.generate(block.length, (j) => block[j] ^ counterEncrypted[j]);
    decryptedResult.addAll(xorResult);
  }

  print('Decrypted Message: ${utf8.decode(decryptedResult)}');
}

String generateKeyWithLCG({int length = 16}) {
  int a = 1664525;
  int c = 1013904223;
  int m = 1 << 32;
  int seed = DateTime.now().millisecondsSinceEpoch;

  List<int> values = [];
  for (int i = 0; i < length; i++) {
    seed = (a * seed + c) % m;
    int charCode = 97 + (seed % 26); // a-z
    values.add(charCode);
  }

  return String.fromCharCodes(values);
}
