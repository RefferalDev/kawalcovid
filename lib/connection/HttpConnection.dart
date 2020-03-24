import 'package:dio/dio.dart';

abstract class HttpConnection {
  Future<dynamic> get(String url, {Map<String, String> params, Map<String, dynamic> headers}) async {
    var resp = await Dio().get(url + _paramToString(params), options: Options(headers: headers));
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return resp.data;
    }
    return null;
  }

  String _paramToString(Map<String, String> params) {
    if (params == null) return "";
    String output = "?";
    params.forEach((key, value) {
      output += "$key=$value&";
    });
    return output.substring(0, output.length - 1);
  }
}
