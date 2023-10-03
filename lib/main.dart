
///*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tplmapsflutterplugin/TplMapsView.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () => mapsController.addMarker(),
                        child: const Icon(Icons.location_on)
                    ),
                    ElevatedButton(
                      onPressed: () => mapsController.addPolyLine(),
                      child: const Text('Add PolyLine'),
                    ),
                    ElevatedButton(
                      onPressed: () => mapsController.addCircle(),
                      child: const Text('Add Circle'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => mapsController.removeMarkers(),
                        child: const Icon(Icons.location_off_sharp),
                    ),
                    ElevatedButton(
                      onPressed: () => mapsController.removePolyline(),
                      child: const Text('Remove Polyline'),
                    ),
                    ElevatedButton(
                      onPressed: () => mapsController.removeAllCircles(),
                      child: const Text('Remove All Circles'),
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
    // addMarker();
    // addPolyLine();
    // addCircle();
    // removeMarkers();
    // removePolyline();
    // removeAllCircles();



    // Gestures Controls
    controller.setZoomEnabled(true);
    controller.showBuildings(true);
    controller.showZoomControls(true);
    controller.setTrafficEnabled(true);
    controller.enablePOIs(true);
    controller.setMyLocationEnabled(true);
    controller.myLocationButtonEnabled(true);
    controller.showsCompass(true);
    controller.setCameraPositionAnimated(33.705349, 73.069788, 14.0);
    controller.setMapMode(MapMode.DEFAULT);

    // // Initialize Reverse Geocding Params with location to get Address
    // TPlSearchViewController tPlSearchViewControllerReverseGeoCoding = TPlSearchViewController(null , 24.8607 , 67.0011 , (retrieveItemsCallback) {
    //   print(retrieveItemsCallback);
    // },);

    //tPlSearchViewControllerReverseGeoCoding.getReverseGeocoding();

    // Setup Routing API
    TPLRoutingViewController tplRoutingViewController = TPLRoutingViewController(33.705349, 73.069788,33.698047971892045, 73.06930062598059 ,
          (tplRoutingCallBack) => {
        print(tplRoutingCallBack)
      },);

    tplRoutingViewController.getSearchItems();

    controller.setCameraPositionAnimated(33.698047971892045, 73.06930062598059,14.0);

    _controller.addMarker(33.705349, 73.069788);
    _controller.addMarker(33.698047971892045, 73.06930062598059);
    controller.setUpPolyLine();
    controller.addPolyLine(33.705349, 73.069788,33.698047971892045, 73.06930062598059);
    controller.setMapMode(MapMode.DEFAULT);
    bool isBuildingsEnabled = controller.isBuildingEnabled;
    print("isBuildingsEnabled: $isBuildingsEnabled");
    bool isTrafficEnabled = controller.isTrafficEnabled;
    print("isTrafficEnabled: $isTrafficEnabled");
    bool isPOIsEnabled = controller.isPOIsEnabled;
    print("isPOIsEnabled: $isPOIsEnabled");

  }

  void addMarker() {
    _controller.addMarker(33.705349, 73.069788);
  }

  void addPolyLine(){
    _controller.setUpPolyLine();
    _controller.addPolyLine(33.705349, 73.069788, 24.8607 , 67.0011);
  }

  void addCircle(){

    _controller.addCircle(33.705349, 73.069788, 10.0);
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

//*/


/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:map_comparison/second.dart';
import 'package:tplmapsflutterplugin/TplMapsView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late TplMapsViewController _controller;

  // // Initial Selected Value
  // String dropdownvalue = 'Item 1';
  //
  // // List of items in our dropdown menu
  // var items = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("TPL Maps"),
      ),
      body: Stack(
        children: [
          Container(
            child: TplMapsView(
              isShowBuildings: true,
              isZoomEnabled: true,
              showZoomControls: true,
              isTrafficEnabled: true,
              mapMode: MapMode.NIGHT,
              enablePOIs: true,
              setMyLocationEnabled: false,
              myLocationButtonEnabled: false,
              showsCompass: true,
              allGesturesEnabled: true,
              tplMapsViewCreatedCallback: _callback,
              //tPlMapsViewMarkerCallBack: _markerCallback,
            ),

          ),
          // Container(
          //     width: double.infinity,
          //     margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         DropdownButton(
          //
          //           // Initial Value
          //           value: dropdownvalue,
          //
          //           // Down Arrow Icon
          //           icon: const Icon(Icons.keyboard_arrow_down),
          //
          //           // Array list of items
          //           items: items.map((String items) {
          //             return DropdownMenuItem(
          //               value: items,
          //               child: Text(items),
          //             );
          //           }).toList(),
          //           // After selecting the desired option,it will
          //           // change button value to selected value
          //           onChanged: (String? newValue) {
          //             setState(() {
          //               dropdownvalue = newValue!;
          //             });
          //           },
          //         ),
          //       ],
          //
          //     )
          // ),
          // Container(
          //   margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
          //   width: double.infinity,
          //   height: 50,
          //   color: Colors.red,
          //   child: Text("Text on the Map", style: TextStyle(color: Colors.white , fontSize: 20),  textAlign: TextAlign.center,),
          // )
        ],

      ),


    );

  }

  void _markerCallback(String callback){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondRoute()),
    );

    //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: SecondRoute()));

  }

  void _callback(TplMapsViewController controller) {
    controller.showBuildings(false);
    controller.showZoomControls(false);
    controller.setTrafficEnabled(false);
    controller.enablePOIs(true);
    // controller.setMyLocationEnabled(true);
    // controller.myLocationButtonEnabled(true);
    TPLRoutingViewController tplRoutingViewController =
    TPLRoutingViewController(33.705349, 73.069788, 33.698047971892045, 73.06930062598059 ,
        (tplRoutingCallBack) => {
        controller.setUpPolyLine(),

    // You will be get json list response

    log(tplRoutingCallBack)
        },);

    tplRoutingViewController.getSearchItems();
    controller.showsCompass(true);
    controller.showZoomControls(true);
    controller.setCameraPositionAnimated(33.698047971892045, 73.06930062598059,14.0);
    controller.addMarker(33.705349, 73.069788);
    controller.addMarker(33.698047971892045, 73.06930062598059);
    controller.addPolyLine(33.705349, 73.069788, 33.698047971892045, 73.06930062598059);
    controller.addCircle(33.705349, 73.069788 , 25.0);
    controller.setMapMode(MapMode.DEFAULT);
    bool isBuildingsEnabled = controller.isBuildingEnabled;
    print("isBuildingsEnabled: $isBuildingsEnabled");
    bool isTrafficEnabled = controller.isTrafficEnabled;
    print("isTrafficEnabled: $isTrafficEnabled");
    bool isPOIsEnabled = controller.isPOIsEnabled;
    print("isPOIsEnabled: $isPOIsEnabled");

    _controller  = controller;
  }


  void addMarker(){
    _controller.addMarker(33.705349, 73.069788);
  }

  void addPolyLine(){
    _controller.addPolyLine(33.705349, 73.069788, 33.705349, 73.069788);
  }

  void addCircle(){
    _controller.addCircle(33.705349, 73.069788 , 25.0);
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

  // Other methods
  void otherMethods(){

    //....
      _controller.setZoomEnabled(true);
      _controller.showBuildings(false);
      _controller.showBuildings(false);
      _controller.showZoomControls(true);
      _controller.setTrafficEnabled(false);
      _controller.enablePOIs(true);
      _controller.setMyLocationEnabled(true);
      _controller.myLocationButtonEnabled(true);
      _controller.showsCompass(true);
      _controller.setCameraPositionAnimated(33.69804797189, 73.0693006259, 14.0);
      _controller.setMapMode(MapMode.DEFAULT);
      _controller.isBuildingEnabled;
      _controller.isTrafficEnabled;
      _controller.isPOIsEnabled;

  }

  // Search
  void getSearchItemsbyName (){

    TPlSearchViewController tPlSearchViewController =
    TPlSearchViewController("Atrium Mall" , 24.8607 , 67.0011 , (retrieveItemsCallback) {

      // You will be get json list response
      log(retrieveItemsCallback);
    },);

    tPlSearchViewController.getReverseGeocoding();

  }


// Create Route between two points
  void getRouting(){
    TPLRoutingViewController tplRoutingViewController =
    TPLRoutingViewController(33.705349, 73.069788, 33.698047971892045, 73.06930062598059 , (tplRoutingCallBack) {
      log(tplRoutingCallBack);
      _controller.setUpPolyLine();
    },);

    tplRoutingViewController.getSearchItems();

  }

}

 */