import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tplmapsflutterplugin/TplMapsView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatelessWidget {
  final MapsController mapsController = Get.put(MapsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => TplMapsView(
            isShowBuildings: mapsController.isShowBuildings.value,
            isZoomEnabled: mapsController.isZoomEnabled.value,
            showZoomControls: mapsController.showZoomControls.value,
            isTrafficEnabled: mapsController.isTrafficEnabled.value,
            mapMode: mapsController.mapMode.value,
            enablePOIs: mapsController.enablePOIs.value,
            setMyLocationEnabled: mapsController.setMyLocationEnabled.value,
            myLocationButtonEnabled: mapsController.myLocationButtonEnabled.value,
            showsCompass: mapsController.showsCompass.value,
            allGesturesEnabled: mapsController.allGesturesEnabled.value,
            tplMapsViewCreatedCallback: mapsController.callback,
          )),
          Positioned(
            bottom: 10,
            //left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(

                  children: [
                    ElevatedButton(
                        onPressed: () => mapsController.addMarker(),
                        child: Icon(Icons.location_on)
                    ),
                    ElevatedButton(
                      onPressed: () => mapsController.addPolyLine(),
                      child: Text('Add PolyLine'),
                    ),
                    ElevatedButton(
                      onPressed: () => mapsController.addCircle(),
                      child: Text('Add Circle'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => mapsController.removeMarkers(),
                      child: Text('Remove Markers'),
                    ),
                    ElevatedButton(
                      onPressed: () => mapsController.removePolyline(),
                      child: Text('Remove Polyline'),
                    ),
                    ElevatedButton(
                      onPressed: () => mapsController.removeAllCircles(),
                      child: Text('Remove All Circles'),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}


class MapsController extends GetxController {
  var isShowBuildings = true.obs;
  var isZoomEnabled = true.obs;
  var showZoomControls = true.obs;
  var isTrafficEnabled = true.obs;
  var mapMode = MapMode.NIGHT.obs;
  var enablePOIs = true.obs;
  var setMyLocationEnabled = false.obs;
  var myLocationButtonEnabled = false.obs;
  var showsCompass = true.obs;
  var allGesturesEnabled = true.obs;

  late TplMapsViewController _controller;

  void callback(TplMapsViewController controller) {
    _controller = controller;

    // Add your callback logic here
    addMarker();
    addPolyLine();
    addCircle();
    removeMarkers();
    removePolyline();
    removeAllCircles();

    // Gestures Controls
    _controller.setZoomEnabled(true);
    _controller.showBuildings(false);
    _controller.showZoomControls(false);
    _controller.setTrafficEnabled(false);
    _controller.enablePOIs(true);
    _controller.setMyLocationEnabled(true);
    _controller.myLocationButtonEnabled(true);
    _controller.showsCompass(false);
    _controller.setCameraPositionAnimated(33.69804797189, 73.0693006259, 14.0);
    _controller.setMapMode(MapMode.DEFAULT);

    // Setup Places API
    TPlSearchViewController tPlSearchViewController = TPlSearchViewController("Atrium Mall" , 24.8607 , 67.0011 , (retrieveItemsCallback) {
      print(retrieveItemsCallback);
    },);

    tPlSearchViewController.getSearchItems();

    // Initialize Reverse Geocding Params with location to get Address
    TPlSearchViewController tPlSearchViewControllerReverseGeoCoding = TPlSearchViewController(null , 24.8607 , 67.0011 , (retrieveItemsCallback) {
      print(retrieveItemsCallback);
    },);

    tPlSearchViewControllerReverseGeoCoding.getReverseGeocoding();

    // Setup Routing API
    TPLRoutingViewController tplRoutingViewController =
    TPLRoutingViewController(24.820159, 67.123933, 24.830831, 67.080857 ,
          (tplRoutingCallBack) => {

        print(tplRoutingCallBack)

      },);

    tplRoutingViewController.getSearchItems();

  }

  void addMarker(){
    _controller.addMarker(33.705349, 73.069788);
  }

  void addPolyLine(){
    _controller.addPolyLine(33.705349, 73.069788, 33.705349, 73.069788);
  }

  void addCircle(){
    _controller.addCircle(33.705349, 73.069788, 50.0);
  }

  void removeMarkers(){
    _controller.removeAllMarker();
  }

  void removePolyline(){
    _controller.removePolyline();
  }

  void removeAllCircles(){
    _controller.removeAllCircles();
  }
}