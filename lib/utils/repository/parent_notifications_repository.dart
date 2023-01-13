import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/notifications/child_notifications_class.dart';
import 'package:tutor/utils/model/notifications/parent_notifications_class.dart';

class ParentNotificationsRepository {
  final DioClient dioClient;
  ParentNotificationsRepository({required this.dioClient});

  Future<List<ParentNotification>> fetchNotifications() async {
    final raw = await dioClient.getList(Api.parentNotificationsEndpoint);
    return raw!.map((e) => ParentNotification.fromJson(e)).toList();
  }
}
