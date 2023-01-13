// To parse this JSON data, do
//
//     final sections = sectionsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Section sectionsFromJson(String str) => Section.fromJson(json.decode(str));

String sectionsToJson(Section data) => json.encode(data.toJson());

class Section {
  Section({
    required this.parent,
    required this.children,
  });

  final Parent parent;
  final List<Child> children;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        parent: Parent.fromJson(json["parent"]),
        children:
            List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "parent": parent.toJson(),
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class Child {
  Child({
    required this.id,
    required this.title,
    required this.points,
    required this.sectionImage,
  });

  final String id;
  final String title;
  final int points;
  final SectionImage sectionImage;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["id"],
        title: json["title"],
        points: json["points"],
        sectionImage: SectionImage.fromJson(json["sectionImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "points": points,
        "sectionImage": sectionImage.toJson(),
      };
}

class SectionImage {
  SectionImage({
    required this.id,
    required this.url,
  });

  final String id;
  final String url;

  factory SectionImage.fromJson(Map<String, dynamic> json) => SectionImage(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

class Parent {
  Parent({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
