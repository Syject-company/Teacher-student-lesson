import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/pages/registration/fields/description.dart';
import 'package:tutor/pages/registration/fields/name.dart';
import 'package:tutor/pages/registration/fields/time.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/chore/child_chore_class.dart';
import 'package:tutor/utils/model/chore/child_chore_data.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/model/notifications/child_notifications_class.dart';
import 'package:tutor/utils/repository/child_chores_repository.dart';
import 'package:tutor/utils/repository/child_notifications_repository.dart';
import 'package:tutor/utils/repository/user_repository.dart';
part 'child_notifications_event.dart';
part 'child_notifications_state.dart';

class ChildNotificationsBloc
    extends Bloc<ChildNotificationsEvent, ChildNotificationsState> {
  final UserRepository userRepository;

  final dio = DioClient();
  ChildNotificationsBloc({required this.userRepository})
      : assert(userRepository != null),
        super(ChildNotificationsState());

  @override
  Stream<ChildNotificationsState> mapEventToState(
      ChildNotificationsEvent event) async* {
    if (event is LoadChildNotifications) {
      final listOfNotifications =
          await ChildNotificationsRepository(dioClient: dio)
              .fetchNotifications();
      yield state.copyWith(
          assignedChores: listOfNotifications.assignedChores,
          assignedSections: listOfNotifications.assignedSections,
          notifications: listOfNotifications.notifications);
    }
  }
}
