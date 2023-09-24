import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/controller/project.dart';
import 'package:takeahome/model/project.dart' as project;
import 'package:url_launcher/url_launcher.dart';

import '../../controller/image.dart';
import '../../controller/interested.dart';
import '../../controller/project_page.dart';
import '../../model/add_project.dart';

class ProjectPage extends StatelessWidget {
  var editProjectController = Get.put(EditProjectController(
      projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));

  var interestedController = Get.put(InterestedController(
      projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));

  var projectDetailsController = Get.put(ProjectDetailsController(
      projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));

  @override
  Widget build(BuildContext context) {
    void sendMassage() async {

      Get.defaultDialog(
          title: 'Link',
          content: Text(editProjectController.urlLink.toString()),
          actions: [TextButton(onPressed: () async{
            final Uri url = Uri.parse(
                "whatsapp://send?text=${Uri.encodeComponent(editProjectController.urlLink.toString())}");
            try {
              await launchUrl(url);
            } catch (e) {}
          }, child: Text('share'))]);

    }

    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<EditProjectController>(builder: (c) {
          return Text('${editProjectController.projectName.text}');
        }),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'interested') {
                Get.toNamed('/interested', parameters: {
                  'project_id': editProjectController.projectId.toString()
                });
              } else if (value == 'delete') {
                // Handle delete action here
                // For example, show a confirmation dialog
                // clientController.deleteClient();
                Get.defaultDialog(
                  title: 'Confirmation',
                  middleText: 'Sure delete?',
                  // confirmTextColor: Colors.white,
                  onConfirm: () {
                    // Perform delete action here
                    // clientController.deleteClient();
                    print('Delete action confirmed!');
                  },
                  onCancel: () {
                    // Handle the cancel action here (if needed)
                    print('Delete action canceled!');
                  },
                );
              } else if (value == 'share') {
                sendMassage();
              } else if (value == 'details') {
                Get.toNamed('/project/edit', parameters: {
                  "project_id": editProjectController.projectId.toString()
                });
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'interested',
                child: ListTile(
                    leading: Icon(Icons.person_search),
                    iconColor: Colors.blueAccent,
                    title: Text('Interested')),
              ),
              PopupMenuItem<String>(
                value: 'details',
                child: ListTile(
                    leading: Icon(Icons.details),
                    iconColor: Colors.blueAccent,
                    title: Text('Details')),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(
                    leading: Icon(Icons.delete),
                    iconColor: Colors.red,
                    title: Text('Delete')),
              ),
              PopupMenuItem<String>(
                value: 'share',
                child: ListTile(
                    leading: Icon(Icons.share),
                    iconColor: Colors.blue,
                    title: Text('share')),
              ),
            ],
          ),
        ],
      ),
      body: GetBuilder<EditProjectController>(builder: (controller) {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          onRefresh: () async {
            controller.onInit();
          },
          child: SingleChildScrollView(
              child: Column(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomImageDialog(id: controller.projectId);
                      });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network('${editProjectController.imageUrl}'),
                ),
              ),
              GetBuilder<InterestedController>(builder: (controller) {
                return Container(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.units.length,
                      itemBuilder: (BuildContext context, int index) {
                        return unitContainer(
                            context, controller.units.elementAt(index), index);
                      }),
                );
              }),
              Divider(),
              // hint: const Text('Area'),
              // items: controller.areas,
              // value: controller.area.text == '' ? null : controller.area.text,
              // onChanged: (value) {
              //   controller.area.text = value!;
              // }
              ListTile(
                leading: Text('Amenities :'),
                title: Text('${controller.amenities.text.toUpperCase()}'),
                trailing: Icon(Icons.pool),
              ),
              ListTile(
                leading: Text('Developer :'),
                title: Text('${controller.developerName.text}'),
                trailing: Icon(Icons.business),
              ),
              ListTile(
                leading: Text('Area :'),
                title: Text('${getFormat(controller.a, controller.area.text)}'),
                trailing: Icon(Icons.location_on_outlined),
              ),
              ListTile(
                leading: Text('Project Type :'),
                title: Text('${controller.projectType.text}'),
                trailing: Icon(Icons.home_work_outlined),
              ),
              ListTile(
                leading: Text('Under :'),
                title: Text('${controller.areaIn.text.toUpperCase()}'),
                trailing: Icon(Icons.business),
              ),
              ListTile(
                leading: Text('LandMark :'),
                title: Text('${controller.landmark.text}'),
                trailing: Icon(Icons.map_outlined),
              ),
              ListTile(
                leading: Text('Possession :'),
                title: Text(
                    '${getMonthName(controller.developerMonth)} ${controller.developerYear}'),
                trailing: Icon(Icons.calendar_month),
              ),
              // controller.areas.where((element) => element.value == controller.area.text ? element.child: Container()).first,
            ],
          )),
        );
      }),
    );
  }

  Widget unitContainer(BuildContext context, Unit unit, int index) {
    print('----');
    print(unit.floorMap.firstOrNull.runtimeType);
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1),
        color: Colors.blue[200],
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return BottomUnitImageDialog(id: unit.id);
              });

          // Get.dialog(
          //   InteractiveViewer(
          //     clipBehavior: Clip.none,
          //     maxScale: 90,
          //     child: Image.network(
          //       '$HOSTNAME${unit.floorMap.firstOrNull!.image}',
          //     ),
          //   ),
          // );
          // interestedController.switchUnit(index, unit.id);
        },
        child: AspectRatio(
          aspectRatio: 1.2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(unitToName(unit.unit)),
              Text('${unit.carpetArea} sqft'),
              Text(numberToLCr(unit.price.toDouble())),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomImageDialog extends StatelessWidget {
  int id;

  BottomImageDialog({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageController = Get.put(ImageController(projectID: id));
    imageController.getProjectImage(id);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(' Images'),
          Expanded(
            child: GetBuilder<ImageController>(
                init: ImageController(projectID: id),
                builder: (controller) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      shrinkWrap: true,
                      itemCount: controller.projectImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        project.ProjectImage image =
                            controller.projectImages.elementAt(index);
                        return InkWell(
                          onTap: () {
                            Get.dialog(
                              InteractiveViewer(
                                clipBehavior: Clip.none,
                                maxScale: 90,
                                child: Image.network(
                                  '$HOSTNAME${image.image}',
                                ),
                              ),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.all(6),
                              child: Image.network(
                                '$HOSTNAME${image.image}',
                                fit: BoxFit.cover,
                              )),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}

class BottomUnitImageDialog extends StatelessWidget {
  int id;

  BottomUnitImageDialog({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageController = Get.put(ImageController(projectID: id));
    imageController.getUnitImage(id);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(' Images'),
          Expanded(
            child: GetBuilder<ImageController>(
                init: ImageController(projectID: id),
                builder: (controller) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      shrinkWrap: true,
                      itemCount: controller.unitImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        project.FloorMap image =
                            controller.unitImages.elementAt(index);
                        return InkWell(
                          onTap: () {
                            Get.dialog(
                              InteractiveViewer(
                                clipBehavior: Clip.none,
                                maxScale: 90,
                                child: Image.network(
                                  '$HOSTNAME${image.image}',
                                ),
                              ),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.all(6),
                              child: Image.network(
                                '$HOSTNAME${image.image}',
                                fit: BoxFit.cover,
                              )),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}

String getFormat(List<dynamic> fields, String value) {
  String a = '';
  fields.forEach((element) {
    if (element['formatted_version'] == value) {
      print(element);
      a = element['name'];
      return;
    }
  });
  return a;
}
