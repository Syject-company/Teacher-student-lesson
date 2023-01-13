import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/reward/child_reward_class.dart';
import 'package:tutor/utils/model/reward/child_reward_data.dart';
import 'package:tutor/utils/model/reward/child_statistic_model.dart';
import 'package:tutor/utils/model/reward/test_results.dart';

class ChildRewardsRepository {
  final DioClient dioClient;
  ChildRewardsRepository({required this.dioClient});

  Future<ChildRewards> fetchRewards() async {
    final raw = await dioClient.getItem(Api.childRewardsEndpoint);
    return ChildRewards.fromJson(raw!);
  }

  Future<ChildPoints> fetchPoints() async {
    final raw = await dioClient.getItem(Api.childPointsEndpoint);
    return ChildPoints.fromJson(raw!);
  }

  Future<ChildRewardData> fetchReward(rewardId) async {
    final rewardRaw = await dioClient.getAndAddItem(
        Api.childRewardEndpoint, 'rewardId=$rewardId');
    return ChildRewardData.fromJson(rewardRaw);
  }

  Future<List<ShortReward>> fetchAssignedReward() async {
    final rewardRaw = await dioClient.getList(
      Api.childAssignedRewardEndpoint,
    );
    return rewardRaw!.map((e) => ShortReward.fromJson(e)).toList();
  }

  Future<List<ShortReward>> fetchPurchasedReward() async {
    final rewardRaw = await dioClient.getList(
      Api.childPurchasedRewardEndpoint,
    );
    return rewardRaw!.map((e) => ShortReward.fromJson(e)).toList();
  }

  Future buyChildReward(rewardId) async {
    print(rewardId);
    await dioClient.post(Api.childBuyRewardEndpoint + '?rewardId=$rewardId');
  }
}
