import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';

class PhotoRepository {
  final DioClient dioClient;
  PhotoRepository({required this.dioClient});

  Future<List<ImageModel>> fetchChildsPhoto() async {
    final children = await dioClient.getList(Api.childImagesEndpoint);
    return children!.map((e) => ImageModel.fromJson(e)).toList();
  }

  Future<List<ImageModel>> fetchRewardsPhoto() async {
    final rewards = await dioClient.getList(Api.rewardsImagesEndpoint);
    return rewards!.map((e) => ImageModel.fromJson(e)).toList();
  }

  Future<List<ImageModel>> fetchChoresPhoto() async {
    final chores = await dioClient.getList(Api.choresImagesEndpoint);
    return chores!.map((e) => ImageModel.fromJson(e)).toList();
  }
}
