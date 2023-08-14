import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/controller/project.dart';

import '../../controller/interested.dart';
import '../../model/add_project.dart';

class ImagePage extends StatelessWidget {
  var editProjectController = Get.put(EditProjectController(projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));
  var interestedController = Get.put(InterestedController(projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<EditProjectController>(builder: (context) {
          return Text('${editProjectController.projectName.text}');
        }),
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
              Stack(
                alignment: Alignment.bottomRight, // Align items to the right bottom corner
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://media.istockphoto.com/id/511061090/photo/business-office-building-in-london-england.jpg?s=612x612&w=0&k=20&c=nYAn4JKoCqO1hMTjZiND1PAIWoABuy1BwH1MhaEoG6w=',
                      width: double.infinity,
                      // height: 200, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 1, // Adjust the position as needed
                    right: 1,// Adjust the position as needed
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle edit button press
                          },
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                          child: Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete button press
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              GetBuilder<InterestedController>(builder: (controller) {
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.units.length,
                    itemBuilder: (BuildContext context, int index) {
                      return unitContainer(controller.units.elementAt(index), index);
                    });
              }),
              // hint: const Text('Area'),
              // items: controller.areas,
              // value: controller.area.text == '' ? null : controller.area.text,
              // onChanged: (value) {
              //   controller.area.text = value!;
              // }
              // controller.areas.where((element) => element.value == controller.area.text ? element.child: Container()).first,
            ],
          )),
        );
      }),
    );
  }

  Widget unitContainer(Unit unit, int index) => Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2),
          color: Colors.blue[200],
        ),
        child: InkWell(
          onTap: () {
            Get.dialog(
              InteractiveViewer(
                clipBehavior: Clip.none,
                maxScale: 90,
                child: Image.network('https://upload.wikimedia.org/wikipedia/commons/9/9a/Sample_Floorplan.jpg'),
              ),
            );
            // interestedController.switchUnit(index, unit.id);
          },
          child: Column(
            children: [
              Text(' ${unitToName(unit.unit)} | ${unit.carpetArea} sqft | ${numberToLCr(unit.price.toDouble())}'),
              Stack(
                alignment: Alignment.bottomRight, // Align items to the right bottom corner
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/9/9a/Sample_Floorplan.jpg',
                      width: double.infinity,
                      // height: 200, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 1, // Adjust the position as needed
                    right: 1, // Adjust the position as needed
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle edit button press
                          },
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                          child: Icon(Icons.delete),
                          onPressed: () {
                            // Handle delete button press
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
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

Container fixedContainer({required Widget child}) => Container(
      padding: const EdgeInsets.all(12),
      child: child,
    );

InputDecoration inputDecoration(String label) => InputDecoration(border: const OutlineInputBorder(), labelText: label);
AlertDialog saveDialog = AlertDialog(
  title: const Text('Conform save'),
  actions: [
    TextButton(onPressed: () {}, child: const Text('Save and Add Unit')),
    TextButton(
        onPressed: () {
          Get.back();
          // Get.back();
        },
        child: const Text('Save'))
  ],
);
