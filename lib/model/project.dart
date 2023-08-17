// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'dart:convert';

List<Projects> projectsFromJson(String str) => List<Projects>.from(json.decode(str).map((x) => Projects.fromJson(x)));

String projectsToJson(List<Projects> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Projects {
  int id;
  String area;
  String projectName;
  String developerName;
  String? image;

  Projects({
    required this.id,
    required this.area,
    required this.projectName,
    required this.developerName,
    required this.image,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
    id: json["id"],
    area: json["area"],
    projectName: json["projectName"],
    developerName: json["developerName"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "area": area,
    "projectName": projectName,
    "developerName": developerName,
    "image": image,
  };
}
// To parse this JSON data, do
//
//     final projectDetails = projectDetailsFromJson(jsonString);

ProjectDetails projectDetailsFromJson(String str) => ProjectDetails.fromJson(json.decode(str));

String projectDetailsToJson(ProjectDetails data) => json.encode(data.toJson());

class ProjectDetails {
  int id;
  String area;
  String projectName;
  String projectType;
  String developerName;
  String landmark;
  String areaIn;
  String amenities;
  String parking;
  bool transport;
  bool readyToMove;
  bool power;
  bool goods;
  DateTime rera;
  DateTime possession;
  String image;
  List<Unit> units;

  ProjectDetails({
    required this.id,
    required this.area,
    required this.projectName,
    required this.projectType,
    required this.developerName,
    required this.landmark,
    required this.areaIn,
    required this.amenities,
    required this.parking,
    required this.transport,
    required this.readyToMove,
    required this.power,
    required this.goods,
    required this.rera,
    required this.possession,
    required this.image,
    required this.units,
  });

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
    id: json["id"],
    area: json["area"],
    projectName: json["projectName"],
    projectType: json["projectType"],
    developerName: json["developerName"],
    landmark: json["landmark"],
    areaIn: json["areaIn"],
    amenities: json["amenities"],
    parking: json["parking"],
    transport: json["transport"],
    readyToMove: json["readyToMove"],
    power: json["power"],
    goods: json["goods"],
    rera: DateTime.parse(json["rera"]),
    possession: DateTime.parse(json["possession"]),
    image: json["image"],
    units: List<Unit>.from(json["units"].map((x) => Unit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "area": area,
    "projectName": projectName,
    "projectType": projectType,
    "developerName": developerName,
    "landmark": landmark,
    "areaIn": areaIn,
    "amenities": amenities,
    "parking": parking,
    "transport": transport,
    "readyToMove": readyToMove,
    "power": power,
    "goods": goods,
    "rera": rera.toIso8601String(),
    "possession": possession.toIso8601String(),
    "image": image,
    "units": List<dynamic>.from(units.map((x) => x.toJson())),
  };
}

class Unit {
  int id;
  int projectId;
  double unit;
  int carpetArea;
  int price;
  List<FloorMap> floorMap;

  Unit({
    required this.id,
    required this.projectId,
    required this.unit,
    required this.carpetArea,
    required this.price,
    required this.floorMap,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    projectId: json["project_id"],
    unit: json["unit"]?.toDouble(),
    carpetArea: json["CarpetArea"],
    price: json["price"],
    floorMap: List<FloorMap>.from(json["floor_map"].map((x) => FloorMap.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_id": projectId,
    "unit": unit,
    "CarpetArea": carpetArea,
    "price": price,
    "floor_map": List<dynamic>.from(floorMap.map((x) => x.toJson())),
  };
}
List<FloorMap> floorMapFromJson(String str) => List<FloorMap>.from(json.decode(str).map((x) => FloorMap.fromJson(x)));

String floorMapToJson(List<FloorMap> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FloorMap {
  int id;
  String image;
  String name;
  int unit;

  FloorMap({
    required this.id,
    required this.image,
    required this.name,
    required this.unit,
  });

  factory FloorMap.fromJson(Map<String, dynamic> json) => FloorMap(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "unit": unit,
  };
}

List<ProjectImage> projectImageFromJson(String str) => List<ProjectImage>.from(json.decode(str).map((x) => ProjectImage.fromJson(x)));

String projectImageToJson(List<ProjectImage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectImage {
  int id;
  String image;
  String name;
  int projectId;

  ProjectImage({
    required this.id,
    required this.image,
    required this.name,
    required this.projectId,
  });

  factory ProjectImage.fromJson(Map<String, dynamic> json) => ProjectImage(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    projectId: json["project_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "project_id": projectId,
  };
}
