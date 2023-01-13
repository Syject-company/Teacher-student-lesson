part of 'rewards_bloc.dart';

class RewardsState extends Equatable {
  const RewardsState({
    this.rewardTitle = const Name.pure(),
    this.description = const Description.pure(),
    this.listOfRewards,
    this.rewardData,
    this.listOfChildren,
    this.status = FormzStatus.pure,
    this.selectedChildren,
    this.listOfPhoto,
    this.selectedRewardImage,
    this.rewardPrice,
    this.updateRewardModel,
    this.updateCalled = false,
    this.createRewardModel,
  });

  final bool? updateCalled;
  final int? rewardPrice;
  final Description description;
  final Name rewardTitle;
  final List<Reward>? listOfRewards;
  final List<EdChildUsersChore>? listOfChildren;
  final List<EdChildUsersChore>? selectedChildren;
  final Reward? rewardData;
  final FormzStatus status;
  final List<ImageModel>? listOfPhoto;
  final ImageModel? selectedRewardImage;
  final CreateRewardModel? createRewardModel;
  final UpdateRewardModel? updateRewardModel;

  @override
  List<Object?> get props => [
        updateRewardModel,
        rewardTitle,
        description,
        listOfRewards,
        status,
        rewardData,
        listOfChildren,
        selectedChildren,
        listOfPhoto,
        selectedRewardImage,
        createRewardModel,
        rewardPrice,
        updateCalled
      ];

  RewardsState copyWith({
    bool? updateCalled,
    Name? rewardTitle,
    Description? description,
    FormzStatus? status,
    List<Reward>? listOfRewards,
    List<EdChildUsersChore>? listOfChildren,
    List<EdChildUsersChore>? selectedChildren,
    Reward? rewardData,
    int? rewardPrice,
    List<ImageModel>? listOfPhoto,
    ImageModel? rewardImage,
    CreateRewardModel? createRewardModel,
    UpdateRewardModel? updateRewardModel,
  }) {
    return RewardsState(
      createRewardModel: createRewardModel ?? this.createRewardModel,
      rewardPrice: rewardPrice ?? this.rewardPrice,
      status: status ?? this.status,
      description: description ?? this.description,
      rewardTitle: rewardTitle ?? this.rewardTitle,
      listOfRewards: listOfRewards ?? this.listOfRewards,
      rewardData: rewardData ?? this.rewardData,
      selectedRewardImage: rewardImage ?? this.selectedRewardImage,
      listOfChildren: listOfChildren ?? this.listOfChildren,
      selectedChildren: selectedChildren ?? this.selectedChildren,
      listOfPhoto: listOfPhoto ?? this.listOfPhoto,
      updateRewardModel: updateRewardModel ?? this.updateRewardModel,
      updateCalled: updateCalled ?? this.updateCalled,
    );
  }
}
