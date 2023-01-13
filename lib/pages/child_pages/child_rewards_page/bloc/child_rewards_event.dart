part of 'child_rewards_bloc.dart';

abstract class ChildRewardsEvent extends Equatable {
  const ChildRewardsEvent();

  @override
  List<Object> get props => [];
}

class LoadChildRewards extends ChildRewardsEvent {}

class LoadChildPoints extends ChildRewardsEvent {}

class LoadChildAssignedRewards extends ChildRewardsEvent {}

class LoadChildPurchasedRewards extends ChildRewardsEvent {}

class LoadChildReward extends ChildRewardsEvent {
  const LoadChildReward({required this.rewardId});

  final String rewardId;

  @override
  List<Object> get props => [rewardId];
}

class BuyReward extends ChildRewardsEvent {
  const BuyReward({required this.rewardId});

  final String rewardId;

  @override
  List<Object> get props => [rewardId];
}
