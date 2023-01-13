part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  const HomePageState({
    this.parentNotifications,
  });

  final List<ParentNotification>? parentNotifications;

  @override
  List<Object?> get props => [
        parentNotifications,
      ];

  HomePageState copyWith({
    List<ParentNotification>? parentNotifications,
  }) {
    return HomePageState(
      parentNotifications: parentNotifications ?? this.parentNotifications,
    );
  }
}
