import 'package:shared_preferences/shared_preferences.dart';

import 'utils/model/compleated_sections/compleated_sections.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
  }

  late SharedPreferences prefs;

  bool isSelectedGrade = false;
  bool isSelectedChild = false;
  bool isSelectedLesson = false;

  CompletedSections correctAnswers = CompletedSections(
      questionOneAnswer: [],
      questionPictureOneAnswer: [],
      questionOneFalseAnswer: [],
      questionTrueFalse: [],
      sectionId: '');
  String firstName = '';

  bool isSelectedSubSection = false;

  bool isLastRound = false;
  var wrongQuestions = [];
  int totalWrongAnswers = 0;
}
