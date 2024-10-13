import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/controller/home.dart';
import 'package:takeahome/model/unit.dart';

class SearchHomePage extends StatelessWidget {
  UnitController unitController = Get.put(UnitController());

  FilterController filterController = Get.put(FilterController());

  FloatingActionButton floatingActionButton() => FloatingActionButton(
        onPressed: () {
          Get.toNamed('/map', arguments: {"filteredList": unitController.filteredList, "units": unitController.units});
        },
        child: Icon(Icons.location_on),
      );

  @override
  Widget build(BuildContext context) {
    void bottomSheet() {
      showModalBottomSheet(
          backgroundColor: Colors.blueGrey[100],
          context: context,
          builder: (c) {
            return GetBuilder<FilterController>(
              builder: (controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(fontSize: 30),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  filterController.setDefault();
                                },
                                child: Text('Clear'),
                                style: TextButton.styleFrom(foregroundColor: Colors.red),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  filterController.search();
                                  unitController.filterData(
                                    selectedAreas: filterController.selectedAreas,
                                    selectedUnits: filterController.selectedUnits,
                                    startingBudget: filterController.budgetRange.start,
                                    endingBudget: filterController.budgetRange.end,
                                    startingCA: filterController.carpetAreaRange.start,
                                    endingCA: filterController.carpetAreaRange.end,
                                    amenities: filterController.selectedAmenities,
                                    duration: filterController.selectedDurations,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text('Search'),
                                style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                                      height: 500,
                                      searchable: true,
                                      items: controller.areas /*places.map((e) => MultiSelectItem(e.toLowerCase().replaceAll(" ", ''), e)).toList()*/,
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
                                      height: 500,
                                      items: controller.bhks,
                                      initialValue: controller.selectedUnits,
                                      onConfirm: (values) {
                                        controller.updateSelectedUnits(values);
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

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                                value: controller.duration,
                                items: controller.durations,
                                decoration:
                                    InputDecoration(labelText: 'Possession', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                                onChanged: (value) {
                                  controller.updateSelectedDurations(value!);
                                  // controller.duration = value.toString();
                                }),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField(
                                value: controller.amenity,
                                items: controller.amenities,
                                decoration:
                                    InputDecoration(labelText: 'Amenities', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                                onChanged: (value) {
                                  controller.updateSelectedAmenities(value!);
                                }),
                          ),
                        ],
                      ),
                    ),
                    // Use the variables from the controller for displaying selected values
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('   35 L'),
                        Text('Budget ${numberToLCr(controller.budgetRange.start)} - ${numberToLCr(controller.budgetRange.end)}'),
                        Text('3 Cr  '),
                      ],
                    ),
                    RangeSlider(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('  300'),
                        Text('Carpet Area ${controller.carpetAreaRange.start.round()} - ${controller.carpetAreaRange.end.round()}'),
                        Text('50000   '),
                      ],
                    ),
                    RangeSlider(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [],
                    )
                  ],
                );
              },
            );
          });
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Column(
          children: [
            Container(
              color: Colors.blueGrey[50],
              child: SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GetBuilder<UnitController>(builder: (context) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: unitController.filters.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
                                  child: Center(child: Text('  ${unitController.filters.elementAt(index)}  ')));
                            });
                      }),
                    ),
                    IconButton(
                        onPressed: () {
                          bottomSheet();
                        },
                        icon: Icon(Icons.filter_list))
                  ],
                ),
              ),
            ),
            Expanded(
              child: LiquidPullToRefresh(
                showChildOpacityTransition: false,
                onRefresh: () async {
                  unitController.init();
                  filterController.onInit();
                },
                child: GetBuilder<UnitController>(builder: (controller) {
                  // controller.fetchUnits();
                  print(controller.isLoad);
                  return controller.isLoad
                      ? ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.filteredList.length,
                          // shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            UnitDetails unit = controller.filteredList.elementAt(index);
                            // print(unit.toMap());
                            return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: primaryColor200,
                                ),
                                margin: EdgeInsets.all(6),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    unit.image != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network('$HOSTNAME/${unit.image}'),
                                          )
                                        : Container(),
                                    ListTile(
                                      onTap: () {
                                        Get.toNamed('/project', parameters: {"project_id": unit.projectId.toString()});
                                      },
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${unit.projectName}'),
                                          Text('${unit.area}'),
                                        ],
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${unitToName(unit.unit)}'),
                                              Text('${unit.carpetArea} CA'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${monthDate(unit.possession)} '),
                                              Text('₹ ${numberToLCr(unit.price.toDouble())}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      isThreeLine: true,
                                    ),
                                  ],
                                ));
                            // return Text(dummyFlats.elementAt(index).name);
                          })
                      : Center(child: CircularProgressIndicator());
                }),
              ),
            ),
          ],
        ),
        Positioned(
            bottom: 16,
            right: 76,
            child: FloatingActionButton(
              onPressed: () {
                bottomSheet();
              },
              child: Icon(Icons.filter_list),
            ))
      ],
    );
  }
}
