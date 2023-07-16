import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:get/get.dart';
import 'package:takeahome/views/map_page.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                                  items: places
                                      .map((e) => MultiSelectItem(e, e))
                                      .toList(),
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
                          child: Text(
                              'Amenities')) /*InkWell(
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
                      )*/
                      )
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
                      setState(() {});
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
                    divisions: 188,
                    values: cpv,
                    onChanged: (RangeValues value) {
                      cpv = value;
                      setState(() {});
                    },
                    min: 300,
                    max: 5000,
                    labels: RangeLabels(
                        '${cpv.start.toInt()}', '${cpv.end.toInt()}'),
                  ),
                ),
                Text('50000')
              ],
            ),
            ListView.builder(
                itemCount: dummyFlats.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
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
                            Text('${flat.name}'),
                            Text('${flat.area}'),
                          ],
                        ),
                        subtitle: Text(
                            '${flat.bhk} BHK       ${flat.carpetArea} sqft\n${monthDate(flat.possession)}                     | ₹ ${flat.price}'),
                        isThreeLine: true,
//                         trailing: Icon(
//                           Icons.arrow_forward_ios_outlined,
// // color: Colors.redAccent,
//                         ),
                      ));
                  // return Text(dummyFlats.elementAt(index).name);
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(MapPage());
// Get.to()
          // List<Room> a = filterRooms(name: 'a', number: 19, loc: 'pune1', bhk: 1);
          // a.forEach((element) {
          //   print(element.name);
          // });
        },
        icon: Icon(Icons.location_on),
        label: Text('Map'),
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
