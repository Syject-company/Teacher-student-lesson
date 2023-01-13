import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tutor/pages/registration/fields/description.dart';
import 'package:tutor/pages/registration/fields/name.dart';
import 'package:tutor/pages/registration/fields/time.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/chore/chore_class.dart';
import 'package:tutor/utils/model/create_model/create_chore_model.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/model/update_model/update_chore.dart';
import 'package:tutor/utils/repository/chores_repository.dart';
import 'package:tutor/utils/repository/lessons_repository.dart';
import 'package:tutor/utils/repository/photo_repository.dart';
import 'package:tutor/utils/repository/user_repository.dart';

part 'chores_event.dart';
part 'chores_state.dart';

class ChoresBloc extends Bloc<ChoresEvent, ChoresState> {
  final UserRepository userRepository;

  final dio = DioClient();
  ChoresBloc({required this.userRepository})
      : assert(userRepository != null),
        super(ChoresState());

  @override
  Stream<ChoresState> mapEventToState(ChoresEvent event) async* {
    if (event is LoadChores) {
      final listOfChores = await ChoresRepository(dioClient: dio).fetchChores();
      yield state.copyWith(
        listOfChores: listOfChores,
      );
    } else if (event is LoadChore) {
      final choreData =
          await ChoresRepository(dioClient: dio).fetchChore(event.choreId);
      yield state.copyWith(
        choreData: choreData,
      );
    } else if (event is EditChoreEvent) {
      final choreTitle = Name.dirty(event.choreTitle);
      final description = Description.dirty(event.description);
      final time = Time.dirty(event.time);
      yield state.copyWith(
        updateCalled: true,
        time: time,
        choreTitle: choreTitle,
        description: description,
        chorePrice: event.chorePrice,
        selectedChildren: event.selectedChildren,
        choreImage: event.selectedChoreImage,
        status: FormzStatus.valid,
      );
    } else if (event is DeleteChore) {
      await ChoresRepository(dioClient: dio).deleteChore(
        event.choreId,
      );
    } else if (event is ChoresNameChanged) {
      final choreTitle = Name.dirty(event.choreTitle);
      yield state.copyWith(
        choreTitle: choreTitle,
        status: Formz.validate([choreTitle, state.time, state.description]),
      );
    } else if (event is ChoresTimeChanged) {
      final time = Time.dirty(event.time);
      print('bloc$time');
      yield state.copyWith(
        time: time,
        status: Formz.validate([time, state.description, state.choreTitle]),
      );
      print('state${state.time.value}');
    } else if (event is DescriptionChoresChanged) {
      final desc = Description.dirty(event.description);
      yield state.copyWith(
        description: desc,
        status: Formz.validate([desc, state.time, state.choreTitle]),
      );
    } else if (event is LoadChoresChildren) {
      final listOfChildren =
          await ChoresRepository(dioClient: dio).fetchMyChildren();
      yield state.copyWith(
        listOfChildren: listOfChildren,
      );
    } else if (event is AddChildren) {
      yield state.copyWith(
        selectedChildren: event.selectedChildren,
      );
    } else if (event is AsignChild) {
      await LessonsRepository(dioClient: dio).asignMyChild(
        event.childId,
        event.sectionId,
      );
    } else if (event is LoadChoresPhoto) {
      final listOfPhoto =
          await PhotoRepository(dioClient: dio).fetchChoresPhoto();
      yield state.copyWith(
        listOfPhoto: listOfPhoto,
      );
    } else if (event is AddImage) {
      yield state.copyWith(
        choreImage: event.selectedChoreImage,
      );
    } else if (event is CreateChore) {
      await ChoresRepository(dioClient: dio)
          .createChore(event.createChoreModel);
      yield state.copyWith(
        createChoreModel: event.createChoreModel,
      );
    } else if (event is UpdateChore) {
      await ChoresRepository(dioClient: dio)
          .updateChore(event.updateChoreModel);
      yield state.copyWith(
        updateChoreModel: event.updateChoreModel,
      );
    } else if (event is PriceChoreChanged) {
      yield state.copyWith(
        chorePrice: event.chorePrice,
      );
    } else if (event is ApproveChore) {
      await ChoresRepository(dioClient: dio)
          .approveChore(event.choreId, event.childId);
    }
  }
}
