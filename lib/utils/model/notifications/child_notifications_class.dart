// To parse this JSON data, do
//
//     final childNotifications = childNotificationsFromJson(jsonString);

import 'dart:convert';

ChildNotifications childNotificationsFromJson(String str) =>
    ChildNotifications.fromJson(json.decode(str));

class ChildNotifications {
  ChildNotifications({
    required this.assignedChores,
    required this.assignedSections,
    required this.notifications,
  });

  final List<AssignedChore>? assignedChores;
  final List<AssignedSection>? assignedSections;
  final List<Notification>? notifications;

  factory ChildNotifications.fromJson(Map<String, dynamic> json) =>
      ChildNotifications(
        assignedChores: json["assignedChores"] == null
            ? []
            : List<AssignedChore>.from(
                json["assignedChores"].map((x) => AssignedChore.fromJson(x))),
        assignedSections: json["assignedSections"] == null
            ? []
            : List<AssignedSection>.from(json["assignedSections"]
                .map((x) => AssignedSection.fromJson(x))),
        notifications: json["notifications"] == null
            ? []
            : List<Notification>.from(
                json["notifications"].map((x) => Notification.fromJson(x))),
      );
}

class AssignedChore {
  AssignedChore({
    required this.id,
    required this.title,
    required this.price,
    required this.choreImage,
  });

  final String id;
  final String title;
  final int price;
  final Image choreImage;

  factory AssignedChore.fromJson(Map<String, dynamic> json) => AssignedChore(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        choreImage: Image.fromJson(json["choreImage"]),
      );
}

class Image {
  Image({
    required this.id,
    required this.url,
  });

  final String id;
  final String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        url: json["url"],
      );
}

class AssignedSection {
  AssignedSection({
    required this.id,
    required this.title,
    required this.points,
    required this.sectionImage,
  });

  final String id;
  final String title;
  final int points;
  final Image sectionImage;

  factory AssignedSection.fromJson(Map<String, dynamic> json) =>
      AssignedSection(
        id: json["id"],
        title: json["title"],
        points: json["points"],
        sectionImage: Image.fromJson(json["sectionImage"]),
      );
}

class Notification {
  Notification({
    required this.id,
    required this.title,
    required this.points,
  });

  final String id;
  final String title;
  final int points;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        title: json["title"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "points": points,
      };
}
