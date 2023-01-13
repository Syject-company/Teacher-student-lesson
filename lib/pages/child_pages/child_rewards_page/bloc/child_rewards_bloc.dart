import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/pages/registration/fields/description.dart';
import 'package:tutor/pages/registration/fields/name.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/model/reward/child_reward_class.dart';
import 'package:tutor/utils/model/reward/child_reward_data.dart';
import 'package:tutor/utils/repository/child_rewards_repository.dart';
import 'package:tutor/utils/repository/user_repository.dart';

part 'child_rewards_event.dart';
part 'child_rewards_state.dart';

class ChildRewardsBloc extends Bloc<ChildRewardsEvent, ChildRewardsState> {
  final UserRepository userRepository;

  final dio = DioClient();
  ChildRewardsBloc({required this.userRepository})
      : assert(userRepository != null),
        super(ChildRewardsState());

  @override
  Stream<ChildRewardsState> mapEventToState(ChildRewardsEvent event) async* {
    if (event is LoadChildRewards) {
      final listOfRewards =
          await ChildRewardsRepository(dioClient: dio).fetchRewards();
      yield state.copyWith(
        listOfRewards: listOfRewards,
      );
    } else if (event is LoadChildReward) {
      final rewardData = await ChildRewardsRepository(dioClient: dio)
          .fetchReward(event.rewardId);
      yield state.copyWith(
        rewardData: rewardData,
      );
    } else if (event is LoadChildPoints) {
      final pointsRaw =
          await ChildRewardsRepository(dioClient: dio).fetchPoints();
      yield state.copyWith(
        childPoints: pointsRaw.points,
      );
    } else if (event is LoadChildAssignedRewards) {
      final assignedList =
          await ChildRewardsRepository(dioClient: dio).fetchAssignedReward();
      yield state.copyWith(
        assignedList: assignedList,
      );
    } else if (event is LoadChildPurchasedRewards) {
      final purchasedList =
          await ChildRewardsRepository(dioClient: dio).fetchPurchasedReward();
      yield state.copyWith(
        purchasedList: purchasedList,
      );
    } else if (event is BuyReward) {
      await ChildRewardsRepository(dioClient: dio)
          .buyChildReward(event.rewardId);
    }
  }
}
