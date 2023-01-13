// To parse this JSON data, do
//
//     final child = childFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Child> childFromJson(String str) =>
    List<Child>.from(json.decode(str).map((x) => Child.fromJson(x)));

String childToJson(List<Child> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Child {
  Child({
    required this.name,
    // required this.childImage,
    // required this.id,
  });

  final String name;
  // final ChildImage childImage;
  // final String id;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        name: json["name"],
        // childImage: ChildImage?.fromJson(json["childImage"]) ??
        //     ChildImage(url: 'url', id: 'id'),
        // id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        // "childImage": childImage?.toJson(),
        // "id": id,
      };
}

// class ChildImage {
//   ChildImage({
//     required this.url,
//     required this.id,
//   });

//   final String url;
//   final String id;

//   factory ChildImage.fromJson(Map<String, dynamic> json) => ChildImage(
//         url: json["url"] ?? '',
//         id: json["id"] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "id": id,
//       };
// }
