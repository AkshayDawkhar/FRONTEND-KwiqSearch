import 'dart:async';

import 'package:flutter/material.dart';

// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeahome/constants.dart';

import '../model/unit.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // final mapController = MapController(
  //   initMapWithUserPosition: UserTrackingOption(),
  // );

  List<Unit> filteredList = Get.arguments['filteredList'];
  List<Unit> units = Get.arguments['units'];
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.604925, 73.746217),
    zoom: 10.4746,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(18.604925, 73.746217),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < units.length; i++) {
      Unit unit = units.elementAt(i);
      _markers.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(unit.latitude, unit.longitude),
          infoWindow: InfoWindow(
              title: '${unit.projectName}',
              snippet: '${unitToName(unit.unit)}',
              onTap: () {
                Get.offNamed('/');
              }),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)));
    }
    for (int i = 0; i < filteredList.length; i++) {
      Unit unit = filteredList.elementAt(i);
      _markers.add(Marker(
        markerId: MarkerId('1'),
        position: LatLng(unit.latitude, unit.longitude),
        infoWindow: InfoWindow(
            title: '${unit.projectName}}',
            snippet: '${unitToName(unit.unit)}',
            onTap: () {
              Get.offNamed('/');
            }),
      ));
    }
  }

// InfoWindow
// Marker
// <Marker> []
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markers),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

   // OSMFlutter(
//   controller: mapController,
//   mapIsLoading: Center(
//     child: CircularProgressIndicator(),
//   ),
//   initZoom: 16,
//   minZoomLevel: 3,
//   stepZoom: 1,
//   userLocationMarker: UserLocationMaker(
//     personMarker: MarkerIcon(
//       icon: Icon(
//         Icons.location_on,
//         color: Colors.greenAccent,
//         size: 148,
//       ),
//     ),
//     directionArrowMarker: MarkerIcon(
//       icon: Icon(
//         Icons.location_on,
//         color: Colors.red,
//         size: 148,
//       ),
//     ),
//   ),
//   markerOption: MarkerOption(
//     defaultMarker: MarkerIcon(
//       icon: Icon(
//         Icons.location_on,
//         color: Colors.black,
//         size: 148,
//       ),
//     ),
//   ),
//   onMapIsReady: (isR) async {
//     if (isR) {
//       print('----------Ready---------');
//       units.forEach((element) {
//         mapController.addMarker(
//           GeoPoint(latitude: element.latitude, longitude: element.longitude),
//           markerIcon: MarkerIcon(
//             iconWidget: InkWell(
//               onTap: () {
//                 // Handle onTap for each marker here
//                 print(element.projectName);
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.home,
//                     size: 140,
//                   ),
//                   Text(
//                     element.projectName,
//                     style: TextStyle(fontSize: 30),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
//     }
//   },
// ),
}

// class _MapPageState extends State<MapPage> {
//   final mapController = MapController(
//     initMapWithUserPosition: UserTrackingOption(),
//   );
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       mapController.listenerMapSingleTapping.addListener(() async {
//         // print()
//         //   var position = mapController.listenerMapSingleTapping.value;
//         //   print(position!.latitude);
//         //   if (position != null) {
//         //     await mapController.addMarker(position,
//         //         markerIcon: MarkerIcon(
//         //           icon: Icon(
//         //             Icons.location_on,
//         //             color: Colors.black,
//         //             size: 148,
//         //           ),
//         //         ));
//         //   }
//       });
//     });
//   }
//
//   List<Unit> units = Get.arguments['selected'];
//
//   // @override
//   @override
//   Widget build(BuildContext context) {
//     print(units);
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('Map'),
//           ),
//           body: OSMFlutter(
//             controller: mapController,
//             mapIsLoading: Center(
//               child: CircularProgressIndicator(),
//             ),
//             initZoom: 16,
//             minZoomLevel: 3,
//             stepZoom: 1,
//             // androidHotReloadSupport: true,
//             userLocationMarker: UserLocationMaker(
//               personMarker: MarkerIcon(
//                 icon: Icon(
//                   Icons.location_on,
//                   color: Colors.greenAccent,
//                   size: 148,
//                 ),
//               ),
//               directionArrowMarker: MarkerIcon(
//                 icon: Icon(
//                   Icons.location_on,
//                   color: Colors.red,
//                   size: 148,
//                 ),
//               ),
//             ),
//             markerOption: MarkerOption(
//                 defaultMarker: MarkerIcon(
//               icon: Icon(
//                 Icons.location_on,
//                 color: Colors.black,
//                 size: 148,
//               ),
//             )),
//             // onGeoPointClicked: (GeoPoint g) {
//             //   print(g.latitude);
//             // },
//             // onGeoPointClicked: (GeoPoint geoPoint) {
//             //   print(geoPoint.latitude);
//             // },
//             onMapIsReady: (isR) async {
//               if (isR) {
//                 print('----------Ready---------');
//                 units.forEach((element) async {
//                   print(element.toJson());
//                   // await Future.delayed(Duration(seconds: 5));
//                   mapController.addMarker(GeoPoint(latitude: element.latitude, longitude: element.longitude),
//                       markerIcon: MarkerIcon(
//                         // icon: Icon(
//                         //   Icons.home,
//                         //   color: Colors.black,
//                         //   size: 148,
//                         // ),
//                         iconWidget: InkWell(
//                           onTap: () {
//                             print(element.toJson());
//                           },
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.home,
//                                 size: 140,
//                               ),
//                               Text(
//                                 element.projectName,
//                                 style: TextStyle(fontSize: 30),
//                               )
//                             ],
//                           ),
//                         ),
//                       ));
//                 });
//               }
//             },
//           )),
//     );
//   }
// }
