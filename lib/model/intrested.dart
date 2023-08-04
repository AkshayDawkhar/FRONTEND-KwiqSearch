// To parse this JSON data, do
//
//     final interestedModel = interestedModelFromJson(jsonString);

import 'dart:convert';

List<InterestedModel> interestedModelFromJson(String str) => List<InterestedModel>.from(json.decode(str).map((x) => InterestedModel.fromJson(x)));

String interestedModelToJson(List<InterestedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InterestedModel {
  int client;
  List<String> area;
  double startBudget;
  double stopBudget;
  double startCarpetArea;
  double stopCarpetArea;
  DateTime possession;
  String requirements;
  List<double> units;
  String fname;
  String lname;
  int rating;

  InterestedModel({
    required this.client,
    required this.area,
    required this.startBudget,
    required this.stopBudget,
    required this.startCarpetArea,
    required this.stopCarpetArea,
    required this.possession,
    required this.requirements,
    required this.units,
    required this.fname,
    required this.lname,
    required this.rating,
  });

  factory InterestedModel.fromJson(Map<String, dynamic> json) => InterestedModel(
    client: json["client"],
    area: List<String>.from(json["Area"].map((x) => x)),
    startBudget: json["startBudget"]?.toDouble(),
    stopBudget: json["stopBudget"]?.toDouble(),
    startCarpetArea: json["startCarpetArea"]?.toDouble(),
    stopCarpetArea: json["stopCarpetArea"]?.toDouble(),
    possession: DateTime.parse(json["possession"]),
    requirements: json["requirements"],
    units: List<double>.from(json["units"].map((x) => x?.toDouble())),
    fname: json["fname"],
    lname: json["lname"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "client": client,
    "Area": List<dynamic>.from(area.map((x) => x)),
    "startBudget": startBudget,
    "stopBudget": stopBudget,
    "startCarpetArea": startCarpetArea,
    "stopCarpetArea": stopCarpetArea,
    "possession": possession.toIso8601String(),
    "requirements": requirements,
    "units": List<dynamic>.from(units.map((x) => x)),
    "fname": fname,
    "lname": lname,
    "rating": rating,
  };
}
