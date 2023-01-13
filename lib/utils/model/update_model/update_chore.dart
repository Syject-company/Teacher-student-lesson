// To parse this JSON data, do
//
//     final updateChoreModel = updateChoreModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateChoreModel updateChoreModelFromJson(String str) =>
    UpdateChoreModel.fromJson(json.decode(str));

String updateChoreModelToJson(UpdateChoreModel data) =>
    json.encode(data.toJson());

class UpdateChoreModel {
  UpdateChoreModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.price,
    required this.choreImageId,
    required this.childrenIds,
  });

  final String id;
  final String title;
  final String description;
  final DateTime time;
  final int price;
  final String choreImageId;
  final List<String> childrenIds;

  factory UpdateChoreModel.fromJson(Map<String, dynamic> json) =>
      UpdateChoreModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        time: DateTime.parse(json["time"]),
        price: json["price"],
        choreImageId: json["choreImageId"],
        childrenIds: List<String>.from(json["childrenIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "time": time.toIso8601String(),
        "price": price,
        "choreImageId": choreImageId,
        "childrenIds": List<dynamic>.from(childrenIds.map((x) => x)),
      };
}
