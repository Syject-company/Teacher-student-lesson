part of 'chores_bloc.dart';

abstract class ChoresEvent extends Equatable {
  const ChoresEvent();

  @override
  List<Object> get props => [];
}

class LoadChores extends ChoresEvent {}

class LoadChore extends ChoresEvent {
  const LoadChore({required this.choreId});

  final String choreId;

  @override
  List<Object> get props => [choreId];
}

class DeleteChore extends ChoresEvent {
  const DeleteChore({required this.choreId});

  final String choreId;

  @override
  List<Object> get props => [choreId];
}

class ApproveChore extends ChoresEvent {
  const ApproveChore({required this.choreId, required this.childId});

  final String choreId;
  final String childId;

  @override
  List<Object> get props => [choreId, childId];
}

class AsignChild extends ChoresEvent {
  const AsignChild({required this.childId, required this.sectionId});

  final String sectionId;
  final String childId;

  @override
  List<Object> get props => [sectionId, childId];
}

class ChoresNameChanged extends ChoresEvent {
  const ChoresNameChanged({required this.choreTitle});

  final String choreTitle;

  @override
  List<Object> get props => [choreTitle];
}

class ChoresTimeChanged extends ChoresEvent {
  const ChoresTimeChanged({required this.time});

  final String time;

  @override
  List<Object> get props => [time];
}

class PriceChoreChanged extends ChoresEvent {
  const PriceChoreChanged({required this.chorePrice});

  final int chorePrice;

  @override
  List<Object> get props => [chorePrice];
}

class AddChildren extends ChoresEvent {
  const AddChildren({required this.selectedChildren});

  final List<EdChildUsersChore> selectedChildren;

  @override
  List<Object> get props => [selectedChildren];
}

class AddImage extends ChoresEvent {
  const AddImage({required this.selectedChoreImage});

  final ImageModel selectedChoreImage;

  @override
  List<Object> get props => [selectedChoreImage];
}

class DescriptionChoresChanged extends ChoresEvent {
  const DescriptionChoresChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

class CreateChore extends ChoresEvent {
  const CreateChore({required this.createChoreModel});

  final CreateChoreModel createChoreModel;

  @override
  List<Object> get props => [createChoreModel];
}

class LoadChoresChildren extends ChoresEvent {}

class LoadChoresPhoto extends ChoresEvent {}

class UpdateChore extends ChoresEvent {
  const UpdateChore({required this.updateChoreModel});

  final UpdateChoreModel updateChoreModel;

  @override
  List<Object> get props => [updateChoreModel];
}

class EditChoreEvent extends ChoresEvent {
  const EditChoreEvent(
      {required this.choreTitle,
      required this.description,
      required this.time,
      required this.selectedChildren,
      required this.chorePrice,
      required this.selectedChoreImage});
  final int chorePrice;
  final String choreTitle;
  final String description;
  final String time;
  final List<EdChildUsersChore> selectedChildren;
  final ImageModel selectedChoreImage;

  @override
  List<Object> get props => [
        choreTitle,
        description,
        chorePrice,
        selectedChoreImage,
        choreTitle,
        time
      ];
}
