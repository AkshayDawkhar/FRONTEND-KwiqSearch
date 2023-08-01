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

  Projects({
    required this.id,
    required this.area,
    required this.projectName,
    required this.developerName,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
    id: json["id"],
    area: json["area"],
    projectName: json["projectName"],
    developerName: json["developerName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "area": area,
    "projectName": projectName,
    "developerName": developerName,
  };
}
