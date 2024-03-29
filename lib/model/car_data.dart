/// charge : "69\n"
/// range : "115\n"
/// speed : "60\n"
/// temp : "23\n"

class CarData {
  CarData({
    this.charge,
    this.range,
    this.speed,
    this.temp,
  });

  CarData.fromJson(dynamic json) {
    charge = json['charge'];
    range = json['range'];
    speed = json['speed'];
    temp = json['temp'];
  }
  String? charge;
  String? range;
  String? speed;
  String? temp;
  CarData copyWith({
    String? charge,
    String? range,
    String? speed,
    String? temp,
  }) =>
      CarData(
        charge: charge ?? this.charge,
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
