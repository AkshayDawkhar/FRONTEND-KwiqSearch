import 'package:flutter/material.dart';
import 'package:takeahome/constants.dart';
import 'package:get/get.dart';
import 'package:takeahome/controller/add_project.dart';
import 'package:takeahome/views/map_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AddProject extends StatelessWidget {
  var newProductController = Get.put(NewProductController());

  @override
  Widget build(BuildContext context) {
    Widget myContainer(int index) {
      return fixedContainer(
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: DropdownButtonFormField(
                  decoration: inputDecoration('BHK'),
                  value: newProductController.bhk.text == null ? null : null,
                  hint: Text('BHK'),
                  items: bhks,
                  onChanged: (value) {
                    newProductController.units.elementAt(index)['unit']!.text =
                        value.toString();
                  }),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 4,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: inputDecoration('Carpet Area'),
                controller:
                    newProductController.units.elementAt(index)['CarpetArea'],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 4,
              child: TextFormField(
                keyboardType: TextInputType.number,
                // decoration: inputDecoration('Price ₹ in L'),
                decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    suffixText: 'L'),
                controller:
                    newProductController.units.elementAt(index)['price'],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Project'),
      ),
      body: GetBuilder<NewProductController>(builder: (controller) {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          onRefresh: () async{},
          child: SingleChildScrollView(
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                fixedContainer(
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                            decoration: inputDecoration('Area'),
                            hint: Text('Area'),
                            items: places
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              controller.area.text = value!;
                            }),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      IconButton(
                          onPressed: () {
                            Get.dialog(AlertDialog(
                              title: Text('Add Area'),
                              content: Form(
                                key: controller.fromKeyAdd,
                                child: TextFormField(
                                  controller: controller.addArea,
                                  decoration: inputDecoration('Name'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter a name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text('cancel')),
                                TextButton(
                                    onPressed: () {
                                      if (controller.fromKeyAdd.currentState!
                                          .validate()) {
                                        controller
                                            .addName(controller.addArea.text);
                                        Get.back();
                                      }
                                    },
                                    child: Text('Save'))
                              ],
                            ));
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                ),
                fixedContainer(
                    child: TextFormField(
                  decoration: inputDecoration('Project Name'),
                  controller: controller.projectName,
                )),
                fixedContainer(
                  child: DropdownButtonFormField(
                      decoration: inputDecoration('Project Type'),
                      hint: Text('Project Type'),
                      items: projectType
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.projectType.text = value!;
                      }),
                ),
                fixedContainer(
                    child: TextFormField(
                  decoration: inputDecoration('Developer Name'),
                  controller: controller.developerName,
                )),
                fixedContainer(
                    child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration('Land Parcel'),
                  controller: controller.landParcel,
                )),
                fixedContainer(
                    child: TextFormField(
                  decoration: inputDecoration('Nearing Landmark'),
                  controller: controller.landmark,
                )),
                fixedContainer(
                  child: DropdownButtonFormField(
                      decoration: inputDecoration('Area In'),
                      hint: Text('Area In'),
                      items: areaIn
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.areaIn.text = value!;
                      }),
                ),
                fixedContainer(
                  child: DropdownButtonFormField(
                      decoration: inputDecoration('Water Supply'),
                      hint: Text('Water Supply'),
                      items: waterConnection
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.waterSupply.text = value!;
                      }),
                ),
                fixedContainer(
                    child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration('Lifts'),
                  controller: controller.lifts,
                )),
                fixedContainer(
                    child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration('Floors'),
                  controller: controller.floors,
                )),
                fixedContainer(
                    child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration('Flats per Floors'),
                  controller: controller.flatsPerFloors,
                )),
                fixedContainer(
                  child: Row(
                    children: [
                      Expanded(
                        // flex: 4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration('Total Unit'),
                          controller: controller.totalUnit,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        // flex: 4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration('Available Unit'),
                          controller: controller.availableUnit,
                        ),
                      ),
                    ],
                  ),
                ),
                CheckboxListTile(
                  value: controller.readyToMove,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    controller.setReadyToMove(value!);
                  },
                  // secondary: Icon(Icons.),
                  title: Text('Ready to Move'),
                ),
                // fixedContainer(
                //   child: Row(
                //     children: [
                //       Expanded(
                //         // flex: 4,
                //         child: TextFormField(
                //           keyboardType: TextInputType.number,
                //           onTap: () {
                //             showDatePicker(
                //               context: context,
                //               initialDate: controller.rera,
                //               firstDate: DateTime.now(),
                //               lastDate: DateTime(2035),
                //             ).then((date) {
                //               if (date != null) {
                //                 controller.setRERA(date);
                //               }
                //             });
                //           },
                //           enabled: !controller.readyToMove,
                //           decoration: inputDecoration('RERA possession'),
                //           controller: controller.reraController,
                //         ),
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       Expanded(
                //         // flex: 4,
                //         child: TextFormField(
                //           keyboardType: TextInputType.number,
                //           enabled: !controller.readyToMove,
                //           decoration: inputDecoration('Builder Possession'),
                //           controller: controller.possessionController,
                //           onTap: () {
                //             showDatePicker(
                //               context: context,
                //               initialDate: controller.possession,
                //               firstDate: DateTime.now(),
                //               lastDate: DateTime(2035),
                //             ).then((date) {
                //               if (date != null) {
                //                 controller.setPossession(date);
                //               }
                //             });
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                controller.readyToMove
                    ? Text('Ready To Move')
                    : fixedContainer(
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                  decoration: inputDecoration('Month'),
                                  value: controller.amenities.text == null
                                      ? null
                                      : null,
                                  hint: Text('RERA'),
                                  items: months,
                                  onChanged: (value) {
                                    // controller.amenities.text = value.toString();
                                    controller.reraMonth = value!;
                                  }),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  decoration: inputDecoration('YEAR'),
                                  value: controller.amenities.text == null
                                      ? null
                                      : null,
                                  hint: Text('RERA'),
                                  items: years
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e.toString())))
                                      .toList(),
                                  onChanged: (value) {
                                    // controller.amenities.text = value.toString();
                                    controller.reraYear = value!;
                                  }),
                            ),
                          ],
                        ),
                      ),
                controller.readyToMove
                    ? Text('Ready To Move')
                    : fixedContainer(
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                  decoration: inputDecoration('Month'),
                                  // value:
                                  // controller.rera.month == null ? null : null,
                                  hint: Text('Developer'),
                                  items: months,
                                  onChanged: (value) {
                                    // controller.rera = value;
                                    controller.developerMonth = value!;
                                  }),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  decoration: inputDecoration('YEAR'),
                                  value: controller.amenities.text == null
                                      ? null
                                      : null,
                                  hint: Text('Developer'),
                                  items: years
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e.toString())))
                                      .toList(),
                                  onChanged: (value) {
                                    controller.developerYear = value!;
                                    // controller.amenities.text = value.toString();
                                  }),
                            ),
                          ],
                        ),
                      ),
                fixedContainer(
                  child: DropdownButtonFormField(
                      decoration: inputDecoration('Amenities'),
                      value: controller.amenities.text == null ? null : null,
                      hint: Text('Amenities'),
                      items: amenities
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        controller.amenities.text = value.toString();
                      }),
                ),
                fixedContainer(
                  child: DropdownButtonFormField(
                      decoration: inputDecoration('Parking'),
                      value: controller.parking.text == null ? null : null,
                      hint: Text('Parking'),
                      items: parking
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        controller.parking.text = value.toString();
                      }),
                ),
                // fixedContainer(
                //     child: TextFormField(
                //   decoration: inputDecoration('location'),
                //   controller: controller.location,
                // )),
                CheckboxListTile(
                  value: controller.transport,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    controller.setTransport(value!);
                  },
                  secondary: Icon(Icons.directions_bus_sharp),
                  title: Text('Public Transport'),
                ),
                CheckboxListTile(
                  value: controller.power,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    controller.setPower(value!);
                  },
                  secondary: Icon(Icons.power),
                  title: Text('Power Backup (Full Building Back up)'),
                ),
                CheckboxListTile(
                  value: controller.goods,
                  controlAffinity: ListTileControlAffinity.leading,
                  secondary: Icon(Icons.grid_on_outlined),
                  onChanged: (value) {
                    controller.setGoods(value!);
                  },
                  // secondary: Icon(Icons.),
                  title: Text('White Goods'),
                ),
                /*CheckboxListTile(
                      value: false,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {},
                      secondary: Icon(Icons.shopping_cart),
                      title: Text('commercial shop '),
                    ),*/
                fixedContainer(
                  child: Row(
                    children: [
                      Expanded(
                        // flex: 4,
                        child: TextFormField(
                          // keyboardType: TextInputType.number,
                          decoration: inputDecoration('Contact Person'),
                          controller: controller.contactPerson,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration('Contact Number'),
                          controller: controller.contactNumber,
                        ),
                      ),
                    ],
                  ),
                ),
                fixedContainer(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration('Market Value'),
                    controller: controller.marketValue,
                  ),
                ),
                fixedContainer(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration('CP brokerage '),
                    controller: controller.brokerage,
                  ),
                ),
                fixedContainer(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration('executive incentive'),
                    controller: controller.incentive,
                  ),
                ),
                // fixedContainer(
                //   child: Row(
                //     children: [
                //       Expanded(
                //         flex: 4,
                //         child: DropdownButtonFormField(
                //             decoration: inputDecoration('BHK'),
                //             value: controller.bhk.text == null ? null : null,
                //             hint: Text('BHK'),
                //             items: bhks,
                //             onChanged: (value) {
                //               controller.bhk.text = value.toString();
                //             }),
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       Expanded(
                //         flex: 4,
                //         child: TextFormField(
                //           keyboardType: TextInputType.number,
                //           decoration: inputDecoration('Carpet Area'),
                //           controller: controller.carpetArea,
                //         ),
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       Expanded(
                //         flex: 4,
                //         child: TextFormField(
                //           keyboardType: TextInputType.number,
                //           decoration: inputDecoration('Price ₹'),
                //           controller: controller.price,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                ListView.builder(
                    itemCount: controller.units.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return myContainer(index);
                    }),
                Divider(),
                fixedContainer(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.addUnit();
                        },
                        icon: Icon(Icons.remove)),
                    IconButton(
                        onPressed: () {
                          controller.addUnit();
                        },
                        icon: Icon(Icons.add)),
                  ],
                )),

                // SizedBox(
                //   height: 200,
                //   child: fixedContainer(
                //     child: TextFormField(
                //       maxLines: null,
                //       minLines: null,
                //       expands: true,
                //       // keyboardType: TextInputType.number,
                //       decoration: inputDecoration('OutPut'),
                //       controller: controller.output,
                //     ),
                //   ),
                // SizedBox(
                //   child: MapPicker(),
                //   height: 520,
                //   width: 520,
                // ),
                fixedContainer(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration('longitude'),
                          controller: controller.longitude,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration('latitude'),
                          controller: controller.latitude,
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.location_searching))
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),

                SizedBox(
                    height: 200,
                    child: fixedContainer(
                      child: TextFormField(
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        // keyboardType: TextInputType.number,
                        decoration: inputDecoration('OutPut'),
                        controller: controller.output,
                      ),
                    )),
              ],
            )),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Get.dialog(AlertDialog(
            title: Text('Conform save'),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                    newProductController.saveAndEdit();
                  },
                  child: Text('Save and Add Unit')),
              TextButton(
                  onPressed: () {
                    newProductController.getOutput();
                    Get.back();
                    // Get.back();
                  },
                  child: Text('Save'))
            ],
          ));
          // newProductController.saveAndEdit();
        },
        icon: Icon(Icons.add),
        label: Text('save'),
      ),
    );
  }
}
// TextFormField outlineDecorationField(String label) =>
//     TextFormField(
//       decoration:
//       InputDecoration(border: OutlineInputBorder(), labelText: label),
//     );

Container fixedContainer({required Widget child}) => Container(
      padding: EdgeInsets.all(12),
      child: child,
    );

InputDecoration inputDecoration(String label) =>
    InputDecoration(border: OutlineInputBorder(), labelText: label);
AlertDialog saveDialog = AlertDialog(
  title: Text('Conform save'),
  actions: [
    TextButton(onPressed: () {}, child: Text('Save and Add Unit')),
    TextButton(
        onPressed: () {
          Get.back();
          // Get.back();
        },
        child: Text('Save'))
  ],
);
