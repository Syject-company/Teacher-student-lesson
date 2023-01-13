import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/child_by_id_model/child_by_id_model.dart';
import 'package:tutor/utils/model/child_by_id_model/edit_child.dart';
import 'package:tutor/utils/model/manage_child_model/manage_child_model.dart';

class SettingRepository {
  final DioClient dioClient;
  SettingRepository({required this.dioClient});

  Future<ChildById> getChildById(childId) async {
    final childRaw = await dioClient.getAndAddItem(
        Api.getChildByIdEndpoint, 'childId=$childId');
    print(ChildById.fromJson(childRaw));
    return ChildById.fromJson(childRaw);
  }

  Future<List<ManageChildModel>> fetchManageChildren() async {
    final childrenRaw = await dioClient.getList(Api.getManageChildrenEndpoint);
    return childrenRaw!.map((e) => ManageChildModel.fromJson(e)).toList();
  }

  Future editChild(EditedChild childData) async {
    print(childData.toJson());
    await dioClient.putPrize(Api.editChildEndpoint, childData.toJson());
  }

  Future deleteChild(String childId) async {
    await dioClient.remove(
      Api.deleteChildEndpoint + 'childId=$childId',
    );
  }
}
