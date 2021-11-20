class HttpHeaders {
  static Future<Map<String, String>> headers() async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
