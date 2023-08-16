import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class ImageController extends GetxController {
  ImageController({required this.projectID});
  int projectID;

  Future<int> uploadImage(File image) async {
    Map m = {"name": 'akshay','project_id': projectID};
    final url = Uri.parse('$HOSTNAME/home/images/');
    // final response = await http.post(url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(m));
    var request = http.MultipartRequest('POST',url);
    request.fields['project_id'] = projectID.toString();
    request.fields['name'] = 'name';
    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // Field name in the API
        image.path,
      ),
    );
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    print(response.statusCode);
    return response.statusCode;
    // if (response.statusCode == 201) {
    //   Get.back();
    //   Get.defaultDialog(title: 'Successful', content: const Text('Created successfully'), backgroundColor: Colors.greenAccent,textCancel: 'OK');
    // } else {
    //   // Get.defaultDialog(title: 'Error', content: const Text('Something Went wrong'), backgroundColor: Colors.redAccent);
    //   getErrorDialog(response.body);
    // }
    update();
  }
Future<int> uploadUnitImage(File image,int unitID) async {
    final url = Uri.parse('$HOSTNAME/home/FloorMaps/');
    var request = http.MultipartRequest('POST',url);
    request.fields['unit'] = unitID.toString();
    request.fields['name'] = 'name';
    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // Field name in the API
        image.path,
      ),
    );
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    print(response.statusCode);
   return response.statusCode;
    // if (response.statusCode == 201) {
    //   Get.back();
    //   Get.defaultDialog(title: 'Successful', content: const Text('Created successfully'), backgroundColor: Colors.greenAccent,textCancel: 'OK');
    // } else {
    //   // Get.defaultDialog(title: 'Error', content: const Text('Something Went wrong'), backgroundColor: Colors.redAccent);
    //   getErrorDialog(response.body);
    // }
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
