import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpManager {
  static Utf8Decoder decoder = const Utf8Decoder();

  static void get(String url,
      {Map<String, String>? headers,
      Function? success,
      Function? fail,
      Function? complete}) async {
    var response = await http.get(Uri.parse(url), headers: headers);
    try {
      if (response.statusCode == 200) {
        var result = json.decode(decoder.convert(response.bodyBytes));
        if (success != null) {
          success(result);
        }
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      if (fail != null) {
        fail();
      }
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }

  static Future requestData(String url, {Map<String, String>? headers}) async {
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var result = json.decode(decoder.convert(response.bodyBytes));
        return result;
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      Future.error(e);
    }
  }
}
