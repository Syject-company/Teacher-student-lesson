import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/chore/child_chore_class.dart';
import 'package:tutor/utils/model/chore/child_chore_data.dart';
import 'package:tutor/utils/model/chore/chore_class.dart';
import 'package:tutor/utils/model/create_model/create_chore_model.dart';
import 'package:tutor/utils/model/update_model/update_chore.dart';

class ChildChoresRepository {
  final DioClient dioClient;
  ChildChoresRepository({required this.dioClient});

  Future<List<ChildChore>> fetchChores() async {
    final raw = await dioClient.getList(Api.childChoresEndpoint);
    return raw!.map((e) => ChildChore.fromJson(e)).toList();
  }

  Future<ChildChoreData> fetchChore(choreId) async {
    final rewardRaw = await dioClient.getAndAddItem(
        Api.childchoreEndpoint, 'choreId=$choreId');
    print(ChildChoreData.fromJson(rewardRaw).id);
    return ChildChoreData.fromJson(rewardRaw);
  }

  Future completeChore(choreId) async {
    await dioClient.post(Api.childchoreCompleteEndpoint + 'choreId=$choreId');
  }
}
