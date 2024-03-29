import 'dart:convert';

import '../model/car_data.dart';
import 'package:http/http.dart' as http;

abstract class ApiManager{
  static const baseUrl='10.0.0.1:4000';
  static Future<CarData> getCarData() async {
    Uri url = Uri.http(baseUrl, 'car_data');
    http.Response response = await http.get(Uri.parse("http://10.0.0.1:4000/car_data"));
    Map json=jsonDecode(response.body)as Map;
    CarData carData=CarData.fromJson(json);
    return carData;

  }
}