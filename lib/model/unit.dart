import 'dart:convert';

class UnitDetails {
  int projectId;
  String projectName;
  String area;
  DateTime possession;
  double unit;
  int carpetArea;
  int price;
  double longitude;
  double latitude;
  String amenities;
  List<ProjectUnit> projectUnits;
  String? image;

  UnitDetails({
    required this.projectId,
    required this.projectName,
    required this.area,
    required this.possession,
    required this.unit,
    required this.carpetArea,
    required this.price,
    required this.longitude,
    required this.latitude,
    required this.amenities,
    required this.projectUnits,
    required this.image,
  });

  factory UnitDetails.fromJson(String str) => UnitDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UnitDetails.fromMap(Map<String, dynamic> json) => UnitDetails(
        projectId: json["project_id"],
        projectName: json["project_name"],
        area: json["area"],
        possession: DateTime.parse(json["possession"]),
        unit: json["unit"]?.toDouble(),
        carpetArea: json["CarpetArea"],
        price: json["price"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        amenities: json["amenities"],
        projectUnits: List<ProjectUnit>.from(json["project_units"].map((x) => ProjectUnit.fromMap(x))),
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "project_id": projectId,
        "project_name": projectName,
        "area": area,
        "possession": possession.toIso8601String(),
        "unit": unit,
        "CarpetArea": carpetArea,
        "price": price,
        "longitude": longitude,
        "latitude": latitude,
        "amenities": amenities,
        "project_units": List<dynamic>.from(projectUnits.map((x) => x.toMap())),
      };
}

class ProjectUnit {
  int id;
  double unit;
  int carpetArea;
  int price;
  int projectId;

  ProjectUnit({
    required this.id,
    required this.unit,
    required this.carpetArea,
    required this.price,
    required this.projectId,
  });

  factory ProjectUnit.fromJson(String str) => ProjectUnit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProjectUnit.fromMap(Map<String, dynamic> json) => ProjectUnit(
        id: json["id"],
        unit: json["unit"]?.toDouble(),
        carpetArea: json["CarpetArea"],
        price: json["price"],
        projectId: json["project_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "unit": unit,
        "CarpetArea": carpetArea,
        "price": price,
        "project_id": projectId,
      };
}

List<RecommendedUnit> recommendedUnitFromJson(String str) => List<RecommendedUnit>.from(json.decode(str).map((x) => RecommendedUnit.fromJson(x)));

String recommendedUnitToJson(List<RecommendedUnit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecommendedUnit {
  int projectId;
  String projectName;
  String area;
  DateTime possession;
  double unit;
  int carpetArea;
  int price;
  double longitude;
  double latitude;
  String amenities;
  int rating;

  RecommendedUnit({
    required this.projectId,
    required this.projectName,
    required this.area,
    required this.possession,
    required this.unit,
    required this.carpetArea,
    required this.price,
    required this.longitude,
    required this.latitude,
    required this.amenities,
    required this.rating,
  });

  factory RecommendedUnit.fromJson(Map<String, dynamic> json) => RecommendedUnit(
        projectId: json["project_id"],
        projectName: json["project_name"],
        area: json["area"],
        possession: DateTime.parse(json["possession"]),
        unit: json["unit"]?.toDouble(),
        carpetArea: json["CarpetArea"],
        price: json["price"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        amenities: json["amenities"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "project_name": projectName,
        "area": area,
        "possession": possession.toIso8601String(),
        "unit": unit,
        "CarpetArea": carpetArea,
        "price": price,
        "longitude": longitude,
        "latitude": latitude,
        "amenities": amenities,
        "rating": rating,
      };
}
