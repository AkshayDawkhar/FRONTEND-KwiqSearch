import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/model/intrested.dart';

import '../../controller/interested.dart';
import '../../model/add_project.dart';

class InterestedPage extends StatelessWidget {
  var interestedController = Get.put(InterestedController(projectId: int.tryParse(Get.parameters['project_id'] ?? '') ?? 0));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InterestedController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Interested'),
        ),
        body: LiquidPullToRefresh(
          showChildOpacityTransition: false,
          onRefresh: () async {
            controller.onInit();
          } /* unitController.init()*/,
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" Unit Configurations"),
                  Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.units.length,
                        itemBuilder: (BuildContext context, int index) {
                          return unitContainer(controller.units.elementAt(index), index);
                        }),
                  ),
                  Divider(),
                  controller.isLoad
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.interested.length,
                          // itemCount: controller.followupNotifications.length,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return interestedContainer(controller.interested.elementAt(index));
                          })
                      : Center(child: CircularProgressIndicator())
                ],
              )),
        ),
        // bottomNavigationBar: bottomNavigationBar(index: 1,off: true),

      );
    });
  }

  Widget interestedContainer(InterestedModel interestedModel) => Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(12),border: Border.all(color: Colors.blue)),
        child: ListTile(
          onTap:() {
            Get.toNamed('/client', parameters: {'client_id': interestedModel.client.toString()});

          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${interestedModel.fname} ${interestedModel.lname}',
                // style: TextStyle(fontSize: 20),
              ),
              Text('${numberToLCr(interestedModel.startBudget)} - ${numberToLCr(interestedModel.stopBudget)} '),
              // Text('${interestedModel.units.map((e) => unitToName(e)).toList().join(',')}')
            ],
          ),
          isThreeLine: true,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Area :${interestedModel.area.join(', ')}\nUnit :${interestedModel.units.map((e) => unitToName(e)).toList().join(',')}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${interestedModel.startCarpetArea.round()} - ${interestedModel.stopCarpetArea.round()} Carpet'),
                  Text('${interestedModel.rating}'),
                ],
              ),
            ],
          ),
        ),
      );

  Widget unitContainer(Unit unit, int index) => Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
         border: Border.all(width:index == interestedController.selectedUnitIndex? 3 : 1),
          color: index == interestedController.selectedUnitIndex ? Colors.blue : Colors.blue[100],
        ),
        child: InkWell(
          onTap: () {
            interestedController.switchUnit(index, unit.id);
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
