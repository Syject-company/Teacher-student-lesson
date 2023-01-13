class ChildPoints {
  ChildPoints({
    required this.id,
    required this.points,
  });

  final String id;
  final int points;

  factory ChildPoints.fromJson(Map<String, dynamic> json) => ChildPoints(
        id: json["id"],
        points: json["points"],
      );
}
