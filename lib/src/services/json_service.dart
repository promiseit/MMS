import 'dart:convert';

class JsonService {
  static String encodeMap(Map<String, int> map) {
    return jsonEncode(map);
  }

  static Map<String, int> decodeMap(String jsonString) {
    try {
      final dynamic decoded = jsonDecode(jsonString);
      if (decoded is Map<String, dynamic>) {
        return decoded.map((key, value) => MapEntry(key, value as int));
      }
    } catch (e) {
    }
    return {};
  }

  static String encodeIntMap(Map<int, int> map) {
    return jsonEncode(map);
  }

  static Map<int, int> decodeIntMap(String jsonString) {
    try {
      final dynamic decoded = jsonDecode(jsonString);
      if (decoded is Map<String, dynamic>) {
        return decoded.map((key, value) => MapEntry(int.parse(key), value as int));
      }
    } catch (e) {
    }
    return {};
  }
}
