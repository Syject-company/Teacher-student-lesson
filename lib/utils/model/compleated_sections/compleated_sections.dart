class CompletedSections {
  CompletedSections({
    required this.sectionId,
    required this.questionOneAnswer,
    required this.questionOneFalseAnswer,
    required this.questionPictureOneAnswer,
    required this.questionTrueFalse,
  });

  String sectionId;
  final List<String> questionOneAnswer;
  final List<String> questionOneFalseAnswer;
  final List<String> questionPictureOneAnswer;
  final List<String> questionTrueFalse;

  factory CompletedSections.fromJson(Map<String, dynamic> json) =>
      CompletedSections(
        sectionId: json["sectionId"],
        questionOneAnswer:
            List<String>.from(json["questionOneAnswer"].map((x) => x)),
        questionOneFalseAnswer:
            List<String>.from(json["questionOneFalseAnswer"].map((x) => x)),
        questionPictureOneAnswer:
            List<String>.from(json["questionPictureOneAnswer"].map((x) => x)),
        questionTrueFalse:
            List<String>.from(json["questionTrueFalse"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sectionId": sectionId,
        "questionOneAnswer":
            List<dynamic>.from(questionOneAnswer.map((x) => x)),
        "questionOneFalseAnswer":
            List<dynamic>.from(questionOneFalseAnswer.map((x) => x)),
        "questionPictureOneAnswer":
            List<dynamic>.from(questionPictureOneAnswer.map((x) => x)),
        "questionTrueFalse":
            List<dynamic>.from(questionTrueFalse.map((x) => x)),
      };
}
