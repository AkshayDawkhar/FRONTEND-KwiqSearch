import 'dart:convert';

class AddProject {
  String area;
  String projectName;
  String projectType;
  String developerName;
  double landParcel;
  String landmark;
  String areaIn;
  String waterSupply;
  int lifts;
  int floors;
  int flatsPerFloors;
  int totalUnit;
  int availableUnit;
  String amenities;
  String parking;
  double longitude;
  double latitude;
  bool transport;
  bool readyToMove;
  bool power;
  bool goods;
  DateTime rera;
  DateTime possession;
  String contactPerson;
  int contactNumber;
  int marketValue;
  double brokerage;
  int incentive;
  double bhk;
  int carpetArea;
  int price;
  List units;

  AddProject(
      {required this.area,
      required this.projectName,
      required this.projectType,
      required this.developerName,
      required this.landParcel,
      required this.landmark,
      required this.areaIn,
      required this.waterSupply,
      required this.lifts,
      required this.floors,
      required this.flatsPerFloors,
      required this.totalUnit,
      required this.availableUnit,
      required this.amenities,
      required this.parking,
      required this.longitude,
      required this.latitude,
      required this.transport,
      required this.readyToMove,
      required this.power,
      required this.goods,
      required this.rera,
      required this.possession,
      required this.contactPerson,
      required this.contactNumber,
      required this.marketValue,
      required this.brokerage,
      required this.incentive,
      required this.bhk,
      required this.carpetArea,
      required this.price,
      required this.units});

  Map<String, dynamic> toMap() {
    return {
      'area': area,
      'projectName': projectName,
      'projectType': projectType,
      'developerName': developerName,
      'landParcel': landParcel,
      'landmark': landmark,
      'areaIn': areaIn,
      'waterSupply': waterSupply,
      'lifts': lifts,
      'floors': floors,
      'flatsPerFloors': flatsPerFloors,
      'totalUnit': totalUnit,
      'availableUnit': availableUnit,
      'amenities': amenities,
      'parking': parking,
      'longitude': longitude,
      'latitude': latitude,
      'transport': transport,
      'readyToMove': readyToMove,
      'power': power,
      'goods': goods,
      'rera': rera.toIso8601String(),
      'possession': possession.toIso8601String(),
      'contactPerson': contactPerson,
      'contactNumber': contactNumber,
      'marketValue': marketValue,
      'brokerage': brokerage,
      'incentive': incentive,
      'bhk': bhk,
      'carpetArea': carpetArea,
      'price': price,
      'units': units
    };
  }
//
// factory AddProject.fromJson(Map<String, dynamic> json) => AddProject(
//   area: json["area"],
//   projectName: json["projectName"],
//   projectType: json["projectType"],
//   developerName: json["developerName"],
//   landParcel: json["landParcel"],
//   landmark: json["landmark"],
//   areaIn: json["areaIn"],
//   waterSupply: json["waterSupply"],
//   floors: json["floors"],
//   flatsPerFloors: json["flatsPerFloors"],
//   totalUnit: json["totalUnit"],
//   availableUnit: json["availableUnit"],
//   amenities: json["amenities"],
//   parking: json["parking"],
//   longitude: json["longitude"],
//   latitude: json["latitude"],
//   transport: json["transport"],
//   readyToMove: json["readyToMove"],
//   power: json["power"],
//   goods: json["goods"],
//   rera: DateTime.parse(json["rera"]),
//   possession: DateTime.parse(json["possession"]),
//   contactPerson: json["contactPerson"],
//   contactNumber: json["contactNumber"],
//   marketValue: json["marketValue"],
//   lifts: json["lifts"],
//   brokerage: json["brokerage"],
//   incentive: json["incentive"],
//   units: List<Unit>.from(json["units"].map((x) => Unit.fromJson(x).to)),
// );

// Map<String, dynamic> toJson() => {
//   "area": area,
//   "projectName": projectName,
//   "projectType": projectType,
//   "developerName": developerName,
//   "landParcel": landParcel,
//   "landmark": landmark,
//   "areaIn": areaIn,
//   "waterSupply": waterSupply,
//   "floors": floors,
//   "flatsPerFloors": flatsPerFloors,
//   "totalUnit": totalUnit,
//   "availableUnit": availableUnit,
//   "amenities": amenities,
//   "parking": parking,
//   "longitude": longitude,
//   "latitude": latitude,
//   "transport": transport,
//   "readyToMove": readyToMove,
//   "power": power,
//   "goods": goods,
//   "rera": rera.toIso8601String(),
//   "possession": possession.toIso8601String(),
//   "contactPerson": contactPerson,
//   "contactNumber": contactNumber,
//   "marketValue": marketValue,
//   "lifts": lifts,
//   "brokerage": brokerage,
//   "incentive": incentive,
//   "unit": List<dynamic>.from(units.map((x) => x.toJson())),
// };
}
List<Unit> unitFromJson(String str) => List<Unit>.from(json.decode(str).map((x) => Unit.fromJson(x)));

String unitToJson(List<Unit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Unit {
  int id;
  double unit;
  int carpetArea;
  int price;
  int projectId;
  List<FloorMap> floorMap;

  Unit({
    required this.id,
    required this.unit,
    required this.carpetArea,
    required this.price,
    required this.projectId,
    required this.floorMap,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    unit: json["unit"]?.toDouble(),
    carpetArea: json["CarpetArea"],
    price: json["price"],
    projectId: json["project_id"],
    floorMap: List<FloorMap>.from(json['floor_map'].map((x) => FloorMap.fromMap(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit": unit,
    "CarpetArea": carpetArea,
    "price": price,
    "project_id": projectId,
    "floor_map": floorMap.map((x) => x.toMap()).toList(),
  };
}


// AddProject addProjectFromJson(String str) => AddProject.fromJson(json.decode(str));

// String addProjectToJson(AddProject data) => json.encode(data.toJson());
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

  factory FloorMap.fromJson(String str) => FloorMap.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FloorMap.fromMap(Map<String, dynamic> json) => FloorMap(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    unit: json["unit"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "image": image,
    "name": name,
    "unit": unit,
  };
}
