// To parse this JSON data, do
//
//     final grades = gradesFromJson(jsonString);

import 'dart:convert';

List<Grade> gradesFromJson(String str) =>
    List<Grade>.from(json.decode(str).map((x) => Grade.fromJson(x)));

String gradesToJson(List<Grade> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Grade {
  Grade({
    required this.title,
    required this.gradeImage,
    required this.id,
  });

  final int title;
  final GradeImage gradeImage;
  final String id;

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        title: json["title"],
        gradeImage: GradeImage.fromJson(json["gradeImage"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "gradeImage": gradeImage.toJson(),
        "id": id,
      };
}

class GradeImage {
  GradeImage({
    required this.url,
    required this.id,
  });

  final String url;
  final String id;

  factory GradeImage.fromJson(Map<String, dynamic> json) => GradeImage(
        url: json["url"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
      };
}
