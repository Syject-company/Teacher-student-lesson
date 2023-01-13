part of 'lessons_bloc.dart';

class LessonsState extends Equatable {
  const LessonsState({
    this.listOfGrades,
    this.listOfSubjects,
    this.listOfSections,
    this.listOfSubSections,
    this.listOfChildren,
  });

  final List<Grade>? listOfGrades;
  final List<MyChild>? listOfChildren;
  final Subject? listOfSubjects;
  final Section? listOfSections;
  final SubSection? listOfSubSections;

  @override
  List<Object?> get props => [
        listOfGrades,
        listOfSubjects,
        listOfSections,
        listOfSubSections,
        listOfChildren,
      ];

  LessonsState copyWith({
    List<Grade>? listOfGrades,
    List<MyChild>? listOfChildren,
    Subject? listOfSubjects,
    Section? listOfSections,
    SubSection? listOfSubSections,
  }) {
    return LessonsState(
      listOfGrades: listOfGrades ?? this.listOfGrades,
      listOfSubjects: listOfSubjects ?? this.listOfSubjects,
      listOfSections: listOfSections ?? this.listOfSections,
      listOfSubSections: listOfSubSections ?? this.listOfSubSections,
      listOfChildren: listOfChildren ?? this.listOfChildren,
    );
  }
}
