import 'package:bxanh_vendor/interface/repository_interface.dart';

import '../../../../data/model/response/base/api_response.dart';
import '../models/molibio_resuilt.dart';

abstract class MobilioRespoInterface implements RepositoryInterface {
  Future<dynamic> getProducts();
}