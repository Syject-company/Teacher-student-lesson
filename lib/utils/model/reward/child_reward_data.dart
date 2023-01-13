// To parse this JSON data, do
//
//     final childRewardData = childRewardDataFromJson(jsonString);

import 'dart:convert';

ChildRewardData childRewardDataFromJson(String str) =>
    ChildRewardData.fromJson(json.decode(str));

String childRewardDataToJson(ChildRewardData data) =>
    json.encode(data.toJson());

class ChildRewardData {
  ChildRewardData({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.created,
    required this.rewardImage,
  });

  final String id;
  final String title;
  final String description;
  final int price;
  final DateTime created;
  final RewardImage rewardImage;

  factory ChildRewardData.fromJson(Map<String, dynamic> json) =>
      ChildRewardData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        created: DateTime.parse(json["created"]),
        rewardImage: RewardImage.fromJson(json["rewardImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "created": created.toIso8601String(),
        "rewardImage": rewardImage.toJson(),
      };
}

class RewardImage {
  RewardImage({
    required this.id,
    required this.url,
  });

  final String id;
  final String url;

  factory RewardImage.fromJson(Map<String, dynamic> json) => RewardImage(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
