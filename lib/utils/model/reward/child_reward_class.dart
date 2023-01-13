// To parse this JSON data, do
//
//     final childReward = childRewardFromJson(jsonString);

import 'dart:convert';

ChildRewards childRewardFromJson(String str) =>
    ChildRewards.fromJson(json.decode(str));

class ChildRewards {
  ChildRewards({
    required this.assignedRewards,
    required this.purchasedRewards,
  });

  final List<ShortReward>? assignedRewards;
  final List<ShortReward>? purchasedRewards;

  factory ChildRewards.fromJson(Map<String, dynamic> json) => ChildRewards(
        assignedRewards: json["assignedRewards"] == null
            ? []
            : List<ShortReward>.from(
                json["assignedRewards"].map((x) => ShortReward.fromJson(x)) ??
                    []),
        purchasedRewards: json["purchasedRewards"] == null
            ? []
            : List<ShortReward>.from(
                json["purchasedRewards"].map((x) => ShortReward.fromJson(x)) ??
                    []),
      );
}

class ShortReward {
  ShortReward({
    required this.id,
    required this.rewardImage,
  });

  final String id;
  final RewardImage rewardImage;

  factory ShortReward.fromJson(Map<String, dynamic> json) => ShortReward(
        id: json["id"],
        rewardImage: RewardImage.fromJson(json["rewardImage"]),
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
