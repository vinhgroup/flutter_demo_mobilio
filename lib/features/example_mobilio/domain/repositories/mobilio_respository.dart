import 'package:bxanh_vendor/data/model/response/base/api_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../models/molibio_resuilt.dart';
import 'mobilio_respository_interface.dart';
import 'package:flutter/services.dart' show rootBundle;

class MobilioRepository implements MobilioRespoInterface {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  MobilioRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getProducts() async {
    final jsonString = await rootBundle.loadString('assets/products.json');
    return molibioResuiltFromJson(jsonString);;
  }
}
