import 'package:flutter/cupertino.dart';


import '../../../flavor_config.dart';
import '../domain/models/molibio_resuilt.dart';
import '../domain/services/mobilio_service_interface.dart';


class MobilioController with ChangeNotifier {
  final MobilioServiceInterface serviceInterface;
  MobilioController({required this.serviceInterface});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  MolibioResuilt? mobilioResuilt;
  List<MolibioDatum>? mobilios;
  List<MolibioDatum>? filteredMobilios = [];
  String _searchText = '';

  Future<MolibioResuilt> getProducts() async {
    MolibioResuilt response = await serviceInterface.getProducts();
    mobilios = response.data;
    filteredMobilios = mobilios;
    notifyListeners();
    return response;
  }

  void updateSearch(String value) {
    _searchText = value.toLowerCase();
    filteredMobilios = mobilios!.where((item) {
      return item.name.toLowerCase().contains(_searchText);
    }).toList();
    notifyListeners();
  }


}