// To parse this JSON data, do
//
//     final sections = sectionsFromJson(jsonString);

import 'dart:convert';

Subject sectionsFromJson(String str) => Subject.fromJson(json.decode(str));

String sectionsToJson(Subject data) => json.encode(data.toJson());

class Subject {
  Subject({
    required this.parent,
    required this.children,
  });

  final Parent parent;
  final List<Child> children;

  factory Subject.fromJson(Map<dynamic, dynamic> json) => Subject(
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
    required this.title,
    required this.subjectImage,
    required this.id,
  });

  final String title;
  final SubjectImage subjectImage;
  final String id;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        title: json["title"],
        subjectImage: SubjectImage.fromJson(json["subjectImage"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subjectImage": subjectImage.toJson(),
        "id": id,
      };
}

class SubjectImage {
  SubjectImage({
    required this.url,
    required this.id,
  });

  final String url;
  final String id;

  factory SubjectImage.fromJson(Map<String, dynamic> json) => SubjectImage(
        url: json["url"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
      };
}

class Parent {
  Parent({
    required this.title,
    required this.id,
  });

  final int title;
  final String id;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        title: json["title"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
      };
}
