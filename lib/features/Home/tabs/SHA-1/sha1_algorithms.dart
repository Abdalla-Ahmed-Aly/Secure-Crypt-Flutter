class Sha1_Algorithms {

  static String sha1(String text) {
    List<int> asciiCodeLetters = text.codeUnits; ///    First step

    var binaryNumber = asciiCodeLetters.map((asciiLetter) {
      return asciiLetter.toRadixString(2).padLeft(8,"0"); ///    Second step
    }).toList();

    var binaryString = binaryNumber.join(); ///    Third step

    String binaryStringAdd1 = binaryString+ "1";

    binaryStringAdd1 = binaryStringAdd1.padRight(448, '0'); ///    Fourth step

    return '';
  }

}