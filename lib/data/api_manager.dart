import 'dart:convert';


import 'package:http/http.dart' as http;

import '../model/CarBump.dart';
import '../model/CarInformation.dart';

import '../model/CarStatus.dart';


 class ApiManager2{

  static Future<CarInformation?> getCarInformation() async {

    http.Response response = await http.get(Uri.parse("http://10.0.0.1:3000/ifo"));

    var data=jsonDecode(response.body);
    CarInformation carInformation=CarInformation.fromJson(data);
    return carInformation;}


}


  abstract class ApiManager4 {

    static Future<CarBump?> getCarBump() async {
      http.Response response = await http.get(
          Uri.parse("http://10.0.0.1:3000/bump"));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map json = jsonDecode(response.body) as Map;
        CarBump carBump = CarBump.fromJson(json);
        return carBump;
      }
    }
  }

