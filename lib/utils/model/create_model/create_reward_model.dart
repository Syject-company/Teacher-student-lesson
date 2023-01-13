// To parse this JSON data, do
//
//     final createReward = createRewardFromJson(jsonString);
import 'dart:convert';

CreateRewardModel createRewardFromJson(String str) =>
    CreateRewardModel.fromJson(json.decode(str));

String createRewardToJson(CreateRewardModel data) => json.encode(data.toJson());

class CreateRewardModel {
  CreateRewardModel({
    required this.title,
    required this.description,
    required this.price,
    required this.created,
    required this.rewardImageId,
    required this.childrenIds,
  });

  final String title;
  final String description;
  final int price;
  final DateTime created;
  final String rewardImageId;
  final List<String> childrenIds;

  factory CreateRewardModel.fromJson(Map<String, dynamic> json) =>
      CreateRewardModel(
        title: json["title"],
        description: json["description"],
        price: json["price"],
        created: DateTime.parse(json["created"]),
        rewardImageId: json["rewardImageId"],
        childrenIds: List<String>.from(json["childrenIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price,
        "created": created.toIso8601String(),
        "rewardImageId": rewardImageId,
        "childrenIds": List<dynamic>.from(childrenIds.map((x) => x)),
      };
}
