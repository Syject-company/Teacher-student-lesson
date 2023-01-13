part of 'chores_bloc.dart';

class ChoresState extends Equatable {
  const ChoresState({
    this.choreTitle = const Name.pure(),
    this.description = const Description.pure(),
    this.time = const Time.pure(),
    this.listOfChores,
    this.choreData,
    this.listOfChildren,
    this.status = FormzStatus.pure,
    this.selectedChildren,
    this.listOfPhoto,
    this.selectedChoreImage,
    this.chorePrice,
    this.updateChoreModel,
    this.updateCalled = false,
    this.createChoreModel,
  });

  final bool? updateCalled;
  final int? chorePrice;
  final Description description;
  final Name choreTitle;
  final Time time;
  final List<Chore>? listOfChores;
  final List<EdChildUsersChore>? listOfChildren;
  final List<EdChildUsersChore>? selectedChildren;
  final Chore? choreData;
  final FormzStatus status;
  final List<ImageModel>? listOfPhoto;
  final ImageModel? selectedChoreImage;
  final CreateChoreModel? createChoreModel;
  final UpdateChoreModel? updateChoreModel;

  @override
  List<Object?> get props => [
        time,
        updateChoreModel,
        choreTitle,
        description,
        listOfChores,
        status,
        choreData,
        listOfChildren,
        selectedChildren,
        listOfPhoto,
        selectedChoreImage,
        createChoreModel,
        chorePrice,
        updateCalled
      ];

  ChoresState copyWith({
    Time? time,
    bool? updateCalled,
    Name? choreTitle,
    Description? description,
    FormzStatus? status,
    List<Chore>? listOfChores,
    List<EdChildUsersChore>? listOfChildren,
    List<EdChildUsersChore>? selectedChildren,
    Chore? choreData,
    int? chorePrice,
    List<ImageModel>? listOfPhoto,
    ImageModel? choreImage,
    CreateChoreModel? createChoreModel,
    UpdateChoreModel? updateChoreModel,
  }) {
    return ChoresState(
      createChoreModel: createChoreModel ?? this.createChoreModel,
      chorePrice: chorePrice ?? this.chorePrice,
      status: status ?? this.status,
      description: description ?? this.description,
      choreTitle: choreTitle ?? this.choreTitle,
      listOfChores: listOfChores ?? this.listOfChores,
      choreData: choreData ?? this.choreData,
      selectedChoreImage: choreImage ?? this.selectedChoreImage,
      listOfChildren: listOfChildren ?? this.listOfChildren,
      selectedChildren: selectedChildren ?? this.selectedChildren,
      listOfPhoto: listOfPhoto ?? this.listOfPhoto,
      updateChoreModel: updateChoreModel ?? this.updateChoreModel,
      updateCalled: updateCalled ?? this.updateCalled,
      time: time ?? this.time,
    );
  }
}
