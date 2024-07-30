import 'dart:convert';
/// Brand : "BMW\n"
/// Color : "Black\n"
/// Model : "M5\n"
/// Version : "2024\n"

CarInformation carInformationFromJson(String str) => CarInformation.fromJson(json.decode(str));
String carInformationToJson(CarInformation data) => json.encode(data.toJson());
class CarInformation {
  CarInformation({
      this.brand, 
      this.color, 
      this.model, 
      this.version,});

  CarInformation.fromJson(dynamic json) {
    brand = json['Brand'];
    color = json['Color'];
    model = json['Model'];
    version = json['Version'];
  }
  String? brand;
  String? color;
  String? model;
  String? version;
CarInformation copyWith({  String? brand,
  String? color,
  String? model,
  String? version,
}) => CarInformation(  brand: brand ?? this.brand,
  color: color ?? this.color,
  model: model ?? this.model,
  version: version ?? this.version,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Brand'] = brand;
    map['Color'] = color;
    map['Model'] = model;
    map['Version'] = version;
    return map;
  }

}