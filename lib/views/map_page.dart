import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:takeahome/constants.dart';

import '../model/unit.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapController = MapController(
    initMapWithUserPosition: UserTrackingOption(),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapController.listenerMapSingleTapping.addListener(() async {
        // print()
        //   var position = mapController.listenerMapSingleTapping.value;
        //   print(position!.latitude);
        //   if (position != null) {
        //     await mapController.addMarker(position,
        //         markerIcon: MarkerIcon(
        //           icon: Icon(
        //             Icons.location_on,
        //             color: Colors.black,
        //             size: 148,
        //           ),
        //         ));
        //   }
      });
    });
  }
  List<Unit> units = Get.arguments['selected'];
  // @override
  @override
  Widget build(BuildContext context) {
    print(units);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Map'),
          ),
          body: OSMFlutter(
            controller: mapController,
            mapIsLoading: Center(
              child: CircularProgressIndicator(),
            ),
            initZoom: 16,
            minZoomLevel: 3,
            stepZoom: 1,
            androidHotReloadSupport: true,
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.greenAccent,
                  size: 148,
                ),
              ),
              directionArrowMarker: MarkerIcon(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 148,
                ),
              ),
            ),
            markerOption: MarkerOption(
                defaultMarker: MarkerIcon(
              icon: Icon(
                Icons.location_on,
                color: Colors.black,
                size: 148,
              ),
            )),
            // onGeoPointClicked: (GeoPoint g) {
            //   print(g.latitude);
            // },
            onGeoPointClicked: (GeoPoint geoPoint) {
              print(geoPoint.latitude.sign);
            },
            onMapIsReady: (isR) async {
              if (isR) {
                print('----------Ready---------');
                units.forEach((element) {
                  mapController.addMarker(GeoPoint(latitude: element.latitude, longitude: element.longitude),
                      markerIcon: MarkerIcon(
                        // icon: Icon(
                        //   Icons.home,
                        //   color: Colors.black,
                        //   size: 148,
                        // ),
                        iconWidget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.home,size: 140,),
                            Text(element.projectName,style: TextStyle(fontSize: 30),)
                          ],
                        ),
                      ));
                });
              }
            },
          )),
    );
  }
}

//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late MapController mapController;
//
//   @override
//   void initState() {
//     super.initState();
//     mapController = MapController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: OSMFlutter(controller: mapController,)
//       ),
//     );
//   }
// }
