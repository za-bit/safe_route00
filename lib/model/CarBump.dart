import 'dart:convert';
/// Bump : true

CarBump carBumpFromJson(String str) => CarBump.fromJson(json.decode(str));
String carBumpToJson(CarBump data) => json.encode(data.toJson());
class CarBump {
  CarBump({
      this.bump,});

  CarBump.fromJson(dynamic json) {
    bump = json['Bump'];
  }
  bool? bump;
CarBump copyWith({  bool? bump,
}) => CarBump(  bump: bump ?? this.bump,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Bump'] = bump;
    return map;
  }

}