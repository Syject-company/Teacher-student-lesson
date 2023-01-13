part of 'child_notifications_bloc.dart';

abstract class ChildNotificationsEvent extends Equatable {
  const ChildNotificationsEvent();

  @override
  List<Object> get props => [];
}

class LoadChildNotifications extends ChildNotificationsEvent {}
