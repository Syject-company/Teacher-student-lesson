import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:tutor/pages/registration/fields/description.dart';
import 'package:tutor/pages/registration/fields/name.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/chore/chore_class.dart';
import 'package:tutor/utils/model/create_model/create_reward_model.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/model/reward/reward_class.dart';
import 'package:tutor/utils/model/update_model/update_reward.dart';
import 'package:tutor/utils/repository/lessons_repository.dart';
import 'package:tutor/utils/repository/photo_repository.dart';
import 'package:tutor/utils/repository/rewards_repository.dart';
import 'package:tutor/utils/repository/user_repository.dart';
part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  final UserRepository userRepository;

  final dio = DioClient();
  RewardsBloc({required this.userRepository})
      : assert(userRepository != null),
        super(RewardsState());

  @override
  Stream<RewardsState> mapEventToState(RewardsEvent event) async* {
    if (event is LoadRewards) {
      final listOfRewards =
          await RewardsRepository(dioClient: dio).fetchRewards();
      yield state.copyWith(
        listOfRewards: listOfRewards,
      );
    } else if (event is LoadReward) {
      final rewardData =
          await RewardsRepository(dioClient: dio).fetchReward(event.rewardId);
      yield state.copyWith(
        rewardData: rewardData,
      );
    } else if (event is EditRewardEvent) {
      final rewardTitle = Name.dirty(event.rewardTitle);
      final description = Description.dirty(event.description);
      yield state.copyWith(
        updateCalled: true,
        rewardTitle: rewardTitle,
        description: description,
        rewardPrice: event.rewardPrice,
        selectedChildren: event.selectedChildren,
        rewardImage: event.selectedRewardImage,
        status: FormzStatus.valid,
      );
    } else if (event is DeleteReward) {
      await RewardsRepository(dioClient: dio).deleteReward(
        event.rewardId,
      );
    } else if (event is RewardNameChanged) {
      final rewardTitle = Name.dirty(event.rewardTitle);
      yield state.copyWith(
        rewardTitle: rewardTitle,
        status: Formz.validate([rewardTitle, state.description]),
      );
    } else if (event is DescriptionChanged) {
      final desc = Description.dirty(event.description);
      yield state.copyWith(
        description: desc,
        status: Formz.validate([desc, state.rewardTitle]),
      );
    } else if (event is LoadChildren) {
      final listOfChildren =
          await RewardsRepository(dioClient: dio).fetchMyChildren();
      yield state.copyWith(
        listOfChildren: listOfChildren,
      );
    } else if (event is AddChildren) {
      yield state.copyWith(
        selectedChildren: event.selectedChildren,
      );
    } else if (event is AsignChild) {
      await LessonsRepository(dioClient: dio).asignMyChild(
        event.childId,
        event.sectionId,
      );
    } else if (event is LoadRewardPhoto) {
      final listOfPhoto =
          await PhotoRepository(dioClient: dio).fetchRewardsPhoto();
      yield state.copyWith(
        listOfPhoto: listOfPhoto,
      );
    } else if (event is AddImage) {
      yield state.copyWith(
        rewardImage: event.selectedRewardImage,
      );
    } else if (event is CreateReward) {
      await RewardsRepository(dioClient: dio)
          .createReward(event.createRewardModel);
      yield state.copyWith(
        createRewardModel: event.createRewardModel,
      );
    } else if (event is UpdateReward) {
      await RewardsRepository(dioClient: dio)
          .updateReward(event.updateRewardModel);
      yield state.copyWith(
        updateRewardModel: event.updateRewardModel,
      );
    } else if (event is PriceChanged) {
      yield state.copyWith(
        rewardPrice: event.rewardPrice,
      );
    }
  }
}
