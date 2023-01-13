// To parse this JSON data, do
//
//     final childSection = childSectionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ChildSection> childSectionFromJson(String str) => List<ChildSection>.from(
    json.decode(str).map((x) => ChildSection.fromJson(x)));

String childSectionToJson(List<ChildSection> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildSection {
  ChildSection({
    required this.id,
    required this.title,
    required this.points,
    required this.sectionImage,
  });

  final String id;
  final String title;
  final int points;
  final SectionImage sectionImage;

  factory ChildSection.fromJson(Map<String, dynamic> json) => ChildSection(
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
