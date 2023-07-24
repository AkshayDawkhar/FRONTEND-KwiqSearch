import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientPage extends StatelessWidget {
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
        body: Container(
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              // Text(
              //   'Client name',
              //   style: TextStyle(fontSize: 30),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.blueAccent[100], border: Border.all(width: 2)),
              //       padding: EdgeInsets.all(6),
              //       child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [Text(' 9730766511'), IconButton(onPressed: () {}, icon: Icon(Icons.call))],
              //       ),
              //     ),
              //     // Container(
              //     //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.blueAccent[100], border: Border.all(width: 2)),
              //     //   padding: EdgeInsets.all(6),
              //     //   child: Row(
              //     //     mainAxisSize: MainAxisSize.min,
              //     //     children: [Text(' 9730766511'), IconButton(onPressed: () {}, icon: Icon(Icons.message))],
              //     //   ),
              //     // ),
              //   ],
              // ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12)),
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
                          'Client Name',
                          style: TextStyle(fontSize: 30),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.message)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.call)),
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
                ),
              ),
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
                        itemCount: 2,
                        itemBuilder: (BuildContext cont, int index) {
                          return Container(
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('12/12/2012'),
                                    Text('01:12 PM'),
                                  ],
                                ),
                                subtitle: Text(
                                    'client meetup on fridayclient meetup on fridayclient meetup on friday'),
                                // trailing: Text('18/01'),
                                leading: Icon(Icons.call),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Get.dialog(AlertDialog(
                                            title: Text('Feed Back'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                DropdownButtonFormField<String>(
                                                  // value: selectedOption,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    // filled: true,
                                                    labelText: 'Response',
                                                    // prefixIcon: Icon(Icons.arrow_drop_down),
                                                  ),
                                                  onChanged: (newValue) {
                                                    // setState(() {
                                                    //   selectedOption = newValue;
                                                    // });
                                                  },
                                                  items: [
                                                    DropdownMenuItem<String>(
                                                      value: '-1',
                                                      child: Text('Cold'),
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      value: '0',
                                                      child: Text('Neutral'),
                                                    ),
                                                    DropdownMenuItem<String>(
                                                      value: '1',
                                                      child: Text('Hot'),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText: 'Feed Back',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {},
                                                  child: Text('ADD'))
                                            ],
                                          ));
                                        },
                                        icon: Icon(Icons.arrow_forward_ios)),
                                  ],
                                ),
                                // style: ,
                              ),
                            ),
                          );
                        }),
                    ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext cont, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blue[200],
                            ),
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.fromLTRB(6, 6, 20, 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // margin: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    child: ListTile(
                                      title: Text('12/12/2012'),
                                      subtitle: Text(
                                          'client meetup on fridayclient meetup on fridayclient meetup on friday'),
                                      // trailing: Text('18/01'),
                                      leading: Icon(Icons.call),
                                      // trailing: Column(
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   children: [
                                      //     IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
                                      //   ],
                                      // ),
                                      // style: ,
                                    ),
                                  ),
                                ),
                                Text(
                                    'this is not the feed back this is not the feed back ')
                              ],
                            ),
                          );
                        }),
                    // Content for Tab 2
                    // Center(child: Text('18/01/2001')),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.dialog(AlertDialog(
                title: Text('Add Follow UP'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'description',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DropdownButtonFormField<String>(
                      // value: selectedOption,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // filled: true,
                        labelText: 'Select an option',
                        // prefixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      onChanged: (newValue) {
                        // setState(() {
                        //   selectedOption = newValue;
                        // });
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
                          value: 'massage',
                          child: Text('Massage'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime(2020),
                            firstDate: DateTime(2019),
                            lastDate: DateTime(2023));
                      },
                      decoration: InputDecoration(
                          hintText: 'Date',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.date_range)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onTap: () {
                        showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 12, minute: 1));
                      },
                      decoration: InputDecoration(
                          hintText: 'Time',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.timer)),
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
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('cansel')),
                  TextButton(onPressed: () {}, child: Text('Add')),
                ],
              ));
            },
            icon: Icon(Icons.add),
            label: Text('Follow Up')),
      ),
    );
  }
}
