part of 'child_chores_bloc.dart';

class ChildChoresState extends Equatable {
  const ChildChoresState({
    this.choreTitle = const Name.pure(),
    this.description = const Description.pure(),
    this.time = const Time.pure(),
    this.listOfChores,
    this.choreData,
    this.chorePrice,
  });

  final int? chorePrice;
  final Description description;
  final Name choreTitle;
  final Time time;
  final List<ChildChore>? listOfChores;

  final ChildChoreData? choreData;

  @override
  List<Object?> get props => [
        time,
        choreTitle,
        description,
        listOfChores,
        choreData,
        chorePrice,
      ];

  ChildChoresState copyWith({
    Time? time,
    Name? choreTitle,
    Description? description,
    List<ChildChore>? listOfChores,
    ChildChoreData? choreData,
    int? chorePrice,
    ImageModel? choreImage,
  }) {
    return ChildChoresState(
      chorePrice: chorePrice ?? this.chorePrice,
      description: description ?? this.description,
      choreTitle: choreTitle ?? this.choreTitle,
      listOfChores: listOfChores ?? this.listOfChores,
      choreData: choreData ?? this.choreData,
      time: time ?? this.time,
    );
  }
}
