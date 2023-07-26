import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/controller/home.dart';
import 'package:takeahome/model/unit.dart';
import 'package:takeahome/views/map_page.dart';

import '../model/room.dart';

class HomePage extends StatelessWidget {
  UnitController unitController = Get.put(UnitController());
  FilterController filterController = Get.put(FilterController());

  // List<String> amenities = [
  List<String> places = [
    'Mamurdi',
    'Gahunje',
    'Kiwale',
    'Ravet',
    'Akurdi',
    'Punawale',
    'Tathawade',
    'Kasarsai',
    'Wakad',
    'Marunji',
    'Hinjawadi Phase 1',
    'Hinjawadi Phase 2',
    'Hinjawadi Phase 3',
    'Pimple Saudagar',
    'Pimple Gurav',
    'New Sanghavi',
    'Pimple Nilakh',
    'Balewadi',
    'Baner',
    'Sus',
    'Mahalunge',
    'Pashan',
    'Bavdhan',
    'Warje',
    'Kothrud',
    'Aundh'
  ];

  List<MultiSelectItem<double>> bhks = [
    MultiSelectItem(0.5, 'RK'),
    MultiSelectItem(1, '1 BHK'),
    MultiSelectItem(1.5, '1.5 BHK'),
    MultiSelectItem(2, '2 BHK'),
    MultiSelectItem(2.5, '2.5 BHK'),
    MultiSelectItem(3, '3 BHK'),
    MultiSelectItem(3.5, '3.5 BHK'),
    MultiSelectItem(4, '4 BHK'),
    MultiSelectItem(4.5, '4.5 BHK'),
    MultiSelectItem(5, '5 BHK'),
    MultiSelectItem(6, '6 BHK'),
  ];

  List<MultiSelectItem<String>> durations = [
    MultiSelectItem('0', 'Ready To Move'),
    MultiSelectItem('0.6', '6 month'),
    MultiSelectItem('1', '1 Year'),
    MultiSelectItem('1.5', '1.5 Years'),
    MultiSelectItem('2', '2 Year'),
    MultiSelectItem('2.5', '2.5 Year'),
    MultiSelectItem('3', '3 Year'),
    MultiSelectItem('99999', '3+ Year'),
  ];

  List<MultiSelectItem<String>> amenities = [
    MultiSelectItem('All Amenities', 'All Amenities'),
    MultiSelectItem('No Amenities', 'No Amenities'),
    MultiSelectItem('Basic Amenities', 'Basic Amenities'),
    MultiSelectItem('EV charging point', 'EV charging point'),
  ];

  var sp;

  int min = 3500000;

  int max = 50000000;

  RangeValues v = RangeValues(3500000, 30000000);

  RangeValues cpv = RangeValues(300, 3000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: ListTile(
                  leading: Icon(Icons.person_add_alt_1),
                  // iconColor: Colors.blueAccent,
                  // textColor: Colors.blueAccent,
                  title: Text('Add Client'),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.add_home_work_sharp),
                  // iconColor: Colors.greenAccent,
                  // textColor: Colors.greenAccent,
                  title: Text('Add project'),
                ),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Get.toNamed('/client-page');
              // print("Done");
            } else if (value == 1) {
              Get.toNamed('/add-project');
              // print("Work");
            } else if (value == 2) {
              print("Delete");
            }
          })
        ],
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // backgroundColor: Colors.,
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        onRefresh: () => unitController.fetchUnits(),
        child: SingleChildScrollView(
          child: Column(
            children: [

              GetBuilder<FilterController>(
                builder: (controller) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return MultiSelectDialog(
                                        items: places.map((e) => MultiSelectItem(e, e)).toList(),
                                        initialValue: controller.selectedAreas,
                                        onConfirm: (values) {
                                          controller.updateSelectedAreas(values);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text('Area'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return MultiSelectDialog(
                                        items: bhks,
                                        initialValue: controller.selectedUnits,
                                        onConfirm: (values) {
                                          controller.updateSelectedUnits(values as List<String>);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text('unit'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Add the remaining parts of the form similarly
                      // including RangeSliders for 'possession' and 'Amenities'
                      // ...
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return MultiSelectDialog(
                                        items: durations,
                                        initialValue: controller.selectedDurations,
                                        onConfirm: (values) {
                                          controller.updateSelectedDurations(values);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text('possession'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return MultiSelectDialog(
                                        items: amenities,
                                        initialValue: controller.selectedAmenities,
                                        onConfirm: (values) {
                                          controller.updateSelectedAmenities(values);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text('Amenities'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Use the variables from the controller for displaying selected values
                      Text('Budget ${numberToLCr(controller.budgetRange.start)}-${numberToLCr(controller.budgetRange.end)}'),
                      Row(
                        children: [
                          Text(' 35 L'),
                          Expanded(
                            child: RangeSlider(
                              divisions: 53,
                              values: controller.budgetRange,
                              onChanged: (RangeValues value) {
                                controller.updateBudgetRange(value);
                              },
                              min: 3500000,
                              max: 30000000,
                              labels: RangeLabels(
                                '${numberToLCr(controller.budgetRange.start)}',
                                '${numberToLCr(controller.budgetRange.end)}',
                              ),
                            ),
                          ),
                          Text('3 Cr'),
                        ],
                      ),
                      Text('Carpet Area'),
                      Row(
                        children: [
                          Text(' 300'),
                          Expanded(
                            child: RangeSlider(
                              divisions: 188,
                              values: controller.carpetAreaRange,
                              onChanged: (RangeValues value) {
                                controller.updateCarpetAreaRange(value);
                              },
                              min: 300,
                              max: 5000,
                              labels: RangeLabels(
                                '${controller.carpetAreaRange.start.toInt()}',
                                '${controller.carpetAreaRange.end.toInt()}',
                              ),
                            ),
                          ),
                          Text('50000'),
                        ],
                      ),
                    ],
                  );
                },
              ),
              GetBuilder<UnitController>(builder: (controller) {
                // controller.fetchUnits();
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.units.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Unit unit = controller.units.elementAt(index);
                      Flat flat = dummyFlats.elementAt(index);
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.deepPurple[100],
                          ),
                          margin: EdgeInsets.all(6),
                          child: ListTile(
                            onTap: () {
                              // Get.dialog(entryDialog(entry));
                            },
// style: ListTileStyle.drawer,
// dense: true,
                            leading: Icon(Icons.location_on),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${unit.projectName}'),
                                Text('${unit.area}'),
                              ],
                            ),
                            subtitle:
                                Text('${unit.unit} BHK       ${unit.carpetArea} sqft\n${monthDate(unit.rera)}                     | ₹ ${unit.price}'),
                            isThreeLine: true,
//                         trailing: Icon(
//                           Icons.arrow_forward_ios_outlined,
// // color: Colors.redAccent,
//                         ),
                          ));
                      // return Text(dummyFlats.elementAt(index).name);
                    });
              })
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(heroTag: null,onPressed: (){Get.to(MapPage());},child: Icon(Icons.location_on),),
          SizedBox(height: 10,),
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {

            },
            icon: Icon(Icons.search),
            label: Text('Search'),
          ),

        ],
      ),
    );
  }
}

String dateToString(DateTime dateTime) {
  return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
}

String monthDate(DateTime dateTime) {
  return '${getMonthName(dateTime.month)} ${dateTime.year}';
}

String getMonthName(int monthNumber) {
  switch (monthNumber) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "-";
  }
}
