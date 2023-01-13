part of 'child_lessons_bloc.dart';

class ChildLessonsState extends Equatable {
  const ChildLessonsState({
    this.listOfGrades,
    this.listOfSubjects,
    this.listOfSections,
    this.listOfSubSections,
  });

  final List<Grade>? listOfGrades;
  final Subject? listOfSubjects;
  final List<ChildSection>? listOfSections;
  final ChildSubSection? listOfSubSections;

  @override
  List<Object?> get props => [
        listOfGrades,
        listOfSubjects,
        listOfSections,
        listOfSubSections,
      ];

  ChildLessonsState copyWith({
    List<Grade>? listOfGrades,
    Subject? listOfSubjects,
    List<ChildSection>? listOfSections,
    ChildSubSection? listOfSubSections,
  }) {
    return ChildLessonsState(
      listOfGrades: listOfGrades ?? this.listOfGrades,
      listOfSubjects: listOfSubjects ?? this.listOfSubjects,
      listOfSections: listOfSections ?? this.listOfSections,
      listOfSubSections: listOfSubSections ?? this.listOfSubSections,
    );
  }
}
