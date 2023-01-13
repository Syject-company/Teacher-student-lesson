import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/chore/chore_class.dart';
import 'package:tutor/utils/model/create_model/create_chore_model.dart';
import 'package:tutor/utils/model/update_model/update_chore.dart';

class ChoresRepository {
  final DioClient dioClient;
  ChoresRepository({required this.dioClient});

  Future<List<Chore>> fetchChores() async {
    final raw = await dioClient.getList(Api.parentChoresEndpoint);
    return raw!.map((e) => Chore.fromJson(e)).toList();
  }

  Future<Chore> fetchChore(choreId) async {
    final rewardRaw =
        await dioClient.getAndAddItem(Api.choreEndpoint, 'choreId=$choreId');
    print(Chore.fromJson(rewardRaw).id);
    return Chore.fromJson(rewardRaw);
  }

  Future<bool?> deleteChore(choreId) async {
    print(choreId);
    final choreRaw = await dioClient.remove(
      Api.deleteChoreEndpoint + '$choreId',
    );
    return choreRaw;
  }

  Future<List<EdChildUsersChore>> fetchMyChildren() async {
    final childrenRaw = await dioClient.getList(Api.getChildrenEndpoint);
    return childrenRaw!.map((e) => EdChildUsersChore.fromJson(e)).toList();
  }

  createChore(CreateChoreModel createChoreModel) async {
    var toSend = createChoreModel.toJson();
    print(toSend);
    await dioClient.postPrize(Api.choreCreateEndpoint, toSend);
  }

  updateChore(UpdateChoreModel updateChoreModel) async {
    print(updateChoreModel.toJson());
    var toSend = updateChoreModel.toJson();
    await dioClient.putPrize(Api.choreUpdateEndpoint, toSend);
  }

  approveChore(choreId, childId) async {
    print(Api.approveChoreEndpoint + 'choreId=$choreId' + '&childId=$childId');
    await dioClient.post(
        Api.approveChoreEndpoint + 'choreId=$choreId' + '&childId=$childId');
  }
}
