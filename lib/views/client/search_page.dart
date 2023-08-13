import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/controller/search.dart';
import 'package:takeahome/model/unit.dart';

class SearchPage extends StatelessWidget {
  SearchUnitController searchUnitController = Get.put(SearchUnitController());

  SearchFilterController searchFilterController = Get.put(SearchFilterController(id: int.tryParse(Get.parameters['search_filter'] ?? '') ?? 0));

  // List<String> amenities = [

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          TextButton.icon(
              onPressed: () {
                searchFilterController.editSearchFilter();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              icon: Icon(Icons.done),
              label: Text('Save'))
        ],
      ),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        onRefresh: () async => searchFilterController.onInit(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              GetBuilder<SearchFilterController>(
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
                                        height: 500,
                                        searchable: true,
                                        items:
                                        controller.areas /*places.map((e) => MultiSelectItem(e.toLowerCase().replaceAll(" ", ''), e)).toList()*/,
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
                      // Add the remaining parts of the form similarly
                      // including RangeSliders for 'possession' and 'Amenities'
                      // ...
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: /*ElevatedButton(
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
                              )*/
                              DropdownButtonFormField(
                                  value: controller.selectedDurations,
                                  items: controller.durations,
                                  decoration: InputDecoration(
                                      labelText: 'Possession', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                                  onChanged: (value) {
                                    controller.updateSelectedDurations(value!);
                                  }),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: DropdownButtonFormField(
                                  value: controller.selectedAmenities,
                                  items: controller.amenities,
                                  decoration:
                                  InputDecoration(labelText: 'Amenities', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                                  onChanged: (value) {
                                    controller.updateSelectedAmenities(value!);
                                  }) /*ElevatedButton(
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
                              )*/
                              ,
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
              GetBuilder<SearchUnitController>(builder: (controller) {
                // controller.fetchUnits();
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.recommendedUnit.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      RecommendedUnit unit = controller.recommendedUnit.elementAt(index);
                      // print(unit.toMap());
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: primaryColor200,
                          ),
                          margin: EdgeInsets.all(6),
                          child: ListTile(
                            onTap: () {
                              // Get.dialog(entryDialog(entry));
                              Get.toNamed('/project', parameters: {"project_id": unit.projectId.toString()});
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
                            subtitle: Text(
                                '${unitToName(unit.unit)}       ${unit.carpetArea} sqft\n${monthDate(
                                    unit.possession)}                     | ₹ ${numberToLCr(unit.price.toDouble())} - ${unit.rating}'),
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
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              // Get.toNamed('/map', arguments: {"filteredList": searchUnitController.filteredList, "units": searchUnitController.units});
            },
            child: Icon(Icons.location_on),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {
              searchUnitController.search(selectedAreas: searchFilterController.selectedAreas,
                  selectedUnits: searchFilterController.selectedUnits,
                  selectedDurations: searchFilterController.selectedDurations,
                  selectedAmenities: searchFilterController.selectedAmenities,
                  budgetRange: searchFilterController.budgetRange,
                  carpetAreaRange: searchFilterController.carpetAreaRange);
              // searchUnitController.filterData(
              //   selectedAreas: searchFilterController.selectedAreas,
              //   selectedUnits: searchFilterController.selectedUnits,
              //   startingBudget: searchFilterController.budgetRange.start,
              //   endingBudget: searchFilterController.budgetRange.end,
              //   startingCA: searchFilterController.carpetAreaRange.start,
              //   endingCA: searchFilterController.carpetAreaRange.end,
              //   amenities: searchFilterController.selectedAmenities,
              //   duration: searchFilterController.selectedDurations,
              // );
            },
            icon: Icon(Icons.search),
            label: Text('Search'),
          ),
        ],
      ),
      // bottomNavigationBar: bottomNavigationBar(index: 2,off: true),

    );
  }
}
