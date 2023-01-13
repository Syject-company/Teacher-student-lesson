part of 'child_chores_bloc.dart';

abstract class ChildChoresEvent extends Equatable {
  const ChildChoresEvent();

  @override
  List<Object> get props => [];
}

class LoadChildChores extends ChildChoresEvent {}

class LoadChore extends ChildChoresEvent {
  const LoadChore({required this.choreId});

  final String choreId;

  @override
  List<Object> get props => [choreId];
}

class CompleteChore extends ChildChoresEvent {
  const CompleteChore({required this.choreId});

  final String choreId;

  @override
  List<Object> get props => [choreId];
}
