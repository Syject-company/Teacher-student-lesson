part of 'rewards_bloc.dart';

abstract class RewardsEvent extends Equatable {
  const RewardsEvent();

  @override
  List<Object> get props => [];
}

class LoadRewards extends RewardsEvent {}

class LoadReward extends RewardsEvent {
  const LoadReward({required this.rewardId});

  final String rewardId;

  @override
  List<Object> get props => [rewardId];
}

class DeleteReward extends RewardsEvent {
  const DeleteReward({required this.rewardId});

  final String rewardId;

  @override
  List<Object> get props => [rewardId];
}

class AsignChild extends RewardsEvent {
  const AsignChild({required this.childId, required this.sectionId});

  final String sectionId;
  final String childId;

  @override
  List<Object> get props => [sectionId, childId];
}

class RewardNameChanged extends RewardsEvent {
  const RewardNameChanged({required this.rewardTitle});

  final String rewardTitle;

  @override
  List<Object> get props => [rewardTitle];
}

class PriceChanged extends RewardsEvent {
  const PriceChanged({required this.rewardPrice});

  final int rewardPrice;

  @override
  List<Object> get props => [rewardPrice];
}

class AddChildren extends RewardsEvent {
  const AddChildren({required this.selectedChildren});

  final List<EdChildUsersChore> selectedChildren;

  @override
  List<Object> get props => [selectedChildren];
}

class AddImage extends RewardsEvent {
  const AddImage({required this.selectedRewardImage});

  final ImageModel selectedRewardImage;

  @override
  List<Object> get props => [selectedRewardImage];
}

class DescriptionChanged extends RewardsEvent {
  const DescriptionChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class CreateReward extends RewardsEvent {
  const CreateReward({required this.createRewardModel});

  final CreateRewardModel createRewardModel;

  @override
  List<Object> get props => [createRewardModel];
}

class LoadChildren extends RewardsEvent {}

class LoadRewardPhoto extends RewardsEvent {}

class UpdateReward extends RewardsEvent {
  const UpdateReward({required this.updateRewardModel});

  final UpdateRewardModel updateRewardModel;

  @override
  List<Object> get props => [updateRewardModel];
}

class EditRewardEvent extends RewardsEvent {
  const EditRewardEvent(
      {required this.rewardTitle,
      required this.description,
      required this.selectedChildren,
      required this.rewardPrice,
      required this.selectedRewardImage});
  final int rewardPrice;
  final String rewardTitle;
  final String description;
  final List<EdChildUsersChore> selectedChildren;
  final ImageModel selectedRewardImage;

  @override
  List<Object> get props =>
      [rewardTitle, description, rewardPrice, selectedRewardImage, rewardTitle];
}
