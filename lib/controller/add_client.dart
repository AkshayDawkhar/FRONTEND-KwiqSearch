import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class NewClientController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();

  bool isValidEmail(String email) {
    // Add email validation logic here (e.g., using regex)
    return true;
  }

  void getOutput(Map<String, dynamic> searchFilter) async {
    // AddProject a = AddProject(
    //     area: area.text,
    //     projectName: projectName.text,
    //     projectType: projectType.text,
    //     developerName: developerName.text,
    //     landParcel: double.tryParse(landParcel.text) ?? 0,
    //     landmark: landmark.text,
    //     areaIn: areaIn.text,
    //     waterSupply: waterSupply.text,
    //     lifts: int.tryParse(lifts.text) ?? 0,
    //     floors: int.tryParse(floors.text) ?? 0,
    //     flatsPerFloors: int.tryParse(flatsPerFloors.text) ?? 0,
    //     totalUnit: int.tryParse(totalUnit.text) ?? 0,
    //     availableUnit: int.tryParse(availableUnit.text) ?? 0,
    //     amenities: amenities.text,
    //     parking: parking.text,
    //     longitude: double.tryParse(longitude.text) ?? 0,
    //     latitude: double.tryParse(latitude.text) ?? 0,
    //     transport: transport,
    //     readyToMove: readyToMove,
    //     power: power,
    //     goods: goods,
    //     rera: DateTime(reraYear, reraMonth),
    //     possession: DateTime(developerYear, developerMonth),
    //     contactPerson: contactPerson.text,
    //     contactNumber: int.tryParse(contactNumber.text) ?? 0,
    //     marketValue: ((double.tryParse(marketValue.text) ?? 0) * 10000000).toInt(),
    //     brokerage: double.tryParse(brokerage.text) ?? 0.0,
    //     incentive: int.tryParse(incentive.text) ?? 0,
    //     bhk: double.tryParse(bhk.text) ?? 0.0,
    //     carpetArea: int.tryParse(carpetArea.text) ?? 0,
    //     price: int.tryParse(price.text) ?? 0,
    //     units: units
    //         .map((e) => {
    //       'unit': e['unit']!.text,
    //       'CarpetArea': e['CarpetArea']!.text,
    //       'price': ((double.tryParse(e['price']!.text) ?? 0) * 100000).toString(),
    //     })
    //         .toList());
    // // return a.toString();
    // print(a.toMap().toString());
    // // json.encoder;
    // // output.text = a.toMap().toString();
    // // addProject(a.toMap());
    // final url = Uri.parse('$HOSTNAME/home/projects/');
    // final responce = await http.post(url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(a.toMap()));
    // print(responce.body);
    // print(responce.statusCode);
    // output.text = json.encode(a.toMap());
    //
    // update();
    final Map<String, dynamic> data = {
      "fname": firstNameController.text,
      "lname": lastNameController.text,
      "phoneNO": phoneController.text,
      "massageNO": messageController.text,
      "email": emailController.text,
      "search_filter": {
        "Area": searchFilter['Area'],
        "units": searchFilter['units'],
        "possession": searchFilter['possession'],
        "amenities": searchFilter['amenities'],
        "startBudget": searchFilter['startBudget'],
        "stopBudget": searchFilter['stopBudget'],
        "startCarpetArea": searchFilter['startCarpetArea'],
        "stopCarpetArea": searchFilter['stopCarpetArea'],
        "requirements": requirementsController.text
      }
    };
    final url = Uri.parse('$HOSTNAME/client/client/');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
    print(response.body);
    print(response.statusCode);
    // postNewArea({"name": name, "formatted_version": name});
    if (response.statusCode == 201) {
      Get.back();
      Get.defaultDialog(title: 'Successful', content: const Text('Created successfully'), backgroundColor: Colors.greenAccent);
    }else{
      Get.defaultDialog(title: 'Error', content: const Text('Something Went wrong'), backgroundColor: Colors.redAccent);
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // addUnit();
    // getAreas();
  }
}
