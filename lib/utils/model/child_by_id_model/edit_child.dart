// To parse this JSON data, do
//
//     final editChild = editChildFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EditedChild editChildFromJson(String str) =>
    EditedChild.fromJson(json.decode(str));

String editChildToJson(EditedChild data) => json.encode(data.toJson());

class EditedChild {
  EditedChild({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.childImageId,
  });

  final String id;
  final String name;
  final DateTime birthDate;
  final String childImageId;

  factory EditedChild.fromJson(Map<String, dynamic> json) => EditedChild(
        id: json["id"],
        name: json["name"],
        birthDate: DateTime.parse(json["birthDate"]),
        childImageId: json["childImageId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "birthDate": birthDate.toIso8601String(),
        "childImageId": childImageId,
      };
}
