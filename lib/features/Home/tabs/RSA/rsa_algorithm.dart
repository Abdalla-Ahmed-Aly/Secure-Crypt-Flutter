// استيراد مكتبات Dart القياسية اللي هنحتاجها
import 'dart:convert';  // لتحويل النصوص إلى بايتات والعكس + ترميز Base64
import 'dart:typed_data';  // للتعامل مع مصفوفات البايتات
import 'dart:math';  // للعمليات الحسابية مثل الجذر التربيعي

/// ✅ دالة لحساب القاسم المشترك الأكبر (GCD) باستخدام خوارزمية إقليدس
int gcd(int a, int b) {
  while (b != 0) {
    int temp = b;       // نحفظ قيمة b مؤقتًا
    b = a % b;          // b الجديد هو باقي قسمة a على b
    a = temp;           // a الجديد هو القيمة القديمة لـ b
  }
  return a;             // لما b يبقى 0، a بيكون هو ال-GCD
}

/// ✅ دالة لحساب المعكوس الضربي (modular inverse) باستخدام خوارزمية إقليدس الممتدة
int modInverse(int e, int phi) {
  int a = e, b = phi;
  int x0 = 1, x1 = 0;

  while (b != 0) {
    int q = a ~/ b;     // نحسب خارج القسمة (قسمة صحيحة)
    int temp = a;
    a = b;
    b = temp % b;       // b الجديد هو باقي قسمة a على b

    int tempX = x0;
    x0 = x1;
    x1 = tempX - q * x1;  // تحديث معاملات المعكوس
  }

  // لو المعكوس طلع سالب، نضيف phi عشان يكون موجب
  return x0 < 0 ? x0 + phi : x0;
}

/// ✅ دالة للتحقق مما إذا كان العدد أوليًا أم لا
bool isPrime(int n) {
  if (n < 2) return false;  // الأعداد الأقل من 2 مش أولية
  for (int i = 2; i <= sqrt(n).floor(); i++) {  // بنجرب القسمة لحد الجذر التربيعي
    if (n % i == 0) return false;  // لو العدد يقبل القسمة، مش أولي
  }
  return true;  // لو مفيش قواسم، يبقى العدد أولي
}

/// ✅ دالة لتوليد عددين أوليين باستخدام مولد أرقام عشوائية خطّي (Linear Congruential Generator - LCG)
List<int> generateTwoPrimesFromSeed(int seed) {
  int a = 1103515245;   // معامل الضرب
  int c = 12345;        // معامل الجمع
  int m = 1 << 31;      // معامل المود (2^31)
  int x = seed;         // القيمة الأولية للمولد
  List<int> primes = [];

  // دالة المولد نفسها
  int lcg(int x) => (a * x + c) % m;

  // نولّد أعداد لحد ما نلاقي عددين أوليين مختلفين
  while (primes.length < 2) {
    x = lcg(x);  // نولّد قيمة جديدة
    int possiblePrime = x % 1000;  // ناخد القيمة المولدة ونقللها لتحت 1000
    if (isPrime(possiblePrime) && !primes.contains(possiblePrime)) {
      primes.add(possiblePrime);  // نضيف العدد لو أولي وغير مكرر
    }
  }

  return primes;  // نرجع العددين
}

/// ✅ دالة لحساب (base^exp) mod (mod) بكفاءة (الأسس المعيارية)
int modPow(int base, int exp, int mod) {
  int result = 1;
  base %= mod;  // نقلل base داخل المجال

  while (exp > 0) {
    if (exp % 2 == 1) result = (result * base) % mod;  // لو الـ exp فردي، نضرب في النتيجة
    exp ~/= 2;         // نقسم الأس على 2
    base = (base * base) % mod;  // نربع الـ base ونقلله بالمود
  }
  return result;
}

/// ✅ دالة لتحويل مصفوفة أرقام إلى بايتات (مهمة للتشفير)
Uint8List numberArrayToBytes(List<int> numbers, {int byteLength = 4}) {
  final bytes = <int>[];  // مصفوفة جديدة للبايتات
  for (final num in numbers) {
    for (int i = byteLength - 1; i >= 0; i--) {
      bytes.add((num >> (8 * i)) & 0xFF);  // نقسم العدد إلى بايتات
    }
  }
  return Uint8List.fromList(bytes);  // نحولها إلى Uint8List
}

/// ✅ دالة لتحويل بايتات إلى مصفوفة أرقام (العكس)
List<int> bytesToNumberArray(Uint8List bytes, {int byteLength = 4}) {
  final numbers = <int>[];  // مصفوفة جديدة للأرقام
  for (int i = 0; i < bytes.length; i += byteLength) {
    int num = 0;
    for (int j = 0; j < byteLength; j++) {
      num = (num << 8) | (bytes[i + j]);  // نركب البايتات في عدد واحد
    }
    numbers.add(num);
  }
  return numbers;
}

/// ✅ دالة لتوليد مفاتيح RSA: المفتاح العام والمفتاح الخاص
Map<String, List<int>> rsa() {
  // نولّد عددين أوليين بناءً على التوقيت الحالي (عشوائية)
  final primes = generateTwoPrimesFromSeed(DateTime.now().millisecondsSinceEpoch);
  int p = primes[0], q = primes[1];

  // n هو حاصل ضرب العددين
  int n = p * q;

  // حساب φ (عدد الأويلر للن)
  int phi = (p - 1) * (q - 1);

  // نختار e = 19 كعدد أولي صغير مناسب
  int e = 19;

  // نتأكد أن e أصغر من φ ومفيش قاسم مشترك معاه (coprime)
  if (e >= phi || gcd(e, phi) != 1) {
    throw Exception("Invalid 'e'. Must be < phi and coprime.");
  }

  // نحسب المفتاح الخاص d بحيث (e * d) ≡ 1 mod phi
  int d = modInverse(e, phi);

  // نطبع العددين الأوليين (اختياري للعرض)
  print("Prime p: $p");
  print("Prime q: $q");

  // نرجع المفاتيح كماب: public = (n, e), private = (n, d)
  return {
    'public': [n, e],
    'private': [n, d],
  };
}

/// ✅ دالة لتشفير نص وتحويله إلى Base64 باستخدام المفتاح العام
String encryptTextBase64(String text, List<int> publicKey) {
  final n = publicKey[0];
  final e = publicKey[1];
  final textBytes = utf8.encode(text);  // نحول النص إلى بايتات

  // تأكد أن النص صغير كفاية (53 بايت كحد أقصى)
  if (textBytes.length > 53) {
    throw Exception("Input too long. RSA max block size is 53 bytes.");
  }

  // نشفّر كل بايت باستخدام الأس المعياري
  final cipherNums = textBytes.map((byte) => modPow(byte, e, n)).toList();

  // نحول الأرقام المشفرة إلى بايتات
  final encryptedBytes = numberArrayToBytes(cipherNums);

  // نحول البايتات إلى نص Base64
  return base64Encode(encryptedBytes);
}

/// ✅ دالة لفك تشفير نص مشفر بـ Base64 باستخدام المفتاح الخاص
String decryptTextBase64(String base64Cipher, List<int> privateKey) {
  final n = privateKey[0];
  final d = privateKey[1];

  // نحول النص المشفر من Base64 إلى بايتات
  final encryptedBytes = base64Decode(base64Cipher);

  // نحول البايتات إلى أرقام
  final cipherNums = bytesToNumberArray(encryptedBytes);

  // نفك تشفير كل رقم باستخدام المفتاح الخاص
  final decryptedBytes = cipherNums.map((c) => modPow(c, d, n)).toList();

  // نحول البايتات المفكوكة إلى نص UTF-8
  return utf8.decode(Uint8List.fromList(decryptedBytes));
}
