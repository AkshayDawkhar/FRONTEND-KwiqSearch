import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:takeahome/constants.dart';

import '../model/add_project.dart';

class NewProductController extends GetxController {
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
    if(responce.statusCode == 201){
      Get.defaultDialog(title: 'Successful', content: const Text('Created successfully'), backgroundColor: Colors.greenAccent,textConfirm: 'OK');
    }else{
      getErrorDialog(responce.body);
    }
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

  void setCurrentLocation() async {
    // Permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator .requestPermission ();
      print("Permissions not given");
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      // print(currentPosition.latitude);
      // print(currentPosition.longitude);
      latitude.text = currentPosition.latitude.toString();
      longitude.text = currentPosition.longitude.toString();
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addUnit();
    getAreas();
  }
}
