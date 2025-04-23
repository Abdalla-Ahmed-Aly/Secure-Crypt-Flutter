class Sha1_Algorithms {

  // الدالة الرئيسية لتطبيق خوارزمية SHA-1 على نص وإرجاع النتيجة كمجموعة من القيم الست عشرية
  static String sha1_algorithm(String text) {
    // تحويل النص إلى قائمة من الأكواد ASCII
    List<int> lettersAsciiCodes = text.codeUnits;

    // تحويل كل كود ASCII إلى تمثيل ثنائي مكوّن من 8 خانات
    List<String> binaryList = lettersAsciiCodes.map((code) =>
        code.toRadixString(2).padLeft(8, '0')).toList();

    // دمج التمثيلات الثنائية لتكوين سلسلة واحدة
    String binaryString = binaryList.join();

    // إضافة "1" في نهاية السلسلة الثنائية كخطوة أولى في عملية البادئة padding
    String binaryStringByAdd1 = "${binaryString}1";

    // إكمال السلسلة لتصل إلى 448 خانة (عدد الخانات يكون مضاعف لـ 512 ناقص 64)
    String binaryString_448 = binaryStringByAdd1.padRight(
        (binaryString.length + 64 + 448) ~/ 512 * 512 - 64, '0');

    // إضافة الطول الأصلي للسلسلة الثنائية (قبل الإضافة) في النهاية، كمقدمة من 64 خانة
    String binaryString_512 = binaryString_448 +
        binaryString.length.toRadixString(2).padLeft(64, '0');

    // تقسيم السلسلة الثنائية إلى كلمات طولها 32 خانة وتحويلها إلى أعداد صحيحة
    List<int> words = [];
    for (int i = 0; i < binaryString_512.length; i += 32) {
      words.add(int.parse(binaryString_512.substring(i, i + 32), radix: 2));
    }

    // تكوين 80 كلمة باستخدام XOR والتدوير لليسار (الـ 16 كلمة الأصلية والباقي يتم حسابه)
    for (int n = 16; n < 80; n++) {
      int wN = words[n - 16] ^ words[n - 14] ^ words[n - 8] ^ words[n - 3];
      words.add(_rotl(wN, 1)); // تدوير لليسار بمقدار 1 بت
    }

    // تهيئة القيم الابتدائية المستخدمة في خوارزمية SHA-1
    int h0 = 0x67452301;
    int h1 = 0xEFCDAB89;
    int h2 = 0x98BADCFE;
    int h3 = 0x10325476;
    int h4 = 0xC3D2E1F0;

    // تهيئة المتغيرات المؤقتة المستخدمة في كل جولة
    int a = h0;
    int b = h1;
    int c = h2;
    int d = h3;
    int e = h4;

    // 80 جولة من التكرار لمعالجة الرسالة
    for (int j = 0; j < 80; j++) {
      int f, k;

      // كل 20 جولة لها دالة معينة وثابت مختلف
      if (j < 20) {
        f = (b & c) | ((~b) & d); // دالة F1
        k = 0x5A827999;
      } else if (j < 40) {
        f = b ^ c ^ d; // دالة F2
        k = 0x6ED9EBA1;
      } else if (j < 60) {
        f = (b & c) | (b & d) | (c & d); // دالة F3
        k = 0x8F1BBCDC;
      } else {
        f = b ^ c ^ d; // دالة F4
        k = 0xCA62C1D6;
      }

      // تنفيذ العمليات الحسابية الأساسية مع التدوير والإضافة
      int temp = (_rotl(a, 5) + f + e + k + words[j]) & 0xFFFFFFFF;
      e = d;              // تحريك القيم
      d = c;
      c = _rotl(b, 30);   // تدوير b لليسار 30 بت
      b = a;
      a = temp;
    }

    // تحديث القيم النهائية بإضافة القيم الجديدة إلى الأصلية
    h0 = (h0 + a) & 0xFFFFFFFF;
    h1 = (h1 + b) & 0xFFFFFFFF;
    h2 = (h2 + c) & 0xFFFFFFFF;
    h3 = (h3 + d) & 0xFFFFFFFF;
    h4 = (h4 + e) & 0xFFFFFFFF;

    // تحويل الناتج النهائي إلى سلسلة ست عشرية وتجميعها في ناتج واحد
    return [
      h0.toRadixString(16).padLeft(8, '0'),
      h1.toRadixString(16).padLeft(8, '0'),
      h2.toRadixString(16).padLeft(8, '0'),
      h3.toRadixString(16).padLeft(8, '0'),
      h4.toRadixString(16).padLeft(8, '0')
    ].join('');
  }

  // دالة لتدوير رقم لليسار بمقدار معين (bitwise left rotation)
  static int _rotl(int value, int amount) {
    return ((value << amount) | (value >> (32 - amount))) & 0xFFFFFFFF;
  }

}
