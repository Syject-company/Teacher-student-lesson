import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor/services/dio_client.dart';

import 'package:tutor/utils/model/grade/grade_class.dart';
import 'package:tutor/utils/model/my_children/my_child_class.dart';
import 'package:tutor/utils/model/section/section_class.dart';
import 'package:tutor/utils/model/sub_section/sub_section.dart';

import 'package:tutor/utils/model/subject/subject_class.dart';
import 'package:tutor/utils/repository/lessons_repository.dart';
import 'package:tutor/utils/repository/user_repository.dart';
part 'lessons_event.dart';
part 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  final UserRepository userRepository;

  final dio = DioClient();
  LessonsBloc({
    required this.userRepository,
  })  : assert(userRepository != null),
        super(LessonsState());

  @override
  Stream<LessonsState> mapEventToState(LessonsEvent event) async* {
    if (event is LoadGrades) {
      final listOfGrades =
          await LessonsRepository(dioClient: DioClient()).fetchGrades();
      yield state.copyWith(
        listOfGrades: listOfGrades,
      );
    } else if (event is LoadSubjects) {
      final listOfSubjects =
          await LessonsRepository(dioClient: dio).fetchSubjects(event.gradeId);
      yield state.copyWith(
        listOfSubjects: listOfSubjects,
      );
    } else if (event is LoadSections) {
      final listOfSections = await LessonsRepository(dioClient: dio)
          .fetchSections(event.gradeId, event.subjectId);
      yield state.copyWith(
        listOfSections: listOfSections,
      );
    } else if (event is LoadSubSections) {
      final listOfSubSections = await LessonsRepository(dioClient: dio)
          .fetchSubSections(event.sectionId);
      yield state.copyWith(
        listOfSubSections: listOfSubSections,
      );
    } else if (event is LoadChildren) {
      final listOfChildren =
          await LessonsRepository(dioClient: dio).fetchMyChildren();
      yield state.copyWith(
        listOfChildren: listOfChildren,
      );
    } else if (event is AsignChild) {
      await LessonsRepository(dioClient: dio)
          .asignMyChild(event.childId, event.sectionId);
    }
  }
}
