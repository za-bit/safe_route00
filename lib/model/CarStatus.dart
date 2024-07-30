import 'dart:convert';
/// charge : "69\n"
/// range : "115\n"
/// speed : "60\n"
/// temp : "23\n"

CarStatus carStatusFromJson(String str) => CarStatus.fromJson(json.decode(str));
String carStatusToJson(CarStatus data) => json.encode(data.toJson());
class CarStatus {
  CarStatus({
      this.charge, 
      this.range, 
      this.speed, 
      this.temp,});

  CarStatus.fromJson(dynamic json) {
    charge = json['charge'];
    range = json['range'];
    speed = json['speed'];
    temp = json['temp'];
  }
  String? charge;
  String? range;
  String? speed;
  String? temp;
CarStatus copyWith({  String? charge,
  String? range,
  String? speed,
  String? temp,
}) => CarStatus(  charge: charge ?? this.charge,
  range: range ?? this.range,
  speed: speed ?? this.speed,
  temp: temp ?? this.temp,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['charge'] = charge;
    map['range'] = range;
    map['speed'] = speed;
    map['temp'] = temp;
    return map;
  }

}