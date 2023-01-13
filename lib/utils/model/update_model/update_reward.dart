import 'dart:convert';

String updateRewardToJson(UpdateRewardModel data) => json.encode(data.toJson());

class UpdateRewardModel {
  UpdateRewardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.created,
    required this.rewardImageId,
    required this.childrenIds,
  });

  final String id;
  final String title;
  final String description;
  final int price;
  final DateTime created;
  final String rewardImageId;
  final List<String> childrenIds;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "created": created.toIso8601String(),
        "rewardImageId": rewardImageId,
        "childrenIds": List<dynamic>.from(childrenIds.map((x) => x)),
      };
}
