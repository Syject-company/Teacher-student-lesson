part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class LoadChildById extends SettingEvent {
  const LoadChildById({
    required this.childId,
  });

  final String childId;

  @override
  List<Object> get props => [childId];
}

class LoadSettingChildren extends SettingEvent {}

class LoadSettingPhoto extends SettingEvent {}

class EditNameChanged extends SettingEvent {
  const EditNameChanged({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}

class EditDOBChanged extends SettingEvent {
  const EditDOBChanged({
    required this.dateOfBirth,
  });

  final String dateOfBirth;

  @override
  List<Object> get props => [dateOfBirth];
}

class EditAvatarSelected extends SettingEvent {
  const EditAvatarSelected({
    required this.childImageId,
  });

  final String childImageId;

  @override
  List<Object> get props => [childImageId];
}

class EditChildEvent extends SettingEvent {
  const EditChildEvent({
    required this.childData,
  });

  final EditedChild childData;
  @override
  List<Object> get props => [childData];
}

class DeleteChildEvent extends SettingEvent {
  const DeleteChildEvent({
    required this.childId,
  });

  final String childId;
  @override
  List<Object> get props => [childId];
}
