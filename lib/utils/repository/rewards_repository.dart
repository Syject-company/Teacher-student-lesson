import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/chore/chore_class.dart';
import 'package:tutor/utils/model/create_model/create_reward_model.dart';
import 'package:tutor/utils/model/reward/reward_class.dart';
import 'package:tutor/utils/model/section/section_class.dart';
import 'package:tutor/utils/model/sub_section/sub_section.dart';
import 'package:tutor/utils/model/update_model/update_reward.dart';

class RewardsRepository {
  final DioClient dioClient;
  RewardsRepository({required this.dioClient});

  Future<List<Reward>> fetchRewards() async {
    final raw = await dioClient.getList(Api.rewardsEndpoint);
    return raw!.map((e) => Reward.fromJson(e)).toList();
  }

  Future<Reward> fetchReward(rewardId) async {
    final rewardRaw =
        await dioClient.getAndAddItem(Api.rewardEndpoint, 'rewardId=$rewardId');
    return Reward.fromJson(rewardRaw);
  }

  Future<bool?> deleteReward(rewardId) async {
    print(rewardId);
    final rewardRaw = await dioClient.remove(
      Api.deleteRewardEndpoint + '$rewardId',
    );

    return rewardRaw;
  }

  Future<Section> fetchSections(gradeId, subjectId) async {
    final sectionssRaw = await dioClient.getAndAddItem(
        Api.sectionsEndpoint, 'gradeId=$gradeId&subjectId=$subjectId');
    print(Section.fromJson(sectionssRaw));
    return Section.fromJson(sectionssRaw);
  }

  Future<SubSection> fetchSubSections(sectionId) async {
    final sectionssRaw = await dioClient.getAndAddItem(
        Api.subSectionsEndpoint, 'sectionId=$sectionId');
    print(SubSection.fromJson(sectionssRaw));
    return SubSection.fromJson(sectionssRaw);
  }

  Future<List<EdChildUsersChore>> fetchMyChildren() async {
    final childrenRaw = await dioClient.getList(Api.getChildrenEndpoint);
    return childrenRaw!.map((e) => EdChildUsersChore.fromJson(e)).toList();
  }

  asignMyChild(childId, sectionId) async {
    print(Api.assignSectionEndpoint +
        'childId=${childId}&' +
        'sectionId=${sectionId}');
    await dioClient.putUser(Api.assignSectionEndpoint +
        'childId=${childId}&' +
        'sectionId=${sectionId}');
  }

  createReward(CreateRewardModel createRewardModel) async {
    var toSend = createRewardModel.toJson();
    await dioClient.postPrize(Api.rewardCreateEndpoint, toSend);
  }

  updateReward(UpdateRewardModel updateRewardModel) async {
    print(updateRewardModel.toJson());
    var toSend = updateRewardModel.toJson();
    await dioClient.putPrize(Api.rewardUpdateEndpoint, toSend);
  }
}
