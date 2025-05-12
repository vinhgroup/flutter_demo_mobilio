import 'package:bxanh_vendor/interface/repository_interface.dart';

import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/response_model.dart';
import '../models/molibio_resuilt.dart';
import '../repositories/mobilio_respository_interface.dart';
import 'mobilio_service_interface.dart';
import 'package:flutter/services.dart' show rootBundle;

class MobilioSerivce implements MobilioServiceInterface {
  final MobilioRespoInterface repo;
  MobilioSerivce({required this.repo});

  @override
  Future getProducts() async {
    MolibioResuilt molibioResuilt = await repo.getProducts();
    return molibioResuilt;
  }
}