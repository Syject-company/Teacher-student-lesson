// To parse this JSON data, do
//
//     final reward = rewardFromJson(jsonString);

import 'dart:convert';

import 'package:tutor/utils/model/chore/chore_class.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/model/my_children/my_child_class.dart';

List<Reward> rewardFromJson(String str) =>
    List<Reward>.from(json.decode(str).map((x) => Reward.fromJson(x)));

class Reward {
  Reward({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    this.created,
    required this.rewardImage,
    this.assignedChildUsersRewards,
  });

  final String id;
  final String title;
  final String? description;
  final int price;
  final DateTime? created;
  final ImageModel rewardImage;
  final List<EdChildUsersChore>? assignedChildUsersRewards;

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        id: json["id"],
        title: json["title"],
        description: json["description"] ?? '',
        price: json["price"],
        created: DateTime.parse(json["created"] ?? '2022-09-22T17:41:23.489'),
        rewardImage: ImageModel.fromJson(json["rewardImage"]),
        assignedChildUsersRewards: json["assignedChildUsersRewards"] == null
            ? []
            : List<EdChildUsersChore>.from(json["assignedChildUsersRewards"]
                    .map((x) => EdChildUsersChore.fromJson(x)) ??
                []),
      );
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
}
