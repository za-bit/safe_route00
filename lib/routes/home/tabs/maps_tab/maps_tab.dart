import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../../../../model/CarLocation.dart';

class MapsTab extends StatefulWidget {


  @override
  State<MapsTab> createState() => _MapsTabState();
}

class _MapsTabState extends State<MapsTab> {
  StreamController<CarLocation> streamController=StreamController();
  @override
  void dispose(){
    streamController.close();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      getCarLocation();
    });

  }


   Future<CarLocation?> getCarLocation() async {

  http.Response response = await http.get(Uri.parse("http://10.0.0.1:3000/gps"));
  var data=jsonDecode(response.body);
  CarLocation carLocation=CarLocation.fromJson(data);
  streamController.sink.add(carLocation);

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(child: StreamBuilder<CarLocation>(
          stream: streamController.stream,builder: (context,snapdata){
            switch(snapdata.connectionState){
              case ConnectionState.waiting:return Center(child: CircularProgressIndicator(),);
              default:if(snapdata.hasError){
                return Text('Please Wait...');
              }else{
                return BuildCoinWidget(snapdata.data!);
              }
            }
        },
        ),)

    );
  }
  Widget BuildCoinWidget(CarLocation carLocation){
    return FlutterMap(
      options: MapOptions(
        center: LatLng(carLocation.lat as double, carLocation.long as double),
        zoom: 16,

      ),
      children: [
        TileLayer(
          urlTemplate: 'https://api.mapbox.com/styles/v1/zahret-elislam/clsci9kks01ou01r40nli1f1z/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiemFocmV0LWVsaXNsYW0iLCJhIjoiY2xzY2FwdG82MGhxMjJrb2FyYjlheXprMyJ9.--32X_CmZJDTkyFt90HazA',
          additionalOptions: {
            'accessToken':'pk.eyJ1IjoiemFocmV0LWVsaXNsYW0iLCJhIjoiY2xzY2FwdG82MGhxMjJrb2FyYjlheXprMyJ9.--32X_CmZJDTkyFt90HazA',
            'id':'mapbox.mapbox-streets-v8'

          },
        ),

      ],
    );
  }
  subscribeToLocationUpdates(){
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //todo:show another dialog to the user explaining why do u need this permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }



}
