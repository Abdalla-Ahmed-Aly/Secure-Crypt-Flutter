import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

/// ✅ حساب القاسم المشترك الأكبر باستخدام خوارزمية إقليدس
int gcd(int a, int b) {
  while (b != 0) {
    int temp = b;
    b = a % b;
    a = temp;
  }
  return a;
}

/// ✅ خوارزمية إقليدس الممتدة لحساب المعكوس الضربي (modular inverse)
int modInverse(int e, int phi) {
  int a = e, b = phi;
  int x0 = 1, x1 = 0;

  while (b != 0) {
    int q = a ~/ b; // القسمة الصحيحة
    int temp = a;
    a = b;
    b = temp % b;

    int tempX = x0;
    x0 = x1;
    x1 = tempX - q * x1;
  }

  // لو الناتج سالب، نرجعه ضمن المجال [0, φ)
  return x0 < 0 ? x0 + phi : x0;
}

/// ✅ التحقق مما إذا كان العدد أوليًا
bool isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= sqrt(n).floor(); i++) {
    if (n % i == 0) return false;
  }
  return true;
}

/// ✅ توليد عددين أوليين باستخدام مولد الأرقام العشوائية الخطّي (LCG)
List<int> generateTwoPrimesFromSeed(int seed) {
  int a = 1103515245;
  int c = 12345;
  int m = 1 << 31; // 2^31
  int x = seed;
  List<int> primes = [];

  // دالة الـ LCG نفسها
  int lcg(int x) => (a * x + c) % m;

  while (primes.length < 2) {
    x = lcg(x);
    int possiblePrime = x % 1000;
    if (isPrime(possiblePrime) && !primes.contains(possiblePrime)) {
      primes.add(possiblePrime);
    }
  }

  return primes;
}

/// ✅ الأسس المعيارية - Modular Exponentiation (تُستخدم في RSA)
int modPow(int base, int exp, int mod) {
  int result = 1;
  base %= mod;
  while (exp > 0) {
    if (exp % 2 == 1) result = (result * base) % mod;
    exp ~/= 2;
    base = (base * base) % mod;
  }
  return result;
}

/// ✅ تحويل مصفوفة أرقام إلى بايتات (لكي تُستخدم في التشفير)
Uint8List numberArrayToBytes(List<int> numbers, {int byteLength = 4}) {
  final bytes = <int>[];
  for (final num in numbers) {
    for (int i = byteLength - 1; i >= 0; i--) {
      bytes.add((num >> (8 * i)) & 0xFF);
    }
  }
  return Uint8List.fromList(bytes);
}

/// ✅ تحويل بايتات إلى مصفوفة أرقام (عكس الدالة اللي فوق)
List<int> bytesToNumberArray(Uint8List bytes, {int byteLength = 4}) {
  final numbers = <int>[];
  for (int i = 0; i < bytes.length; i += byteLength) {
    int num = 0;
    for (int j = 0; j < byteLength; j++) {
      num = (num << 8) | (bytes[i + j]);
    }
    numbers.add(num);
  }
  return numbers;
}

/// ✅ توليد مفاتيح RSA: عامة وخاصة
Map<String, List<int>> rsa() {
  // توليد عددين أوليين بشكل عشوائي بناءً على الوقت الحالي
  final primes = generateTwoPrimesFromSeed(DateTime.now().millisecondsSinceEpoch);
  int p = primes[0], q = primes[1];

  // n هو حاصل ضرب العددين
  int n = p * q;

  // حساب φ (أويلر)
  int phi = (p - 1) * (q - 1);

  // نختار e = 19 (عدد أولي صغير)
  int e = 19;

  // التأكد من أن e صالح (أصغر من φ وأولي مع φ)
  if (e >= phi || gcd(e, phi) != 1) {
    throw Exception("Invalid 'e'. Must be < phi and coprime.");
  }

  // حساب d (المفتاح الخاص)
  int d = modInverse(e, phi);

  print("Prime p: $p");
  print("Prime q: $q");

  // إرجاع المفاتيح: العامة والخاصة
  return {
    'public': [n, e],
    'private': [n, d],
  };
}

/// ✅ تشفير نص باستخدام المفتاح العام وتحويله إلى base64
String encryptTextBase64(String text, List<int> publicKey) {
  final n = publicKey[0];
  final e = publicKey[1];
  final textBytes = utf8.encode(text);

  // تأكد أن طول النص لا يتعدى الحجم المسموح به
  if (textBytes.length > 53) {
    throw Exception("Input too long. RSA max block size is 53 bytes.");
  }

  // تشفير كل بايت على حدة باستخدام modPow
  final cipherNums = textBytes.map((byte) => modPow(byte, e, n)).toList();

  // تحويل الأرقام المشفرة إلى بايتات
  final encryptedBytes = numberArrayToBytes(cipherNums);

  // تشفير بايتات النص إلى base64
  return base64Encode(encryptedBytes);
}

/// ✅ فك التشفير من base64 إلى النص الأصلي باستخدام المفتاح الخاص
String decryptTextBase64(String base64Cipher, List<int> privateKey) {
  final n = privateKey[0];
  final d = privateKey[1];

  // تحويل من base64 إلى بايتات
  final encryptedBytes = base64Decode(base64Cipher);

  // تحويل البايتات إلى أرقام
  final cipherNums = bytesToNumberArray(encryptedBytes);

  // فك التشفير باستخدام المفتاح الخاص
  final decryptedBytes = cipherNums.map((c) => modPow(c, d, n)).toList();

  // تحويل البايتات المفكوكة إلى نص
  return utf8.decode(Uint8List.fromList(decryptedBytes));
}
