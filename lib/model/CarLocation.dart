import 'dart:convert';
/// lat : 45
/// long : 75

CarLocation carLocationFromJson(String str) => CarLocation.fromJson(json.decode(str));
String carLocationToJson(CarLocation data) => json.encode(data.toJson());
class CarLocation {
  CarLocation({
      this.lat, 
      this.long,});

  CarLocation.fromJson(dynamic json) {
    lat = json['lat'];
    long = json['long'];
  }
  num? lat;
  num? long;
CarLocation copyWith({  num? lat,
  num? long,
}) => CarLocation(  lat: lat ?? this.lat,
  long: long ?? this.long,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['long'] = long;
    return map;
  }

}