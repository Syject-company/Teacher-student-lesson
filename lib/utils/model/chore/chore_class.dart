import 'dart:convert';

import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/model/notifications/child_notifications_class.dart';

Chore choreFromJson(String str) => Chore.fromJson(json.decode(str));

class Chore {
  Chore({
    required this.id,
    required this.choreCategory,
    required this.title,
    required this.description,
    required this.time,
    required this.price,
    required this.choreImage,
    required this.assignedChildUsersChores,
    required this.completedChildUsersChores,
  });

  final String id;
  final String? choreCategory;
  final String title;
  final String? description;
  final DateTime? time;
  final int price;
  final ImageModel choreImage;
  final List<EdChildUsersChore>? assignedChildUsersChores;
  final List<EdChildUsersChore>? completedChildUsersChores;

  factory Chore.fromJson(Map<String, dynamic> json) => Chore(
        id: json["id"],
        choreCategory: json["choreCategory"] ?? '',
        title: json["title"],
        description: json["description"] ?? '',
        time: DateTime.parse(json["time"] ?? '2022-09-22T00:00:00.000'),
        price: json["price"],
        choreImage: ImageModel.fromJson(json["choreImage"]),
        assignedChildUsersChores: json["assignedChildUsersChores"] == null
            ? []
            : List<EdChildUsersChore>.from(json["assignedChildUsersChores"]
                .map((x) => EdChildUsersChore.fromJson(x))),
        completedChildUsersChores: json["completedChildUsersChores"] == null
            ? []
            : List<EdChildUsersChore>.from(json["completedChildUsersChores"]
                .map((x) => EdChildUsersChore.fromJson(x))),
      );
}

class EdChildUsersChore {
  EdChildUsersChore({
    required this.id,
    required this.name,
    required this.childImage,
  });

  final String id;
  final String name;
  final Image childImage;

  factory EdChildUsersChore.fromJson(Map<String, dynamic> json) =>
      EdChildUsersChore(
        id: json["id"],
        name: json["name"],
        childImage: Image.fromJson(json["childImage"]),
      );
}
