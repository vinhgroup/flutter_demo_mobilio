// To parse this JSON data, do
//
//     final molibioResuilt = molibioResuiltFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MolibioResuilt molibioResuiltFromJson(String str) => MolibioResuilt.fromJson(json.decode(str));

String molibioResuiltToJson(MolibioResuilt data) => json.encode(data.toJson());

class MolibioResuilt {
  List<MolibioDatum> data;

  MolibioResuilt({
    required this.data,
  });

  factory MolibioResuilt.fromJson(Map<String, dynamic> json) => MolibioResuilt(
    data: List<MolibioDatum>.from(json["data"].map((x) => MolibioDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MolibioDatum {
  String name;
  double price;
  String image;
  String detail;

  MolibioDatum({
    required this.name,
    required this.price,
    required this.image,
    required this.detail,
  });

  factory MolibioDatum.fromJson(Map<String, dynamic> json) => MolibioDatum(
    name: json["name"],
    price: json["price"].toDouble(),
    image: json["image"],
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "image": image,
    "detail": detail,
  };
}
