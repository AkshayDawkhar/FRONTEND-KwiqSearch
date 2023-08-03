import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../constants.dart';
import '../controller/notification.dart';
import '../model/notification.dart';

class NotificationsPage extends StatelessWidget {
  var followupController = Get.put(FollowupController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowupController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Notification ${controller.done ? 'History' : ''}'),
          actions: [
            IconButton(
                onPressed: () {
                  controller.switchDone();
                },
                icon: controller.done
                    ? Icon(
                        Icons.notifications,
                      )
                    : Icon(Icons.task_alt))
          ],
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
                  Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.blue[50]),
                    child: SfCalendar(
                      showNavigationArrow: true,
                      showTodayButton: true,
                      // minDate: DateTime.now().subtract(Duration(days: 1)),
                      view: CalendarView.month,
                      onTap: (CalendarTapDetails calendarTapDetails) {
                        print(calendarTapDetails.date);
                        controller.targetDate = calendarTapDetails.date!;
                        controller.fetchFollowupNotifications();
                        // print();
                      },
                    ),
                  ),
                  Divider(),
                  GetBuilder<FollowupController>(builder: (controller) {
                    return controller.isLoad
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.followupNotifications.length,
                            itemBuilder: (BuildContext buildContext, int index) {
                              return Container(
                                margin: EdgeInsets.all(12),
                                decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(12)),
                                child: followUpListTile(controller.followupNotifications.elementAt(index)),
                              );
                            })
                        : Center(child: CircularProgressIndicator());
                  }),
                ],
              )),
        ),
      );
    });
  }
}

Widget followUpListTile(FollowupNotification followup) => ListTile(
      onTap: () {
        Get.toNamed('/client', parameters: {'client_id': followup.client.toString()});
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${followup.fname} ${followup.lname}'),
          Text(formatTime(followup.dateSent)),
        ],
      ),
      subtitle: Text(followup.message),
      // trailing: Text('18/01'),
      leading: Icon(getActionIcon(followup.actions)),

      // style: ,
    );
