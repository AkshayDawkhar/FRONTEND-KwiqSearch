import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants.dart';
import '../model/unit.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<UnitDetails> filteredList = Get.arguments['filteredList'];
  List<UnitDetails> units = Get.arguments['units'];
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.604925, 73.746217),
    zoom: 12.0,
  );

  final List<Marker> _markers = <Marker>[];
  Set<Polyline> _polylines = {}; // Train track storage
  Set<Marker> _stationMarkers = {}; // Train stations
  BitmapDescriptor? trainIcon; // Train station icon

  // Example Multiple Train Routes
  final List<List<LatLng>> _trainRoutes = [
    [
      LatLng(18.604925, 73.746217),
      LatLng(18.615345, 73.756111),
      LatLng(18.629876, 73.769888),
      LatLng(18.645789, 73.780000),
    ],
    [
      LatLng(18.601111, 73.741234),
      LatLng(18.610567, 73.750987),
      LatLng(18.625876, 73.865432),
      LatLng(18.640111, 73.775678),
    ]
  ];

  @override
  void initState() {
    super.initState();
    _loadTrainIcon();
    _addMarkers();
    _addTrainLines();
  }

  /// Loads and resizes the train station icon
  void _loadTrainIcon() async {
    final ByteData data = await rootBundle.load('images/train_icon.png');
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: 80, // Increased icon size
      targetHeight: 80,
    );
    final ui.FrameInfo frame = await codec.getNextFrame();
    final ByteData? byteData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedIcon = byteData!.buffer.asUint8List();

    setState(() {
      trainIcon = BitmapDescriptor.fromBytes(resizedIcon);
      _addTrainStations();
    });
  }

  /// Adds project markers
  void _addMarkers() {
    for (var unit in units) {
      _markers.add(Marker(
        markerId: MarkerId(unit.projectId.toString()),
        position: LatLng(unit.latitude, unit.longitude),
        infoWindow: InfoWindow(
          title: '${unit.projectName}',
          snippet: '${unit.projectUnits.map((e) => unitToName(e.unit)).toList().join(',')}',
          onTap: () {
            Get.toNamed('/project', parameters: {"project_id": unit.projectId.toString()});
          },
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      ));
    }
  }

  /// Adds multiple train routes (Polyline)
  void _addTrainLines() {
    List<Color> routeColors = [Colors.blue, Colors.red];

    for (int i = 0; i < _trainRoutes.length; i++) {
      Polyline trainPolyline = Polyline(
        polylineId: PolylineId("train_route_$i"),
        color: routeColors[i],
        width: 5,
        points: _trainRoutes[i],
        patterns: [PatternItem.dash(10), PatternItem.gap(5)],
      );
      _polylines.add(trainPolyline);
    }
    setState(() {});
  }

  /// Adds train station markers
  void _addTrainStations() {
    if (trainIcon == null) return;

    for (int i = 0; i < _trainRoutes.length; i++) {
      for (int j = 0; j < _trainRoutes[i].length; j++) {
        _stationMarkers.add(Marker(
          markerId: MarkerId("station_${i}_$j"),
          position: _trainRoutes[i][j],
          icon: trainIcon!,
          infoWindow: InfoWindow(
            title: "Train Station ${j + 1}",
            snippet: "Station at ${_trainRoutes[i][j].latitude}, ${_trainRoutes[i][j].longitude}",
          ),
        ));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Train Map')),
      body: GoogleMap(
        mapType: MapType.normal,
        trafficEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markers)..addAll(_stationMarkers),
        polylines: _polylines,
      ),
    );
  }
}
