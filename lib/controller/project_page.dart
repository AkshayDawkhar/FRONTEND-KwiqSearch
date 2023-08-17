import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../model/project.dart';

class ProjectDetailsController extends GetxController {
  int projectId;
  late ProjectDetails projectDetails;

  ProjectDetailsController({required this.projectId});

  String imageUrl =
      '$HOSTNAME/media/Images/default/0.png';

  // DateTime rera = DateTime.now();
  // DateTime possession = DateTime.now();

  void get() async {
    final url = Uri.parse('$HOSTNAME/home/project/details/$projectId');
    http.Response responce = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    projectDetails = projectDetailsFromJson(responce.body);
    print('++++++++++++++++++++++++++++++++++++++===========++++++++++++++++++++++=====++===+==++=+++=+++=+++=+++=+++=++==+++=');
    print(projectDetails.toJson());
  }
    @override
    void onInit() {
      // TODO: implement onInit
      super.onInit();
      get();

  }
}
