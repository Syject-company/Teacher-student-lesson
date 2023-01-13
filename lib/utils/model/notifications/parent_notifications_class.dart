// To parse this JSON data, do
//
//     final parentNotification = parentNotificationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ParentNotification> parentNotificationFromJson(String str) =>
    List<ParentNotification>.from(
        json.decode(str).map((x) => ParentNotification.fromJson(x)));

class ParentNotification {
  ParentNotification({
    required this.id,
    required this.title,
    required this.childUser,
    required this.points,
  });

  final String id;
  final String title;
  final ChildUser childUser;
  final int points;

  factory ParentNotification.fromJson(Map<String, dynamic> json) =>
      ParentNotification(
        id: json["id"],
        title: json["title"],
        childUser: ChildUser.fromJson(json["childUser"]),
        points: json["points"],
      );
}

class ChildUser {
  ChildUser({
    required this.id,
    required this.name,
    required this.childImage,
  });

  final String id;
  final String name;
  final ChildImage childImage;

  factory ChildUser.fromJson(Map<String, dynamic> json) => ChildUser(
        id: json["id"],
        name: json["name"],
        childImage: ChildImage.fromJson(json["childImage"]),
      );
}

class ChildImage {
  ChildImage({
    required this.id,
    required this.url,
  });

  final String id;
  final String url;

  factory ChildImage.fromJson(Map<String, dynamic> json) => ChildImage(
        id: json["id"],
        url: json["url"],
      );
}
