part of 'child_lessons_bloc.dart';

abstract class ChildLessonsEvent extends Equatable {
  const ChildLessonsEvent();

  @override
  List<Object> get props => [];
}

class LoadGrades extends ChildLessonsEvent {}

class LoadSubjects extends ChildLessonsEvent {
  const LoadSubjects({
    required this.gradeId,
  });

  final String gradeId;

  @override
  List<Object> get props => [gradeId];
}

class LoadSections extends ChildLessonsEvent {
  const LoadSections({
    required this.gradeId,
    required this.subjectId,
  });

  final String gradeId;
  final String subjectId;

  @override
  List<Object> get props => [gradeId, subjectId];
}

class LoadSubSections extends ChildLessonsEvent {
  const LoadSubSections({
    required this.sectionId,
  });

  final String sectionId;

  @override
  List<Object> get props => [sectionId];
}

class SendResults extends ChildLessonsEvent {
  const SendResults({required this.result});

  final Result result;

  @override
  List<Object> get props => [result];
}
