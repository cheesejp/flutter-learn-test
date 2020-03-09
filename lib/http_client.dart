import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HttpClient {
  HttpClient({@required this.url});
  final String url;
  http.Response _response;
  Future<http.Response> _get() async {
    this._response = await http.get(this.url);
    return this._response;
  }

  Future<int> getResponseCode() async {
    if (this._response == null) {
      http.Response res = await this._get();
      return res.statusCode;
    }
    return _response.statusCode;
  }

  Future<String> getBody() async {
    if (this._response == null) {
      http.Response res = await this._get();
      return res.body;
    }

    return _response.body;
  }
}
