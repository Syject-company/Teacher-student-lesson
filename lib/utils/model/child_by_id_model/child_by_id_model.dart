// To parse this JSON data, do
//
//     final childById = childByIdFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChildById childByIdFromJson(String str) => ChildById.fromJson(json.decode(str));

String childByIdToJson(ChildById data) => json.encode(data.toJson());

class ChildById {
  ChildById({
    required this.id,
    required this.birthDate,
    required this.name,
    required this.childImage,
    required this.childUserStatistic,
  });

  final String id;
  final DateTime birthDate;
  final String name;
  final ChildImage childImage;
  final ChildUserStatistic? childUserStatistic;

  factory ChildById.fromJson(Map<String, dynamic> json) => ChildById(
        id: json["id"],
        birthDate: DateTime.parse(json["birthDate"]),
        name: json["name"],
        childImage: ChildImage.fromJson(json["childImage"]),
        childUserStatistic: ChildUserStatistic.fromJson(
            json["childUserStatistic"] ??
                ChildUserStatistic(id: '', points: 0)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "birthDate": birthDate.toIso8601String(),
        "name": name,
        "childImage": childImage.toJson(),
        "childUserStatistic": childUserStatistic?.toJson(),
      };
}

class ChildImage {
  ChildImage({
    required this.id,
    required this.url,
  });

  final String id;
  final String url;

  factory ChildImage.fromJson(Map<String, dynamic> json) => ChildImage(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

class ChildUserStatistic {
  ChildUserStatistic({
    required this.id,
    required this.points,
  });

  final String id;
  final int points;

  factory ChildUserStatistic.fromJson(Map<String, dynamic> json) =>
      ChildUserStatistic(
        id: json["id"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "points": points,
      };
}
