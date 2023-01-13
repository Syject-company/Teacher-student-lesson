import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/notifications/child_notifications_class.dart';

class ChildNotificationsRepository {
  final DioClient dioClient;
  ChildNotificationsRepository({required this.dioClient});

  Future<ChildNotifications> fetchNotifications() async {
    final raw = await dioClient.getItem(Api.childNotificationsEndpoint);
    return ChildNotifications.fromJson(raw!);
  }
}
