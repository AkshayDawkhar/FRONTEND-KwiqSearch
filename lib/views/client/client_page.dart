import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeahome/controller/client.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  // Get.toNamed('/interested',parameters: {'project_id':editProjectController.projectId.toString()});
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
                      clientController.deleteClient();
                      print('Delete action confirmed!');
                    },
                    onCancel: () {
                      // Handle the cancel action here (if needed)
                      print('Delete action canceled!');
                    },
                  );
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(leading: Icon(Icons.edit), iconColor: Colors.blueAccent, title: Text('Edit')),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(leading: Icon(Icons.delete), iconColor: Colors.red, title: Text('Delete')),
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
                        clientController.onInit();
                      },
                      child: Text('Add')),
                ],
              ));
            },
            icon: Icon(Icons.add),
            label: Text('Follow Up')),
        bottomNavigationBar: bottomNavigationBar(index: 2,off: true),

      ),
    );
  }

  Widget feedbackContainer(Feedbacks feedback) {
    // Map data = createFollowUPController.getFollowUp(feedback.followUp);
    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Container(
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
              )
            : Center(child: CircularProgressIndicator());
      },
      future: createFollowUPController.getFollowUp(feedback.followUp),
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
                style: TextStyle(fontSize: ((client.fname.length + client.lname.length) < 14) ? 30 : 20, overflow: TextOverflow.ellipsis),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        final Uri url =
                            Uri.parse("whatsapp://send?phone=${'+91' + '${clientController.client.massageNo}'}" + "&text=${Uri.encodeComponent('')}");
                        try {
                          await launchUrl(url);
                        } catch (e) {}
                      },
                      // {
                      //   Get.defaultDialog(
                      //     title: 'message',
                      //     content: Text('message : ${client.massageNo}'),
                      //     confirm: TextButton(
                      //         onPressed: () async {
                      //           final Uri url = Uri.parse(
                      //               "whatsapp://send?phone=${'+91' + '${clientController.client.massageNo}'}" + "&text=${Uri.encodeComponent('')}");
                      //           try {
                      //             // launch(whatsappUrl);
                      //             await launchUrl(url);
                      //           } catch (e) {
                      //             //To handle error and display error message
                      //             // Helper.errorSnackBar(
                      //             //     context: context, message: "Unable to open whatsapp");
                      //           }
                      //         },
                      //         child: Text('message')),
                      //     cancel: TextButton(onPressed: () {}, child: Text('cancel')),
                      //   );
                      // },
                      icon: Icon(Icons.message)),
                  IconButton(
                      onPressed: () async {
                        String phoneNumber = "${clientController.client.phoneNo}";

                        // Use the 'tel' link to make a phone call.
                        // String url = "tel:$phoneNumber";
                        final Uri url = Uri(scheme: 'tel', path: phoneNumber);

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch phone call';
                        }
                      },
                      icon: Icon(Icons.call)),
                ],
              ),
            ],
          ),
          Text(
            'Area : ${clientController.client.searchFilter.area.join(', ')}', /*style: TextStyle(overflow: TextOverflow.ellipsis),*/
          ),
          Text(
              'Budget : ${numberToLCr(clientController.client.searchFilter.startBudget)} - ${numberToLCr(clientController.client.searchFilter.stopBudget)} '),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Unit : ${clientController.client.searchFilter.units.map((e) => unitToName(e)).toList().join(',')}'),
                  Text(
                      'Carpet Area : ${clientController.client.searchFilter.startCarpetArea.round()} - ${clientController.client.searchFilter.stopCarpetArea.round()} '),
                ],
              ),
              IconButton(
                  onPressed: () {
                    Get.toNamed('/search',parameters: {'search_filter':clientController.client.searchFilter.id.toString()});
                  },
                  icon: Icon(Icons.search))
            ],
          ),
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
                              clientController.onInit();
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
