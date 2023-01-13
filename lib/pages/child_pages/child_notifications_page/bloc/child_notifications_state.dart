part of 'child_notifications_bloc.dart';

class ChildNotificationsState extends Equatable {
  const ChildNotificationsState({
    this.assignedChores,
    this.assignedSections,
    this.notifications,
  });

  final List<AssignedChore>? assignedChores;
  final List<AssignedSection>? assignedSections;
  final List<Notification>? notifications;

  @override
  List<Object?> get props => [
        assignedChores,
        assignedSections,
        notifications,
      ];

  ChildNotificationsState copyWith({
    List<AssignedChore>? assignedChores,
    List<AssignedSection>? assignedSections,
    List<Notification>? notifications,
  }) {
    return ChildNotificationsState(
      assignedChores: assignedChores ?? this.assignedChores,
      assignedSections: assignedSections ?? this.assignedSections,
      notifications: notifications ?? this.notifications,
    );
  }
}
