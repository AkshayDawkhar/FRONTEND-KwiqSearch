import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../controller/interested.dart';
import '../controller/notification.dart';

class InterestedPage extends StatelessWidget {
  var followupController = Get.put(InterestedController());

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
                children: [
                     controller.isLoad
                        ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: 20,
                        // itemCount: controller.followupNotifications.length,
                        itemBuilder: (BuildContext buildContext, int index) {
                          return Container(
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(12)),
                            child: Text('null'),
                          );
                        })
                        : Center(child: CircularProgressIndicator())

                ],
              )),
        ),
      );
    });
  }
}