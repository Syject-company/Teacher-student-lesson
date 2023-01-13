// To parse this JSON data, do
//
//     final childChore = childChoreFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ChildChore> childChoreFromJson(String str) =>
    List<ChildChore>.from(json.decode(str).map((x) => ChildChore.fromJson(x)));

String childChoreToJson(List<ChildChore> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildChore {
  ChildChore({
    required this.id,
    required this.title,
    required this.price,
    required this.choreImage,
  });

  final String id;
  final String title;
  final int price;
  final ChoreImage choreImage;

  factory ChildChore.fromJson(Map<String, dynamic> json) => ChildChore(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        choreImage: ChoreImage.fromJson(json["choreImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
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
