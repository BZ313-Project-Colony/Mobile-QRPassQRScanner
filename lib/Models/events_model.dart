import 'dart:convert';

EtkinlikModel etkinlikModelFromMap(String str) =>
    EtkinlikModel.fromMap(json.decode(str));

String etkinlikModelToMap(EtkinlikModel data) => json.encode(data.toMap());

class EtkinlikModel {
  final int id;
  final String title;
  final String place;
  final DateTime time;
  final bool isActive;

  EtkinlikModel({
    required this.id,
    required this.title,
    required this.place,
    required this.time,
    required this.isActive,
  });

  factory EtkinlikModel.fromMap(Map<String, dynamic> json) => EtkinlikModel(
    id: json["id"],
    title: json["title"],
    place: json["place"],
    time: DateTime.parse(json["time"]),
    isActive: json["isActive"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "place": place,
    "time": time.toIso8601String(),
    "isActive": isActive,
  };
}
