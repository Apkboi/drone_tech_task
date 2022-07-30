import 'dart:convert';

Drone droneFromJson(String str) => Drone.fromJson(json.decode(str));

String droneToJson(Drone data) => json.encode(data.toJson());

class Drone {
  Drone({
    required this.idTag,
    required this.weightCapacity,
    required this.manufacturer,
    required this.served,
    required this.dateOfAcquisition,
  });

  String idTag;
  String weightCapacity;
  String manufacturer;
  bool served;
  String dateOfAcquisition;

  factory Drone.fromJson(Map<String, dynamic> json) => Drone(
        idTag: json["id_tag"],
        weightCapacity: json["weight_capacity"],
        manufacturer: json["manufacturer"],
        served: json["served"],
        dateOfAcquisition: json["date_of_acquisition"],
      );

  Map<String, dynamic> toJson() => {
        "id_tag": idTag,
        "weight_capacity": weightCapacity,
        "manufacturer": manufacturer,
        "served": served,
        "date_of_acquisition": dateOfAcquisition,
      };
}
