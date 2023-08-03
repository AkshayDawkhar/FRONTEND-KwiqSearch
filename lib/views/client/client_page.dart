import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeahome/controller/client.dart';

import '../../constants.dart';
import '../../model/client.dart';

class ClientPage extends StatelessWidget {
  var clientController = Get.put(ClientController(id: int.tryParse(Get.parameters['client_id'] ?? '') ?? 0));

  var createFollowUPController = Get.put(CreateFollowUPController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('client'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  // Handle edit action here
                  // For example, navigate to edit user screen
                } else if (value == 'delete') {
                  // Handle delete action here
                  // For example, show a confirmation dialog
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit User'),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete User'),
                ),
              ],
            ),
          ],
        ),
        body: GetBuilder<ClientController>(
            builder: (controller) => controller.isLoad
                ? Container(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      children: [
                        clientContainer(controller.client),

                        // Divider(),
                        TabBar(
                          tabs: [
                            Tab(
                              text: 'Follow UP',
                            ),
                            Tab(
                              text: 'Feed Back',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Content for Tab 1
                              ListView.builder(
                                  itemCount: controller.client.followups.length,
                                  itemBuilder: (BuildContext cont, int index) {
                                    return Container(
                                      margin: EdgeInsets.all(12),
                                      decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(12)),
                                      child: followUpListTile(controller.client.followups.elementAt(index)),
                                    );
                                  }),
                              ListView.builder(
                                  itemCount: controller.client.feedback.length,
                                  itemBuilder: (BuildContext cont, int index) {
                                    return feedbackContainer(controller.client.feedback.elementAt(index));
                                  }),
                              // Content for Tab 2
                              // Center(child: Text('18/01/2001')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator())),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.dialog(AlertDialog(
                title: Text('Add Follow UP'),
                content: GetBuilder<CreateFollowUPController>(builder: (controller) {
                  return Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: controller.message,
                          decoration: InputDecoration(hintText: 'description', border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        DropdownButtonFormField<String>(
                          value: controller.action.text == '' ? null : controller.action.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            // filled: true,
                            labelText: 'Select an option',
                            // prefixIcon: Icon(Icons.arrow_drop_down),
                          ),
                          onChanged: (newValue) {
                            controller.action.text = newValue!;
                            // setState(() {
                            //   selectedOption = newValue;
                            // });
                            // controller
                          },
                          items: [
                            DropdownMenuItem<String>(
                              value: 'call',
                              child: Text('Call'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'visit',
                              child: Text('Visit'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'message',
                              child: Text('Message'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: TextEditingController(text: dateToString(controller.date)),
                          onTap: () async {
                            controller.getDate((await showDatePicker(
                                context: context, initialDate: controller.date, firstDate: DateTime(2019), lastDate: DateTime(2030)))!);
                            // controller.date = ;
                          },
                          decoration: InputDecoration(hintText: 'Date', border: OutlineInputBorder(), prefixIcon: Icon(Icons.date_range)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: TextEditingController(text: formatTimeOfDay(controller.time)),
                          onTap: () async {
                            controller.time = (await showTimePicker(context: context, initialTime: controller.time))!;
                            // print(a);
                            // DateTime b = DateTime
                          },
                          decoration: InputDecoration(hintText: 'Time', border: OutlineInputBorder(), prefixIcon: Icon(Icons.timer)),
                        ),
                        // InkWell(
                        //   onTap: () {},
                        //   child: Row(
                        //     children: [
                        //       /*IconButton(onPressed: (){},icon:*/ Icon(Icons.calendar_month),
                        //       /*IconButton(onPressed: (){},icon: */ Icon(Icons.timer),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  );
                }),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('cancel')),
                  TextButton(
                      onPressed: () {
                        createFollowUPController.send(clientController.id);
                      },
                      child: Text('Add')),
                ],
              ));
            },
            icon: Icon(Icons.add),
            label: Text('Follow Up')),
      ),
    );
  }

  Widget feedbackContainer(Feedbacks feedback) {
    // Map data = createFollowUPController.getFollowUp(feedback.followUp);
    return FutureBuilder(
      builder: (context, snapshot) {

        return snapshot.hasData? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue[200],
            ),
            margin: EdgeInsets.all(6),
            // padding: EdgeInsets.fromLTRB(6, 6, 20, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    child: feedbackFollowUpListTile(snapshot.data!),
                  ),
                ),
                Text(' ${feedback.response} - ${feedback.message}'),
              ],
            ),
          ) : Center(child: CircularProgressIndicator());
      }, future: createFollowUPController.getFollowUp(feedback.followUp),
    );
  }

  Widget clientContainer(Client client) => Container(
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${client.fname} ${client.lname}',
                style: TextStyle(fontSize: 30),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'message',
                          content: Text('message : ${client.massageNo}'),
                          confirm: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('message')),
                          cancel: TextButton(onPressed: () {}, child: Text('cancel')),
                        );
                      },
                      icon: Icon(Icons.message)),
                  IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'call',
                          content: Text('call : ${client.phoneNo}'),
                          confirm: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('call')),
                          cancel: TextButton(onPressed: () {}, child: Text('cancel')),
                        );
                      },
                      icon: Icon(Icons.call)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text('Area : banner, wakad'),
            ],
          ),
          Text('Budget : 50L - 80L'),
          Text('Unit : 2BHK, 3BHK'),
          Text('Carpet Area : 800'),
        ],
      ));

  Widget followUpListTile(Followup followup) => ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dateToString(followup.dateSent)),
            Text(formatTime(followup.dateSent)),
          ],
        ),
        subtitle: Text(followup.message),
        // trailing: Text('18/01'),
        leading: Icon(getActionIcon(followup.actions)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  TextEditingController message = TextEditingController();
                  TextEditingController response = TextEditingController();
                  final formKey = GlobalKey<FormState>();
                  Get.dialog(AlertDialog(
                    title: Text('Feed Back'),
                    content: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownButtonFormField<String>(
                            value: response.text == '' ? null : response.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // filled: true,
                              labelText: 'Response',
                              // prefixIcon: Icon(Icons.arrow_drop_down),
                            ),
                            onChanged: (newValue) {
                              response.text = newValue!;
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: 'cold',
                                child: Text('cold'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'neutral',
                                child: Text('neutral'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'hot',
                                child: Text('hot'),
                              ),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'provide this value';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'provide this value';
                              }
                              return null;
                            },
                            controller: message,
                            decoration: InputDecoration(
                              hintText: 'Feed Back',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            print('object');
                            if (formKey.currentState!.validate()) {
                              clientController.addFeedback(followUp: followup.id, message: message.text, response: response.text);
                            print('valid');
                            Get.back();
                            }
                          },
                          child: Text('ADD'))
                    ],
                  ));
                },
                icon: Icon(Icons.arrow_forward_ios)),
          ],
        ),
        // style: ,
      );
  Widget feedbackFollowUpListTile(Followup followup) => ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dateToString(followup.dateSent)),
            Text(formatTime(followup.dateSent)),
          ],
        ),
        subtitle: Text(followup.message),
        // trailing: Text('18/01'),
        leading: Icon(getActionIcon(followup.actions)),
        // style: ,
      );
}
