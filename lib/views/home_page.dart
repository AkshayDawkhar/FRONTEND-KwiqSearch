import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
            margin: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: DropdownButtonFormField(
                      hint: Text('Area'),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurpleAccent, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                      ),
                      onChanged: (value) {},
                      items: ['a', 'b', 'c']
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      hint: Text('unit'),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurpleAccent, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                      ),
                      onChanged: (value) {},
                      items: ['1 RK','1 BHK', '2 BHK','3 BHK', '4 BHK']
                          .map((e) => DropdownMenuItem(
                                child: Row(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                        value: false, onChanged: (bool? value) {  }),
                                    Text(e)
                                  ],
                                ),
                                value: e,
                              ))
                          .toList(),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
            // margin: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: DropdownButtonFormField(
                      hint: Text('passation'),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurpleAccent, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                      ),
                      onChanged: (value) {},
                      items: ['Ready To Move','6 month' ,'1 Year', '2 Year','3 +3 Year']
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(flex: 2,child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (q){return AlertDialog(title: Text('name'),);});
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('Carpet Area'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),)
                    ),

                    enabled: false,
                    initialValue: 'sq',
                    onTap: (){
                      showDialog(context: context, builder: (q){return AlertDialog(title: Text('name'),);});
                    },
                    onChanged: (value){
                      showDialog(context: context, builder: (q){return AlertDialog(title: Text('name'),);});
                    },
                  ),
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: DropdownButtonFormField(
                      hint: Text('Amendments'),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurpleAccent, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                      ),
                      onChanged: (value) {},
                      items: ['Yes','No']
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(flex: 2,child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (q){return AlertDialog(title: Text('name'),);});
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('Budget'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),)
                    ),

                    enabled: false,
                    initialValue: '61 - 71',
                    onTap: (){
                      showDialog(context: context, builder: (q){return AlertDialog(title: Text('name'),);});
                    },
                    onChanged: (value){
                      showDialog(context: context, builder: (q){return AlertDialog(title: Text('name'),);});
                    },
                  ),
                ))
              ],
            ),
          ),


        ],
      ),
    );
  }
}
