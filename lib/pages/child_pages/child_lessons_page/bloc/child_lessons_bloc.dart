import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/grade/grade_class.dart';
import 'package:tutor/utils/model/reward/test_results.dart';
import 'package:tutor/utils/model/section/child_section_class.dart';
import 'package:tutor/utils/model/sub_section/child_sub_section.dart';
import 'package:tutor/utils/model/subject/subject_class.dart';
import 'package:tutor/utils/repository/child_lessons_repository.dart';
import 'package:tutor/utils/repository/user_repository.dart';

part 'child_lessons_event.dart';
part 'child_lessons_state.dart';

class ChildLessonsBloc extends Bloc<ChildLessonsEvent, ChildLessonsState> {
  final UserRepository userRepository;

  final dio = DioClient();
  ChildLessonsBloc({
    required this.userRepository,
  })  : assert(userRepository != null),
        super(ChildLessonsState());

  @override
  Stream<ChildLessonsState> mapEventToState(ChildLessonsEvent event) async* {
    if (event is LoadGrades) {
      final listOfGrades =
          await ChildLessonsRepository(dioClient: DioClient()).fetchGrades();
      yield state.copyWith(
        listOfGrades: listOfGrades,
      );
    } else if (event is LoadSubjects) {
      final listOfSubjects = await ChildLessonsRepository(dioClient: dio)
          .fetchSubjects(event.gradeId);
      yield state.copyWith(
        listOfSubjects: listOfSubjects,
      );
    } else if (event is LoadSections) {
      final listOfSections = await ChildLessonsRepository(dioClient: dio)
          .fetchSections(event.gradeId, event.subjectId);
      yield state.copyWith(
        listOfSections: listOfSections,
      );
    } else if (event is LoadSubSections) {
      final listOfSubSections = await ChildLessonsRepository(dioClient: dio)
          .fetchSubSections(event.sectionId);
      yield state.copyWith(
        listOfSubSections: listOfSubSections,
      );
    } else if (event is SendResults) {
      await ChildLessonsRepository(dioClient: dio).sendResults(event.result);
    }
  }
}
