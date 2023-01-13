part of 'setting_bloc.dart';

class SettingState extends Equatable {
  const SettingState({
    this.listOfChildren,
    this.childById,
    this.photo,
    this.status = FormzStatus.valid,
    this.childImageId,
    this.name = const Name.pure(),
    this.dateOfBirth = const YearOfBirth.pure(),
  });

  final List<ManageChildModel>? listOfChildren;
  final ChildById? childById;
  final List<ImageModel>? photo;
  final Name? name;
  final YearOfBirth? dateOfBirth;
  final String? childImageId;
  final FormzStatus? status;
  @override
  List<Object?> get props => [
        listOfChildren,
        childById,
        photo,
        name,
        dateOfBirth,
        childImageId,
        status
      ];

  SettingState copyWith({
    List<ManageChildModel>? listOfChildren,
    ChildById? childById,
    List<ImageModel>? photo,
    Name? name,
    YearOfBirth? dateOfBirth,
    String? childImageId,
    FormzStatus? status,
  }) {
    return SettingState(
      listOfChildren: listOfChildren ?? this.listOfChildren,
      childById: childById ?? this.childById,
      photo: photo ?? this.photo,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      childImageId: childImageId ?? this.childImageId,
      status: status ?? this.status,
    );
  }
}
