// To parse this JSON data, do
//
//     final chore = choreFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateChoreModel choreFromJson(String str) =>
    CreateChoreModel.fromJson(json.decode(str));

String choreToJson(CreateChoreModel data) => json.encode(data.toJson());

class CreateChoreModel {
  CreateChoreModel({
    required this.title,
    required this.description,
    required this.time,
    required this.price,
    required this.choreImageId,
    required this.childrenIds,
  });

  final String title;
  final String description;
  final DateTime time;
  final int price;
  final String choreImageId;
  final List<String> childrenIds;

  factory CreateChoreModel.fromJson(Map<String, dynamic> json) =>
      CreateChoreModel(
        title: json["title"],
        description: json["description"],
        time: DateTime.parse(json["time"]),
        price: json["price"],
        choreImageId: json["choreImageId"],
        childrenIds: List<String>.from(json["childrenIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "time": time.toIso8601String(),
        "price": price,
        "choreImageId": choreImageId,
        "childrenIds": List<dynamic>.from(childrenIds.map((x) => x)),
      };
}
