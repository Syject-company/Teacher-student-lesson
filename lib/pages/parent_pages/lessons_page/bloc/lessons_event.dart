part of 'lessons_bloc.dart';

abstract class LessonsEvent extends Equatable {
  const LessonsEvent();

  @override
  List<Object> get props => [];
}

class LoadGrades extends LessonsEvent {}

class LoadSubjects extends LessonsEvent {
  const LoadSubjects({
    required this.gradeId,
  });

  final String gradeId;

  @override
  List<Object> get props => [gradeId];
}

class LoadSections extends LessonsEvent {
  const LoadSections({
    required this.gradeId,
    required this.subjectId,
  });

  final String gradeId;
  final String subjectId;

  @override
  List<Object> get props => [gradeId, subjectId];
}

class LoadSubSections extends LessonsEvent {
  const LoadSubSections({
    required this.sectionId,
  });

  final String sectionId;

  @override
  List<Object> get props => [sectionId];
}

class AsignChild extends LessonsEvent {
  const AsignChild({
    required this.childId,
    required this.sectionId,
  });

  final String sectionId;
  final String childId;

  @override
  List<Object> get props => [sectionId, childId];
}

class LoadChildren extends LessonsEvent {}

class LoadPhoto extends LessonsEvent {}
