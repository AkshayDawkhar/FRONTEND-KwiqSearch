import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/model/project.dart';

import '../../controller/client.dart';
import '../../controller/project.dart';
import '../../model/client.dart';

class ProjectsPage extends StatelessWidget {
  var clientsPage = Get.put(ProjectsController());

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ProjectsController>(builder: (controller) {
        if (controller.isLoad) {
          return LiquidPullToRefresh(
            showChildOpacityTransition: false,
            onRefresh: () async {
              controller.onInit();
            },
            child: ListView.builder(
                itemCount: controller.projects.length,
                itemBuilder: (BuildContext context, int index) {
                  return projectContainer(controller.projects.elementAt(index));
                }),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       Get.toNamed('/projects/add');
      //     },
      //     label: Text('Project'),
      //     icon: Icon(Icons.add)),
      // bottomNavigationBar: bottomNavigationBar(index: 1,off: false),

    );
  }

  Widget projectContainer(Projects project) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primaryColor200,
      ),
      margin: EdgeInsets.all(6),
      child: ListTile(
        onTap: () {
          Get.toNamed('/project', parameters: {"project_id": project.id.toString()});
        },
        leading: Icon(Icons.home_work),
        title: Text('${project.projectName} - ${project.developerName}'),
        trailing: Icon(Icons.arrow_forward_ios),
//                         trailing: Icon(
//                           Icons.arrow_forward_ios_outlined,
// // color: Colors.redAccent,
//                         ),
      ));
}
// floatingActionButton: FloatingActionButton.extended(
//     onPressed: () {
//       Get.toNamed('/projects/add');
//     },
//     label: Text('Project'),
//     icon: Icon(Icons.add)),
