import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../model/add_project.dart';
import '../model/project.dart';

class ProjectsController extends GetxController {

  List<Projects> projects = [];
  bool isLoad = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProject();
  }

  void fetchProject() async {
    final url = Uri.parse('$HOSTNAME/home/project/');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // Map<String, dynamic> a = json.decode(response.body);
    projects = projectsFromJson(response.body);
    // print(clients);
    isLoad = true;
    update();
  }
}

class EditProductController extends GetxController {
  int projectId;
  EditProductController({required this.projectId});
  final fromKey = GlobalKey<FormState>();
  final fromKeyAdd = GlobalKey<FormState>();
  TextEditingController area = TextEditingController();
  TextEditingController addArea = TextEditingController();
  TextEditingController projectName = TextEditingController();
  TextEditingController projectType = TextEditingController();
  TextEditingController developerName = TextEditingController();
  TextEditingController landParcel = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController areaIn = TextEditingController();
  TextEditingController waterSupply = TextEditingController();
  TextEditingController lifts = TextEditingController();
  TextEditingController floors = TextEditingController();
  TextEditingController flatsPerFloors = TextEditingController();
  TextEditingController totalUnit = TextEditingController();
  TextEditingController availableUnit = TextEditingController();
  TextEditingController amenities = TextEditingController();
  TextEditingController parking = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController latitude = TextEditingController();
  bool transport = false;
  bool readyToMove = false;
  bool power = false;
  bool goods = false;

  // DateTime rera = DateTime.now();
  // DateTime possession = DateTime.now();
  int reraMonth = 1;
  int reraYear = 2023;
  int developerMonth = 1;
  int developerYear = 2023;
  TextEditingController reraController = TextEditingController();
  TextEditingController possessionController = TextEditingController();
  TextEditingController contactPerson = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController marketValue = TextEditingController();
  TextEditingController brokerage = TextEditingController();
  TextEditingController incentive = TextEditingController();
  TextEditingController bhk = TextEditingController();
  TextEditingController carpetArea = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController output = TextEditingController();

  // Map<String,TextEditingController> unit = {'unit':TextEditingController(),'CarpetArea':TextEditingController(),'price':TextEditingController()};
  List<Map<String, TextEditingController>> units = [];
  List<DropdownMenuItem> areas = [];
  List<DropdownMenuItem> unitsChoose = [];

  void saveAndEdit() {
    // area.text = '';
    // projectName.text = '';
    bhk = TextEditingController();
    carpetArea = TextEditingController();
    price = TextEditingController();
    update();
  }

  void setReadyToMove(bool value) {
    readyToMove = value;
    if (value) {
      DateTime dateTime = DateTime.now();
      reraYear = dateTime.year;
      reraMonth = dateTime.month;
      developerYear = dateTime.year;
      developerMonth = dateTime.month;
    }
    update();
  }

  void addName(String name) {
    // places.add(name);
    places.sort();
    update();
  }

  void addNewArea(String name) async {
    // places.add(name);
    // places.sort();
    final url = Uri.parse('$HOSTNAME/home/areas/');
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"name": name, "formatted_version": name}));
    print(responce.body);
    print(responce.statusCode);
    // postNewArea({"name": name, "formatted_version": name});
    if (responce.statusCode == 201) {
      Get.back();
      getAreas();
    }
    update();
  }

  //
  // void setRERA(DateTime dateTime) {
  //   rera = dateTime;
  //   reraController.text = dateToString(rera);
  //   update();
  // }
  //
  // void setPossession(DateTime dateTime) {
  //   possession = dateTime;
  //   possessionController.text = dateToString(possession);
  //   update();
  // }
  void setTransport(bool value) {
    transport = value;
    update();
  }

  void setPower(bool value) {
    power = value;
    update();
  }

  void setGoods(bool value) {
    goods = value;
    update();
  }

  void get() async {
    // void updateFieldsFromModel(Map<String, dynamic> model) {
    // Update fields for AddProject instance
    final url = Uri.parse('$HOSTNAME/home/project/$projectId');
    final responce = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    Map a = json.decode(responce.body);
    AddProject model = AddProject(
      area: a["area"],
      projectName: a["projectName"],
      projectType: a["projectType"],
      developerName: a["developerName"],
      landParcel: a["landParcel"],
      landmark: a["landmark"],
      areaIn: a["areaIn"],
      waterSupply: a["waterSupply"],
      floors: a["floors"],
      flatsPerFloors: a["flatsPerFloors"],
      totalUnit: a["totalUnit"],
      availableUnit: a["availableUnit"],
      amenities: a["amenities"],
      parking: a["parking"],
      longitude: a["longitude"],
      latitude: a["latitude"],
      transport: a["transport"],
      readyToMove: a["readyToMove"],
      power: a["power"],
      goods: a["goods"],
      rera: DateTime.parse(a["rera"]),
      possession: DateTime.parse(a["possession"]),
      contactPerson: a["contactPerson"],
      contactNumber: a["contactNumber"],
      marketValue: a["marketValue"],
      lifts: a["lifts"],
      brokerage: a["brokerage"],
      incentive: a["incentive"],
      units: a['units'].map((e) => Map<String, dynamic>.from(json.decode(json.encode(e).toString()))).toList(),

      bhk: 0,
      carpetArea: 0,
      price: 1,
    );
    print(model.toMap());
    AddProject model1 = AddProject(
        area: '',
        projectName: '2',
        projectType: "N/A Plot",
        developerName: '4',
        landParcel: 2.4,
        landmark: '5',
        areaIn: 'pcmc',
        waterSupply: 'PMRDA',
        lifts: 1,
        floors: 14,
        flatsPerFloors: 13,
        totalUnit: 13,
        availableUnit: 13,
        amenities: 'No Amenities',
        parking: 'Open car park',
        longitude: 12,
        latitude: 31,
        transport: true,
        readyToMove: true,
        power: true,
        goods: true,
        rera: DateTime(2024),
        possession: DateTime(2024),
        contactPerson: 'me',
        contactNumber: 9730766511,
        marketValue: 12,
        brokerage: 2,
        incentive: 15,
        bhk: 1,
        carpetArea: 123,
        price: 13,
        units: [
          {
            "project_id": 1,
            "project_name": "1",
            "area": "gahunje",
            "rera": "2023-07-01T00:00:00Z",
            "unit": 1.0,
            "CarpetArea": 120,
            "price": 111,
            "longitude": -122.0,
            "latitude": -123.0,
            "amenities": "No Amenities"
          },
          {
            "project_id": 2,
            "project_name": "qww",
            "area": "gahunje",
            "rera": "2023-07-01T00:00:00Z",
            "unit": 1.0,
            "CarpetArea": 123,
            "price": 1233,
            "longitude": -122.0,
            "latitude": -123.0,
            "amenities": "No Amenities"
          }
        ]);
    area.text = model.area;
    projectName.text = model.projectName;
    projectType.text = model.projectType;
    developerName.text = model.developerName;
    landParcel.text = model.landParcel.toString();
    landmark.text = model.landmark;
    areaIn.text = model.areaIn;
    waterSupply.text = model.waterSupply;
    lifts.text = model.lifts.toString();
    floors.text = model.floors.toString();
    flatsPerFloors.text = model.flatsPerFloors.toString();
    totalUnit.text = model.totalUnit.toString();
    availableUnit.text = model.availableUnit.toString();
    amenities.text = model.amenities;
    parking.text = model.parking;
    longitude.text = model.longitude.toString();
    latitude.text = model.latitude.toString();
    transport = model.transport;
    readyToMove = model.readyToMove;
    power = model.power;
    goods = model.goods;
    reraYear = model.rera.year;
    reraMonth = model.rera.month;
    developerYear = model.possession.year;
    developerMonth = model.possession.month;
    contactPerson.text = model.contactPerson;
    contactNumber.text = model.contactNumber.toString();
    marketValue.text = model.marketValue.toString();
    brokerage.text = model.brokerage.toString();
    incentive.text = model.incentive.toString();
    bhk.text = model.bhk.toString();
    carpetArea.text = model.carpetArea.toString();
    price.text = model.price.toString();

    // Update fields for units list (assuming units is a list of maps)
    units = model.units
        .map((unit) => {
              'unit': TextEditingController(text: unit['unit'].toString()),
              'CarpetArea': TextEditingController(text: unit['CarpetArea'].toString()),
              'price': TextEditingController(text: (unit['price'] / 100000).toString()),
            })
        .toList();
  }

  void getOutput() async {
    AddProject a = AddProject(
        area: area.text,
        projectName: projectName.text,
        projectType: projectType.text,
        developerName: developerName.text,
        landParcel: double.tryParse(landParcel.text) ?? 0,
        landmark: landmark.text,
        areaIn: areaIn.text,
        waterSupply: waterSupply.text,
        lifts: int.tryParse(lifts.text) ?? 0,
        floors: int.tryParse(floors.text) ?? 0,
        flatsPerFloors: int.tryParse(flatsPerFloors.text) ?? 0,
        totalUnit: int.tryParse(totalUnit.text) ?? 0,
        availableUnit: int.tryParse(availableUnit.text) ?? 0,
        amenities: amenities.text,
        parking: parking.text,
        longitude: double.tryParse(longitude.text) ?? 0,
        latitude: double.tryParse(latitude.text) ?? 0,
        transport: transport,
        readyToMove: readyToMove,
        power: power,
        goods: goods,
        rera: DateTime(reraYear, reraMonth),
        possession: DateTime(developerYear, developerMonth),
        contactPerson: contactPerson.text,
        contactNumber: int.tryParse(contactNumber.text) ?? 0,
        marketValue: ((double.tryParse(marketValue.text) ?? 0) * 10000000).toInt(),
        brokerage: double.tryParse(brokerage.text) ?? 0.0,
        incentive: int.tryParse(incentive.text) ?? 0,
        bhk: double.tryParse(bhk.text) ?? 0.0,
        carpetArea: int.tryParse(carpetArea.text) ?? 0,
        price: int.tryParse(price.text) ?? 0,
        units: units
            .map((e) => {
                  'unit': e['unit']!.text,
                  'CarpetArea': e['CarpetArea']!.text,
                  'price': ((double.tryParse(e['price']!.text) ?? 0) * 100000).toString(),
                })
            .toList());
    // return a.toString();
    print(a.toMap().toString());
    // json.encoder;
    // output.text = a.toMap().toString();
    // addProject(a.toMap());
    final url = Uri.parse('$HOSTNAME/home/projects/');
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(a.toMap()));
    print(responce.body);
    print(responce.statusCode);
    output.text = json.encode(a.toMap());

    update();
  }

  void getAreas() async {
    final url = Uri.parse('$HOSTNAME/home/areas/');
    final responce = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    List a = json.decode(responce.body);
    areas = a
        .map((e) => DropdownMenuItem(
              child: Text(e['name']),
              value: e['formatted_version'],
            ))
        .toList();
    print(areas);
    update();
    // print(a.first[]);
  }

  void addUnit() {
    units.add({'unit': TextEditingController(), 'CarpetArea': TextEditingController(), 'price': TextEditingController()});
    update();
  }

  void removeUnit() {
    int length = units.length;
    if (length > 1) {
      units.removeAt(length - 1);
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addUnit();
    getAreas();
    get();
  }
}
