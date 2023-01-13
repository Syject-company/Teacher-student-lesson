import 'package:tutor/pages/quiz/quiz.dart';

enum Pattent {
  questionOneAnswer,
  questionTrueFalseAnswer,
  questionOneFalseAnswer,
  questionPictureOneAnswer
}

class BasePatern {
  BasePatern(
    this.id,
    this.difficalty,
    this.pattern,
  );
  final String id;
  final Difficalty difficalty;
  int pattern;
}

class ChildSubSection {
  ChildSubSection({
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
    required this.questionOneAnswer,
    required this.questionTrueFalseAnswer,
    required this.questionOneFalseAnswer,
    required this.questionPictureOneAnswer,
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
  final List<QuestionOneAnswer> questionOneAnswer;
  final List<QuestionTrueFalseAnswer> questionTrueFalseAnswer;
  final List<QuestionOneFalseAnswer> questionOneFalseAnswer;
  final List<QuestionPictureOneAnswer> questionPictureOneAnswer;

  factory ChildSubSection.fromJson(Map<String, dynamic> json) =>
      ChildSubSection(
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
        questionOneAnswer: List<QuestionOneAnswer>.from(
            json["questionOneAnswer"]
                .map((x) => QuestionOneAnswer.fromJson(x))),
        questionTrueFalseAnswer: List<QuestionTrueFalseAnswer>.from(
            json["questionTrueFalseAnswer"]
                .map((x) => QuestionTrueFalseAnswer.fromJson(x))),
        questionOneFalseAnswer: List<QuestionOneFalseAnswer>.from(
            json["questionOneFalseAnswer"]
                .map((x) => QuestionOneFalseAnswer.fromJson(x))),
        questionPictureOneAnswer: List<QuestionPictureOneAnswer>.from(
            json["questionPictureOneAnswer"]
                .map((x) => QuestionPictureOneAnswer.fromJson(x))),
      );
  maper(ChildSubSection model) {
    var questions = <BasePatern>[];
    model.questionOneAnswer.map((e) => questions.add(e));

    model.questionOneFalseAnswer.map((e) => questions.add(e));

    model.questionPictureOneAnswer.map((e) => questions.add(e));

    model.questionTrueFalseAnswer.map((e) => questions.add(e));
    return questions;
  }
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

class QuestionImage {
  QuestionImage({
    required this.id,
    required this.url,
  });

  final String id;
  final String url;

  factory QuestionImage.fromJson(Map<String, dynamic> json) => QuestionImage(
        id: json["id"],
        url: json["url"],
      );
}

class QuestionTrueFalseAnswer extends BasePatern {
  QuestionTrueFalseAnswer({
    required this.id,
    required this.difficalty,
    required this.question,
    required this.questionTrueFalseAnswerTrue,
    required this.questionTrueFalseAnswerFalse,
    this.isLocked = false,
  }) : super(id, difficalty, 1);

  final String id;
  final Difficalty difficalty;
  final String question;
  final String questionTrueFalseAnswerTrue;
  final String questionTrueFalseAnswerFalse;
  bool isLocked;
  Option? selectedOption;

  factory QuestionTrueFalseAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionTrueFalseAnswer(
        id: json["id"],
        difficalty: Difficalty.fromJson(json["difficalty"]),
        question: json["question"],
        questionTrueFalseAnswerTrue: json["true"],
        questionTrueFalseAnswerFalse: json["false"],
      );
}

class QuestionOneFalseAnswer extends BasePatern {
  QuestionOneFalseAnswer({
    required this.id,
    required this.difficalty,
    required this.question,
    required this.variant1,
    required this.variant2,
    required this.variant3,
    this.isLocked1 = false,
    this.isLocked2 = false,
    this.isLocked3 = false,
    required this.questionOneFalseAnswerFalse,
  }) : super(id, difficalty, 2);

  final String id;
  final Difficalty difficalty;
  final String question;
  final String variant1;
  final String variant2;
  final String variant3;
  Option? selectedOptions1;
  Option? selectedOptions2;
  Option? selectedOptions3;

  bool isLocked1;
  bool isLocked2;
  bool isLocked3;
  final String questionOneFalseAnswerFalse;

  factory QuestionOneFalseAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionOneFalseAnswer(
        id: json["id"],
        difficalty: Difficalty.fromJson(json["difficalty"]),
        question: json["question"],
        variant1: json["variant1"],
        variant2: json["variant2"],
        variant3: json["variant3"],
        questionOneFalseAnswerFalse: json["false"],
      );
}

class QuestionOneAnswer extends BasePatern {
  QuestionOneAnswer({
    required this.id,
    required this.difficalty,
    required this.question,
    required this.variant1,
    required this.variant2,
    required this.variant3,
    required this.questionOneAnswerTrue,
    this.isLocked = false,
  }) : super(id, difficalty, 0);

  final String id;
  final Difficalty difficalty;
  final String question;
  final String variant1;
  final String variant2;
  final String variant3;
  final String questionOneAnswerTrue;
  Option? selectedOption;
  bool isLocked;

  factory QuestionOneAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionOneAnswer(
        id: json["id"],
        difficalty: Difficalty.fromJson(json["difficalty"]),
        question: json["question"],
        variant1: json["variant1"],
        variant2: json["variant2"],
        variant3: json["variant3"],
        questionOneAnswerTrue: json["true"],
      );
}

class QuestionPictureOneAnswer extends BasePatern {
  QuestionPictureOneAnswer({
    required this.id,
    required this.difficalty,
    required this.question,
    required this.variant1,
    required this.variant2,
    required this.variant3,
    required this.questionPictureOneAnswerTrue,
    required this.questionImage,
    this.isLocked = false,
  }) : super(id, difficalty, 3);

  final String id;
  final Difficalty difficalty;
  final String question;
  final String variant1;
  final String variant2;
  final String variant3;
  final String questionPictureOneAnswerTrue;
  final QuestionImage questionImage;
  Option? selectedOption;
  bool isLocked;

  factory QuestionPictureOneAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionPictureOneAnswer(
        id: json["id"],
        difficalty: Difficalty.fromJson(json["difficalty"]),
        question: json["question"],
        variant1: json["variant1"],
        variant2: json["variant2"],
        variant3: json["variant3"],
        questionPictureOneAnswerTrue: json["true"],
        questionImage: QuestionImage.fromJson(json["questionImage"]),
      );
}
