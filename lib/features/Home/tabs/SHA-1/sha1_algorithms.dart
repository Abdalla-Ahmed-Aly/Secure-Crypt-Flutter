class Sha1_Algorithms {

  static String sha1_algorithm(String text) {
    List<int> lettersAsciiCodes = text.codeUnits; // Get ASCII codes

    // Convert ASCII codes to binary strings and pad to 8 bits
    List<String> binaryList = lettersAsciiCodes.map((code) =>
        code.toRadixString(2).padLeft(8, '0')).toList();

    String binaryString = binaryList.join(); // Join binary strings

    String binaryStringByAdd1 = "${binaryString}1"; // Add 1 to the end

    String binaryString_448 = binaryStringByAdd1.padRight(
        (binaryString.length + 64 + 448) ~/ 512 * 512 - 64, '0'); // Pad to 448 bits

    String binaryString_512 = binaryString_448 +
        binaryString.length.toRadixString(2).padLeft(64, '0'); // Append original length to the end

    // Split binary string into 512-bit words
    List<int> words = [];
    for (int i = 0; i < binaryString_512.length; i += 32) {
      words.add(int.parse(binaryString_512.substring(i, i + 32),
          radix: 2)); // Each word is 32 bits
    }

    // Add new words with left rotation
    for (int n = 16; n < 80; n++) {
      int wN = words[n - 16] ^ words[n - 14] ^ words[n - 8] ^ words[n - 3];
      words.add(_rotl(wN, 1));
    }

    // Initialize hash values
    int h0 = 0x67452301;
    int h1 = 0xEFCDAB89;
    int h2 = 0x98BADCFE;
    int h3 = 0x10325476;
    int h4 = 0xC3D2E1F0;

    // Main loop for processing the 80 messages
    int a = h0;
    int b = h1;
    int c = h2;
    int d = h3;
    int e = h4;

    for (int j = 0; j < 80; j++) {
      int f, k;
      if (j < 20) {
        f = (b & c) | ((~b) & d); // Choose function 1
        k = 0x5A827999;
      } else if (j < 40) {
        f = b ^ c ^ d; // Choose function 2
        k = 0x6ED9EBA1;
      } else if (j < 60) {
        f = (b & c) | (b & d) | (c & d); // Choose function 3
        k = 0x8F1BBCDC;
      } else {
        f = b ^ c ^ d; // Choose function 4
        k = 0xCA62C1D6;
      }

      int temp = (_rotl(a, 5) + f + e + k + words[j]) & 0xFFFFFFFF;
      e = d;
      d = c;
      c = _rotl(b, 30);
      b = a;
      a = temp;
    }

    h0 = (h0 + a) & 0xFFFFFFFF;
    h1 = (h1 + b) & 0xFFFFFFFF;
    h2 = (h2 + c) & 0xFFFFFFFF;
    h3 = (h3 + d) & 0xFFFFFFFF;
    h4 = (h4 + e) & 0xFFFFFFFF;

    return [
      h0.toRadixString(16).padLeft(8, '0'),
      h1.toRadixString(16).padLeft(8, '0'),
      h2.toRadixString(16).padLeft(8, '0'),
      h3.toRadixString(16).padLeft(8, '0'),
      h4.toRadixString(16).padLeft(8, '0')
    ].join('');
  }

  static int _rotl(int value, int amount) {
    return ((value << amount) | (value >> (32 - amount))) & 0xFFFFFFFF;
  }

}