class ObdParser {
  /// Parses OBD-II RPM response
  static String parseRPM(String data) {
    try {
      List<String> bytes = data.split(" ");
      int a = int.parse(bytes[2], radix: 16);
      int b = int.parse(bytes[3], radix: 16);
      return ((a * 256 + b) ~/ 4).toString();
    } catch (e) {
      return "N/A";
    }
  }

  /// Parses OBD-II Speed response
  static String parseSpeed(String data) {
    try {
      List<String> bytes = data.split(" ");
      return int.parse(bytes[2], radix: 16).toString();
    } catch (e) {
      return "N/A";
    }
  }
}
