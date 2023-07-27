import 'dart:convert';

class Unit {
  int projectId;
  String projectName;
  String area;
  DateTime rera;
  double unit;
  int carpetArea;
  int price;
  double longitude;
  double latitude;
  String amenities;


  Unit({
    required this.projectId,
    required this.projectName,
    required this.area,
    required this.rera,
    required this.unit,
    required this.carpetArea,
    required this.price,
    required this.longitude,
    required this.latitude,
    required this.amenities,
  });

  factory Unit.fromJson(String str) => Unit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Unit.fromMap(Map<String, dynamic> json) => Unit(
    projectId: json["project_id"],
    projectName: json["project_name"],
    area: json["area"],
    rera: DateTime.parse(json["rera"]),
    unit: json["unit"]?.toDouble(),
    carpetArea: json["CarpetArea"],
    price: json["price"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    amenities: json["amenities"],
  );

  Map<String, dynamic> toMap() => {
    "project_id": projectId,
    "project_name": projectName,
    "area": area,
    "rera": rera.toIso8601String(),
    "unit": unit,
    "CarpetArea": carpetArea,
    "price": price,
    "longitude": longitude,
    "latitude": latitude,
    "amenities": amenities,
  };
}
