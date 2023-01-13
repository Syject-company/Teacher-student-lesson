// To parse this JSON data, do
//
//     final manageChildModel = manageChildModelFromJson(jsonString);

import 'dart:convert';

List<ManageChildModel> manageChildModelFromJson(String str) =>
    List<ManageChildModel>.from(
        json.decode(str).map((x) => ManageChildModel.fromJson(x)));

String manageChildModelToJson(List<ManageChildModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ManageChildModel {
  ManageChildModel({
    required this.id,
    required this.name,
    required this.childImage,
    required this.childUserStatistic,
  });

  final String id;
  final String name;
  final ChildImage childImage;
  final ChildUserStatistic? childUserStatistic;

  factory ManageChildModel.fromJson(Map<String, dynamic> json) =>
      ManageChildModel(
        id: json["id"],
        name: json["name"],
        childImage: ChildImage.fromJson(json["childImage"]),
        childUserStatistic: ChildUserStatistic.fromJson(
            json["childUserStatistic"] ??
                ChildUserStatistic(id: '', points: 0)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "childImage": childImage.toJson(),
        "childUserStatistic": childUserStatistic?.toJson(),
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

class ChildUserStatistic {
  ChildUserStatistic({
    required this.id,
    required this.points,
  });

  final String id;
  final int points;

  factory ChildUserStatistic.fromJson(Map<String, dynamic> json) =>
      ChildUserStatistic(
        id: json["id"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "points": points,
      };
}
