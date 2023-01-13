import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor/pages/registration/fields/description.dart';
import 'package:tutor/pages/registration/fields/name.dart';
import 'package:tutor/pages/registration/fields/time.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/chore/child_chore_class.dart';
import 'package:tutor/utils/model/chore/child_chore_data.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/repository/child_chores_repository.dart';
import 'package:tutor/utils/repository/user_repository.dart';
part 'child_chores_event.dart';
part 'child_chores_state.dart';

class ChildChoresBloc extends Bloc<ChildChoresEvent, ChildChoresState> {
  final UserRepository userRepository;

  final dio = DioClient();
  ChildChoresBloc({required this.userRepository})
      : assert(userRepository != null),
        super(ChildChoresState());

  @override
  Stream<ChildChoresState> mapEventToState(ChildChoresEvent event) async* {
    if (event is LoadChildChores) {
      final listOfChores =
          await ChildChoresRepository(dioClient: dio).fetchChores();
      yield state.copyWith(
        listOfChores: listOfChores,
      );
    } else if (event is LoadChore) {
      final choreData =
          await ChildChoresRepository(dioClient: dio).fetchChore(event.choreId);
      yield state.copyWith(
        choreData: choreData,
      );
    } else if (event is CompleteChore) {
      await ChildChoresRepository(dioClient: dio).completeChore(event.choreId);
    }
    // yield state.copyWith(status: FormzStatus.submissionInProgress);

    // try {
    //   var errorMessage = await userRepository.register(
    //     email: state.email.value,
    //     password: state.password.value,
    //     country: state.country.value,
    //     name: state.name.value,
    //   );
    //   final user = await userRepository.authenticate(
    //     email: state.email.value,
    //     password: state.password.value,
    //     isParent: true,
    //   );

    //   authenticationBloc.add(LoggedIn(user: user));
    //   if (errorMessage == "" || errorMessage.length == 38)
    //     yield state.copyWith(status: FormzStatus.submissionSuccess);
    //   else
    //     yield state.copyWith(
    //         status: FormzStatus.submissionFailure,
    //         errorMessage: errorMessage);
    // } catch (error) {
    //   yield state.copyWith(
    //       status: FormzStatus.submissionFailure,
    //       errorMessage: error.toString());
    // }
  }
}
