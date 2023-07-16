import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPicker extends StatefulWidget {
  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
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
          var position = mapController.listenerMapSingleTapping.value;
          print(position!.latitude);
          if (position != null) {
            await mapController.addMarker(position,
                markerIcon: MarkerIcon(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.black,
                    size: 148,
                  ),
                ));
          }
      });
    });
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
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
                // locations.forEach((element) {
                //   mapController.addMarker(
                //       GeoPoint(
                //           latitude: element.latitude,
                //           longitude: element.longitude),
                //       markerIcon: MarkerIcon(
                //         icon: Icon(
                //           Icons.home,
                //           color: Colors.black,
                //           size: 148,
                //         ),
                //       ));
                // });
              }
            },
          );
  }
}
