// To parse this JSON data, do
//
//     final childChoreData = childChoreDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChildChoreData childChoreDataFromJson(String str) =>
    ChildChoreData.fromJson(json.decode(str));

String childChoreDataToJson(ChildChoreData data) => json.encode(data.toJson());

class ChildChoreData {
  ChildChoreData({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.price,
    required this.choreImage,
  });

  final String id;
  final String title;
  final String description;
  final DateTime time;
  final int price;
  final ChoreImage choreImage;

  factory ChildChoreData.fromJson(Map<String, dynamic> json) => ChildChoreData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        time: DateTime.parse(json["time"]),
        price: json["price"],
        choreImage: ChoreImage.fromJson(json["choreImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "time": time.toIso8601String(),
        "price": price,
        "choreImage": choreImage.toJson(),
      };
}

class ChoreImage {
  ChoreImage({
    required this.id,
    required this.url,
  });

  final String id;
  final String url;

  factory ChoreImage.fromJson(Map<String, dynamic> json) => ChoreImage(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
