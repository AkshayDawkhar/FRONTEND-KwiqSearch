import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/controller/project.dart';

import '../../controller/interested.dart';
import '../../model/add_project.dart';

class ProjectPage extends StatelessWidget {
  var editProjectController = Get.put(EditProjectController(projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));
  var interestedController = Get.put(InterestedController(projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));

  @override
  Widget build(BuildContext context) {
    Widget myContainer(int index) {
      return fixedContainer(
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Enter something";
                    }
                    return null;
                  },
                  decoration: inputDecoration('BHK'),
                  value: double.tryParse(editProjectController.units.elementAt(index)['unit']!.text),
                  hint: const Text('BHK'),
                  items: bhks,
                  onChanged: (value) {
                    editProjectController.units.elementAt(index)['unit']!.text = value.toString();
                  }),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 4,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter something";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: inputDecoration('Carpet Area'),
                controller: editProjectController.units.elementAt(index)['CarpetArea'],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 4,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter something";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                // decoration: inputDecoration('Price ₹ in L'),
                decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder(), suffixText: 'L'),
                controller: editProjectController.units.elementAt(index)['price'],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<EditProjectController>(
          builder: (context) {
            return Text('${editProjectController.projectName.text}');
          }
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'interested') {
                Get.toNamed('/interested', parameters: {'project_id': editProjectController.projectId.toString()});
                // Handle edit action here
                // For example, navigate to edit user screen
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
              } else if (value == 'details') {
                Get.toNamed('/project/edit', parameters: {"project_id": editProjectController.projectId.toString()});
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'interested',
                child: ListTile(leading: Icon(Icons.person_search), iconColor: Colors.blueAccent, title: Text('Interested')),
              ),
              PopupMenuItem<String>(
                value: 'details',
                child: ListTile(leading: Icon(Icons.details), iconColor: Colors.blueAccent, title: Text('Details')),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: ListTile(leading: Icon(Icons.delete), iconColor: Colors.red, title: Text('Delete')),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                    'https://media.istockphoto.com/id/511061090/photo/business-office-building-in-london-england.jpg?s=612x612&w=0&k=20&c=nYAn4JKoCqO1hMTjZiND1PAIWoABuy1BwH1MhaEoG6w='),
              ),
              GetBuilder<InterestedController>(builder: (controller) {
                return Container(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.units.length,
                      itemBuilder: (BuildContext context, int index) {
                        return unitContainer(controller.units.elementAt(index), index);
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
              ),ListTile(
                leading: Text('Project Type :'),
                title: Text('${controller.projectType.text}'),
                trailing: Icon(Icons.home_work_outlined),
              ),
              ListTile(
                leading: Text('Under :'),
                title: Text('${controller.areaIn.text.toUpperCase()}'),
                trailing: Icon(Icons.business),
              ),ListTile(
                leading: Text('LandMark :'),
                title: Text('${controller.landmark.text}'),
                trailing: Icon(Icons.map_outlined),
              ),
              ListTile(
                leading: Text('Possession :'),
                title: Text('${getMonthName(controller.developerMonth)} ${controller.developerYear}'),
                trailing: Icon(Icons.calendar_month),
              ),
              // controller.areas.where((element) => element.value == controller.area.text ? element.child: Container()).first,
            ],
          )),
        );
      }),

    );
  }

  Widget unitContainer(Unit unit, int index) {
    print('----');
    print(unit.floorMap.firstOrNull.runtimeType);
    return Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width:  1),
          color:  Colors.blue[200],
        ),
        child: InkWell(
          onTap: () {
            Get.dialog(
              InteractiveViewer(
              clipBehavior: Clip.none,
              maxScale: 90,
              child: Image.network(
                  '$HOSTNAME${unit.floorMap.firstOrNull!.image}',),
            ),);
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
