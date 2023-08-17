import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:takeahome/model/project.dart';

import '../constants.dart';

class ImageController extends GetxController {
  ImageController({required this.projectID});

  int projectID;
  List<ProjectImage> projectImages = [];
  List<FloorMap> unitImages = [];

  Future<int> uploadImage(File image,int projectID) async {
    // Map m = {"name": 'akshay', 'project_id': projectID};
    final url = Uri.parse('$HOSTNAME/home/images/');
    // final response = await http.post(url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(m));
    var request = http.MultipartRequest('POST', url);
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
    // onInit();
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

  Future<int> updateImage(File image,int projectID ,int imageID) async {
    final url = Uri.parse('$HOSTNAME/home/image/$imageID/');
    // final response = await http.post(url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(m));
    var request = http.MultipartRequest('PUT', url);
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
    // onInit();
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
Future<int> updateUnitImage(File image,int unitID ,int imageID) async {
    final url = Uri.parse('$HOSTNAME/home/FloorMap/$imageID/');
    // final response = await http.post(url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(m));
    var request = http.MultipartRequest('PUT', url);
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
    // onInit();
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

  Future<int> uploadUnitImage(File image, int unitID) async {
    final url = Uri.parse('$HOSTNAME/home/FloorMaps/');
    var request = http.MultipartRequest('POST', url);
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

  Future<int> deleteUnitImage(int imageID) async {
    final url = Uri.parse('$HOSTNAME/home/FloorMap/$imageID/');
    http.Response response = await http.delete(url);
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

  Future<int> deleteProjectImage(int imageID) async {
    final url = Uri.parse('$HOSTNAME/home/image/$imageID/');
    http.Response response = await http.delete(url);
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

  void getProjectImage(int projectID) async {
    final url = Uri.parse('$HOSTNAME/home/images/project/$projectID');
    http.Response responce = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    projectImages = projectImageFromJson(responce.body);
    print(responce.body);
    update();
  }

  void getUnitImage(int unitID) async {
    final url = Uri.parse('$HOSTNAME/home/images/unit/$unitID');
    http.Response responce = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    unitImages = floorMapFromJson(responce.body);
    print(responce.body);
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
