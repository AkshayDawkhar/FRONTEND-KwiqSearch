import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:takeahome/controller/home.dart';

import '../model/room.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  int min=3500000;
  int max=50000000 ;
  RangeValues v = RangeValues(3500000, 30000000);
  RangeValues cpv = RangeValues(300, 3000);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // backgroundColor: Colors.,
      ),
      body: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.all(12),
          //   child: Row(
          //     children: [
          //       Expanded(
          //           child:  DropdownButtonFormField(
          //             decoration: InputDecoration(
          //               enabledBorder: OutlineInputBorder(
          //                   borderSide: BorderSide(
          //                       color: Colors.deepPurpleAccent, width: 2),
          //                   borderRadius: BorderRadius.circular(20)
          //               ),
          //               focusedBorder: OutlineInputBorder(
          //                   borderSide: BorderSide(
          //                       color: Colors.black, width: 2),
          //                   borderRadius: BorderRadius.circular(20)),
          //               filled: true,
          //             ),
          //             onChanged: (value) {},
          //             items: ['a', 'b', 'c']
          //                 .map((e) => DropdownMenuItem(
          //               child: Text(e),
          //               value: e,
          //             ))
          //                 .toList(),
          //           )),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       ElevatedButton(onPressed: () {}, child: Text('search'))
          //     ],
          //   ),
          // ),
          Container(
            // margin: EdgeInsets.all(12),
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
                                initialValue: [],
                                onConfirm: (values) {},
                              );
                            },
                          );
                        },
                        child: Text('Area'))),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog(
                                items: bhks,
                                initialValue: [],
                                onConfirm: (values) {},
                              );
                            },
                          );
                        },
                        child: Text('unit'))),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            // margin: EdgeInsets.all(12),
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
                                initialValue: [],
                                onConfirm: (values) {},
                              );
                            },
                          );
                        },
                        child: Text('possession'))),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog(
                                items: amenities,
                                initialValue: [],
                                onConfirm: (values) {},
                              );
                            },
                          );
                        },
                        child: Text('Amenities'))/*InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (q) {
                              return AlertDialog(
                                title: Text('name'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Text('1'),
                                        RangeSlider(
                                          values: v,
                                          onChanged: (RangeValues value) {
                                            v = value;
                                            print(v);
                                          },
                                          min: 0,
                                          max: 20,
                                          labels: RangeLabels('0', '20'),
                                        ),
                                        Text('2')
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text('Carpet Area'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        enabled: false,
                        initialValue: 'sq',
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (q) {
                                return AlertDialog(
                                  title: Text('name'),
                                );
                              });
                        },
                        onChanged: (value) {
                          showDialog(
                              context: context,
                              builder: (q) {
                                return AlertDialog(
                                  title: Text('name'),
                                );
                              });
                        },
                      ),
                    )*/)
              ],
            ),
          ),
          Text('Budget ${v.start.toInt()}-${v.end.toInt()}'),
          Row(
            children: [
              Text(' 35 L'),
              Expanded(
                child: RangeSlider(
                  divisions: 53,
                  values: v,
                  onChanged: (RangeValues value) {
                    v = value;
                    setState(() {

                    });
                  },
                  min: 3500000,
                  max: 30000000,
                  labels: RangeLabels('${v.start}', '${v.end}'),
                ),
              ),
              Text('3 Cr')
            ],
          ),
          Text('Carpet Area'),
          Row(
            children: [
              Text(' 300'),
              Expanded(
                child: RangeSlider(
                  divisions: 188 ,
                  values: cpv,
                  onChanged: (RangeValues value) {
                    cpv = value;
                    setState(() {

                    });
                  },
                  min: 300,
                  max: 5000,
                  labels: RangeLabels('${cpv.start.toInt()}', '${cpv.end.toInt()}'),
                ),
              ),
              Text('50000')
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(MapPage());
          List<Room> a = filterRooms(name: 'a', number: 19, loc: 'pune1', bhk: 1);
          a.forEach((element) {
            print(element.name);
          });
        },
        child: Text('name'),
      ),
    );
  }
}
