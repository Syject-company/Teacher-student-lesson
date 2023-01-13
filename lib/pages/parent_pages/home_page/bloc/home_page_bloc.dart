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
import 'package:tutor/utils/model/notifications/parent_notifications_class.dart';
import 'package:tutor/utils/repository/child_chores_repository.dart';
import 'package:tutor/utils/repository/child_notifications_repository.dart';
import 'package:tutor/utils/repository/parent_notifications_repository.dart';
import 'package:tutor/utils/repository/user_repository.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final UserRepository userRepository;

  final dio = DioClient();
  HomePageBloc({required this.userRepository})
      : assert(userRepository != null),
        super(HomePageState());

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is LoadParentNotifications) {
      final listOfNotifications =
          await ParentNotificationsRepository(dioClient: dio)
              .fetchNotifications();
      yield state.copyWith(parentNotifications: listOfNotifications);
    }
  }
}
