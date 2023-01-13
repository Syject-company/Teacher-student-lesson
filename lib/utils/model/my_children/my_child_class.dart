// To parse this JSON data, do
//
//     final myChild = myChildFromJson(jsonString);

import 'dart:convert';

List<MyChild> myChildFromJson(String str) =>
    List<MyChild>.from(json.decode(str).map((x) => MyChild.fromJson(x)));

String myChildToJson(List<MyChild> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyChild {
  MyChild({
    required this.id,
    required this.name,
    required this.childImage,
  });

  final String id;
  final String name;
  final ChildImage childImage;

  factory MyChild.fromJson(Map<String, dynamic> json) => MyChild(
        id: json["id"],
        name: json["name"],
        childImage: ChildImage.fromJson(json["childImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "childImage": childImage.toJson(),
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
