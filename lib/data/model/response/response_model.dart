import 'dart:convert';

import 'package:dio/src/response.dart';

class ResponseModel {
  final bool _isSuccess;
  final String? _message;
  Response? response;

  ResponseModel(this._isSuccess, this._message, {this.response});

  String? get message => _message;

  bool get isSuccess => _isSuccess;

  static ResponseModel ErrorResponse(dynamic error) {
    String? errorMessage;
    if (error is String) {
      errorMessage = error.toString();
    } else {
      try {
        var data = jsonDecode(error.toString());
        errorMessage = data['errors'];
      } catch (e) {
        return ResponseModel(false, error.toString());
      }
    }
    return ResponseModel(false, errorMessage);
  }
}
