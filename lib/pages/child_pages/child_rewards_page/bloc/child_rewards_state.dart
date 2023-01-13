part of 'child_rewards_bloc.dart';

class ChildRewardsState extends Equatable {
  const ChildRewardsState({
    this.rewardTitle = const Name.pure(),
    this.description = const Description.pure(),
    this.listOfRewards,
    this.assignedList,
    this.purchasedList,
    this.rewardData,
    this.rewardPrice,
    this.childPoints,
  });

  final int? rewardPrice;
  final int? childPoints;
  final Description description;
  final Name rewardTitle;
  final ChildRewards? listOfRewards;
  final List<ShortReward>? assignedList;
  final List<ShortReward>? purchasedList;
  final ChildRewardData? rewardData;

  @override
  List<Object?> get props => [
        rewardTitle,
        description,
        listOfRewards,
        rewardData,
        rewardPrice,
        childPoints,
        assignedList,
        purchasedList
      ];

  ChildRewardsState copyWith({
    Name? rewardTitle,
    Description? description,
    ChildRewards? listOfRewards,
    ChildRewardData? rewardData,
    int? rewardPrice,
    int? childPoints,
    ImageModel? rewardImage,
    List<ShortReward>? assignedList,
    List<ShortReward>? purchasedList,
  }) {
    return ChildRewardsState(
      rewardPrice: rewardPrice ?? this.rewardPrice,
      childPoints: childPoints ?? this.childPoints,
      description: description ?? this.description,
      rewardTitle: rewardTitle ?? this.rewardTitle,
      listOfRewards: listOfRewards ?? this.listOfRewards,
      rewardData: rewardData ?? this.rewardData,
      assignedList: assignedList ?? this.assignedList,
      purchasedList: purchasedList ?? this.purchasedList,
    );
  }
}
