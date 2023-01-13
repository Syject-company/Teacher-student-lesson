class SubSection {
  SubSection({
    required this.id,
    required this.questions,
    required this.title,
    required this.points,
    required this.difficalties,
    required this.dateOfCreation,
    required this.completed,
    required this.bestScore,
    required this.bestScoreDate,
    required this.sectionImage,
    required this.assignedChildUsersSections,
    required this.completedChildUsersSections,
    required this.childUserSectionStatistics,
  });

  final String id;
  final int questions;
  final String title;
  final int points;
  final List<Difficalty> difficalties;
  final DateTime dateOfCreation;
  final int completed;
  final Map<String, int> bestScore;
  final DateTime bestScoreDate;
  final SectionImage sectionImage;
  final List<AssignedChildUsersSection> assignedChildUsersSections;
  final List<CompletedChildUsersSection> completedChildUsersSections;
  final List<ChildUserSectionStatistic> childUserSectionStatistics;

  factory SubSection.fromJson(Map<String, dynamic> json) => SubSection(
        id: json["id"],
        questions: json["questions"],
        title: json["title"],
        points: json["points"],
        difficalties: List<Difficalty>.from(
            json["difficalties"].map((x) => Difficalty.fromJson(x))),
        dateOfCreation: DateTime.parse(json["dateOfCreation"]),
        completed: json["completed"],
        bestScore: Map.from(json["bestScore"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        bestScoreDate: DateTime.parse(json["bestScoreDate"]),
        sectionImage: SectionImage.fromJson(json["sectionImage"]),
        assignedChildUsersSections: json["assignedChildUsersSections"] == null
            ? []
            : List<AssignedChildUsersSection>.from(
                json["assignedChildUsersSections"]
                    .map((x) => AssignedChildUsersSection.fromJson(x))),
        completedChildUsersSections: json["completedChildUsersSections"] == null
            ? []
            : List<CompletedChildUsersSection>.from(
                json["completedChildUsersSections"]
                    .map((x) => CompletedChildUsersSection.fromJson(x))),
        childUserSectionStatistics: json["childUserSectionStatistics"] == null
            ? []
            : List<ChildUserSectionStatistic>.from(
                json["childUserSectionStatistics"]
                    .map((x) => ChildUserSectionStatistic.fromJson(x))),
      );
}

class Difficalty {
  Difficalty({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Difficalty.fromJson(Map<String, dynamic> json) => Difficalty(
        id: json["id"],
        name: json["name"],
      );
}

class SectionImage {
  SectionImage({
    required this.id,
    required this.url,
  });

  final String id;
  final String url;

  factory SectionImage.fromJson(Map<String, dynamic> json) => SectionImage(
        id: json["id"],
        url: json["url"],
      );
}

class AssignedChildUsersSection {
  AssignedChildUsersSection({
    required this.id,
    required this.birthDate,
    required this.name,
    required this.childImage,
    required this.childUserStatistic,
  });

  final String id;
  final DateTime birthDate;
  final String name;
  final ChildImage childImage;
  final ChildUserStatistic? childUserStatistic;

  factory AssignedChildUsersSection.fromJson(Map<String, dynamic> json) =>
      AssignedChildUsersSection(
        id: json["id"],
        birthDate: DateTime.parse(json["birthDate"]),
        name: json["name"],
        childImage: ChildImage.fromJson(json["childImage"]),
        childUserStatistic: json["childUserStatistic"] == null
            ? ChildUserStatistic(id: '', points: 0)
            : ChildUserStatistic.fromJson(json["childUserStatistic"]),
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

class ChildUserStatistic {
  ChildUserStatistic({
    required this.id,
    required this.points,
  });

  final String id;
  final int points;

  factory ChildUserStatistic.fromJson(Map<String, dynamic> json) =>
      ChildUserStatistic(
        id: json["id"],
        points: json["points"],
      );
}

class CompletedChildUsersSection {
  CompletedChildUsersSection({
    required this.id,
    required this.birthDate,
    required this.name,
    required this.childImage,
    required this.childUserStatistic,
  });

  final String id;
  final DateTime birthDate;
  final String name;
  final ChildImage childImage;
  final ChildUserStatistic? childUserStatistic;

  factory CompletedChildUsersSection.fromJson(Map<String, dynamic> json) =>
      CompletedChildUsersSection(
        id: json["id"],
        birthDate: DateTime.parse(json["birthDate"]),
        name: json["name"],
        childImage: ChildImage.fromJson(json["childImage"]),
        childUserStatistic:
            ChildUserStatistic.fromJson(json["childUserStatistic"]),
      );
}

class ChildUserSectionStatistic {
  ChildUserSectionStatistic({
    required this.id,
  });

  final String id;

  factory ChildUserSectionStatistic.fromJson(Map<String, dynamic> json) =>
      ChildUserSectionStatistic(
        id: json["id"],
      );
}
