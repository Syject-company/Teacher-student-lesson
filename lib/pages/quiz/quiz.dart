import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor/app_state.dart';
import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
import 'package:tutor/pages/child_pages/child_lessons_page/bloc/child_lessons_bloc.dart';
import 'package:tutor/pages/quiz/quiz_pause_page.dart';
import 'package:tutor/pages/quiz/quiz_title.dart';
import 'package:tutor/utils/model/compleated_sections/compleated_sections.dart';
import 'package:tutor/utils/model/sub_section/child_sub_section.dart';
import 'package:tutor/utils/repository/repositories.dart';

bool? rightPrevious;
int rightAnswersRow = 0;

class QuizWidget extends StatefulWidget {
  final ChildLessonsState state;
  final completedSections;
  final questions;
  const QuizWidget(
      {Key? key, required this.state, this.questions, this.completedSections})
      : super(key: key);

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late PageController controller;
  int _questionsNumber = 1;
  CompletedSections completedSections = CompletedSections(
    questionOneAnswer: [],
    questionOneFalseAnswer: [],
    questionPictureOneAnswer: [],
    questionTrueFalse: [],
    sectionId: '',
  );

  var questions = [];

  var nextQuestion;
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    maper(ChildSubSection model) {
      model.questionOneAnswer.toList().forEach((e) => questions.add(e));

      model.questionOneFalseAnswer.toList().forEach((e) => questions.add(e));

      model.questionPictureOneAnswer.toList().forEach((e) => questions.add(e));

      model.questionTrueFalseAnswer.toList().forEach((e) => questions.add(e));
      return questions;
    }

    if (widget.questions == null) {
      questions = maper(widget.state.listOfSubSections!);
    } else {
      questions = widget.questions;
    }
  }

  @override
  Widget build(BuildContext context) {
    int? totalItems = 10;
    // if (questions.length < 10) {
    //   totalItems = questions.length;
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          QuizTopTitle(),
          QuizSectionTitle(),
          QuizQuestionNumber(text: 'Question $_questionsNumber'),
          QuestionIndicator(
              questionsNumber: _questionsNumber,
              totalQuestions: !FFAppState().isLastRound
                  ? totalItems
                  : FFAppState().totalWrongAnswers),
          Expanded(
              child: PageView.builder(
            controller: controller,
            itemCount: totalItems,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (rightPrevious != null &&
                  rightPrevious! &&
                  rightAnswersRow > 1) {
                nextQuestion = questions.firstWhere(
                    (e) => e.difficalty.name == "Medium",
                    orElse: (() => questions
                        .firstWhere((e) => e.difficalty.name == "Easy")));
              } else if (rightPrevious != null && !rightPrevious!) {
                nextQuestion = questions.firstWhere(
                    (e) => e.difficalty.name == "Easy",
                    orElse: (() => questions
                        .firstWhere((e) => e.difficalty.name == "Medium")));
              } else {
                nextQuestion = questions.first;
              }
              if (nextQuestion.pattern == 0) {
                return buildQuestionOneAnswer(
                    nextQuestion as QuestionOneAnswer);
              }
              if (nextQuestion.pattern == 1) {
                return buildQuestionTrueFalseAnswer(
                    nextQuestion as QuestionTrueFalseAnswer);
              }
              if (nextQuestion.pattern == 2) {
                return buildQuestionOneFalseAnswer(
                    nextQuestion as QuestionOneFalseAnswer);
              }
              if (nextQuestion.pattern == 3) {
                return buildQuestionPictureOneAnswer(
                    nextQuestion as QuestionPictureOneAnswer);
              }

              return SizedBox.shrink();
            },
          )),
          Padding(
            padding: REdgeInsets.only(bottom: 44),
            child: FFButtonWidget(
              onPressed: () {
                if (_questionsNumber == FFAppState().totalWrongAnswers) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => ChildLessonsBloc(
                          userRepository: UserRepository(),
                        ),
                        child: QuizPausePage(
                          isEnd: true,
                          state: widget.state,
                          correctAnswers:
                              '${completedSections.questionOneAnswer.length + completedSections.questionOneFalseAnswer.length + completedSections.questionPictureOneAnswer.length + completedSections.questionTrueFalse.length}/${!FFAppState().isLastRound ? '10' : FFAppState().totalWrongAnswers}',
                          completedSections: completedSections,
                          questions: questions,
                        ),
                      ),
                    ),
                  );
                }
                if ((_questionsNumber == 10 || totalItems == 1) &&
                    !FFAppState().isLastRound) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => ChildLessonsBloc(
                          userRepository: UserRepository(),
                        ),
                        child: QuizPausePage(
                          state: widget.state,
                          correctAnswers:
                              '${completedSections.questionOneAnswer.length + completedSections.questionOneFalseAnswer.length + completedSections.questionPictureOneAnswer.length + completedSections.questionTrueFalse.length}/10',
                          completedSections: completedSections,
                          questions: questions,
                        ),
                      ),
                    ),
                  );
                }
                setState(
                  () {
                    if (rightPrevious == true) {
                      if (nextQuestion.pattern == 0) {
                        completedSections.questionOneAnswer
                            .add(nextQuestion.id);
                      }
                      if (nextQuestion.pattern == 1) {
                        completedSections.questionOneFalseAnswer
                            .add(nextQuestion.id);
                      }
                      if (nextQuestion.pattern == 2) {
                        completedSections.questionPictureOneAnswer
                            .add(nextQuestion.id);
                      }
                      if (nextQuestion.pattern == 3) {
                        completedSections.questionTrueFalse
                            .add(nextQuestion.id);
                      }
                      rightAnswersRow++;
                    }
                    if (rightPrevious == false && !FFAppState().isLastRound) {
                      rightAnswersRow = 0;
                      if (nextQuestion.pattern == 0) {
                        nextQuestion.isLocked = false;
                        nextQuestion.selectedOption = null;
                      }
                      if (nextQuestion.pattern == 1) {
                        nextQuestion.isLocked = false;
                        nextQuestion.selectedOption = null;
                      }
                      if (nextQuestion.pattern == 2) {
                        nextQuestion.selectedOptions1 = null;
                        nextQuestion.selectedOptions2 = null;
                        nextQuestion.selectedOptions3 = null;

                        nextQuestion.isLocked1 = false;
                        nextQuestion.isLocked2 = false;
                        nextQuestion.isLocked3 = false;
                      }
                      if (nextQuestion.pattern == 3) {
                        nextQuestion.isLocked = false;
                        nextQuestion.selectedOption = null;
                      }
                      FFAppState().wrongQuestions.add(nextQuestion);
                      print(FFAppState().wrongQuestions.length);
                    }
                    _questionsNumber++;
                    if (questions.length != 1) {
                      questions.remove(nextQuestion);
                      print(FFAppState().wrongQuestions.length);
                    }
                  },
                );
              },
              text: 'Next',
              options: FFButtonOptions(
                width: 360.w,
                height: 60.h,
                color: Color(0xFF2BC0EF),
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildQuestionOneAnswer(QuestionOneAnswer question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 140.h,
          margin: REdgeInsets.fromLTRB(35, 50, 35, 50),
          child: AutoSizeText(
            question.question,
            style: TextStyle(fontSize: 25),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            child: OptionsOneAnswer(
          question: question,
          onClickedOption: (Option option) {
            if (question.isLocked) {
              return;
            } else {
              setState(() {
                question.isLocked = true;
                question.selectedOption = option;
              });
            }
          },
        ))
      ],
    );
  }

  Widget buildQuestionOneFalseAnswer(QuestionOneFalseAnswer question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 140.h,
          margin: REdgeInsets.fromLTRB(35, 50, 35, 50),
          child: AutoSizeText(
            question.question,
            style: TextStyle(fontSize: 25),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            child: OptionsOneFalseAnswer(
          question: question,
          onClickedOption: (
            Option option,
          ) {
            {
              if (question.isLocked1 && question.isLocked2) {
                setState(() {
                  question.isLocked3 = true;
                  question.selectedOptions3 = option;
                });
              }
              if (question.isLocked1 && !question.isLocked2) {
                setState(() {
                  question.isLocked2 = true;
                  question.selectedOptions2 = option;
                });
              }
              if (!question.isLocked1 &&
                  !question.isLocked2 &&
                  !question.isLocked3) {
                setState(() {
                  question.isLocked1 = true;
                  question.selectedOptions1 = option;
                });
              }
            }
          },
        ))
      ],
    );
  }

  Widget buildQuestionTrueFalseAnswer(QuestionTrueFalseAnswer question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 140.h,
          margin: REdgeInsets.fromLTRB(35, 50, 35, 50),
          child: AutoSizeText(
            question.question,
            style: TextStyle(fontSize: 25),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            child: OptionsTrueFalseAnswer(
          question: question,
          onClickedOption: (Option option) {
            if (question.isLocked) {
              return;
            } else {
              setState(() {
                question.isLocked = true;
                question.selectedOption = option;
              });
            }
          },
        ))
      ],
    );
  }

  Widget buildQuestionPictureOneAnswer(QuestionPictureOneAnswer question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 140.h,
          margin: REdgeInsets.fromLTRB(35, 50, 35, 50),
          child: AutoSizeText(
            question.question,
            style: TextStyle(fontSize: 25),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            child: OptionsFourthPattern(
          question: question,
          onClickedOption: (Option option) {
            if (question.isLocked) {
              return;
            } else {
              setState(() {
                question.isLocked = true;
                question.selectedOption = option;
              });
            }
          },
        ))
      ],
    );
  }
}

class OptionsOneAnswer extends StatelessWidget {
  final QuestionOneAnswer question;
  final ValueChanged<Option> onClickedOption;
  const OptionsOneAnswer({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          question.variant1,
          question.variant2,
          question.variant3,
          question.questionOneAnswerTrue,
        ]
            .map((option) => buildFirstOption(context,
                Option(text: option, correct: question.questionOneAnswerTrue)))
            .toList(),
      ),
    );
  }

  Widget buildFirstOption(BuildContext context, Option option) {
    final color = getFirstColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.fromLTRB(29, 20, 0, 20),
        margin: REdgeInsets.fromLTRB(25, 0, 25, 8),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            color: Color.fromRGBO(245, 246, 250, 1),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          option.text,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 17.sp,
            color: Color.fromRGBO(66, 63, 63, 1),
          ),
        ),
      ),
    );
  }

  Color getFirstColorForOption(Option option, QuestionOneAnswer question) {
    final isSelected = option.text == question.selectedOption?.text;
    if (question.isLocked) {
      if (isSelected) {
        if (option.text == option.correct) {
          rightPrevious = true;
        }
        if (option.text != option.correct) {
          rightPrevious = false;
        }
        return option.text == option.correct ? Colors.green : Colors.red;
      } else if (option.text == option.correct) {
        return Colors.green;
      }
    }
    return Colors.transparent;
  }
}

class OptionsOneFalseAnswer extends StatelessWidget {
  final QuestionOneFalseAnswer question;
  final ValueChanged<Option> onClickedOption;
  const OptionsOneFalseAnswer({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          question.variant1,
          question.variant3,
          question.variant2,
          question.questionOneFalseAnswerFalse,
        ]
            .map((option) => buildThirdOption(
                context,
                Option(
                    text: option,
                    correct: question.questionOneFalseAnswerFalse)))
            .toList(),
      ),
    );
  }

  Widget buildThirdOption(BuildContext context, Option option) {
    final color = getThirdColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.fromLTRB(29, 20, 0, 20),
        margin: REdgeInsets.fromLTRB(25, 0, 25, 8),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            color: Color.fromRGBO(245, 246, 250, 1),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          option.text,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 17.sp,
            color: Color.fromRGBO(66, 63, 63, 1),
          ),
        ),
      ),
    );
  }

  Color getThirdColorForOption(
    Option option,
    QuestionOneFalseAnswer question,
  ) {
    if (question.isLocked3) {
      final isSelected3 = option.text == question.selectedOptions3?.text;
      if (isSelected3) {
        if ((option.text != option.correct) && rightPrevious == true) {
          rightPrevious = false;
        }
        if (option.text == option.correct) {
          rightPrevious = true;
        }

        return question.selectedOptions3?.text == option.correct
            ? Colors.red
            : Colors.green;
      } else if (option.text != option.correct) {
        return Colors.green;
      }
    }
    if (question.isLocked1) {
      final isSelected1 = option.text == question.selectedOptions1?.text;
      if (isSelected1) {
        if (option.text != option.correct) {
          rightPrevious = false;
        }
        return option.text == option.correct ? Colors.red : Colors.green;
      }
    }
    if (question.isLocked2) {
      final isSelected2 = option.text == question.selectedOptions2?.text;
      if (isSelected2) {
        if (option.text != option.correct) {
          rightPrevious = false;
        }
        return question.selectedOptions2?.text == option.correct
            ? Colors.red
            : Colors.green;
      }
    }

    return Colors.transparent;
  }
}

class OptionsTrueFalseAnswer extends StatelessWidget {
  final QuestionTrueFalseAnswer question;
  final ValueChanged<Option> onClickedOption;
  const OptionsTrueFalseAnswer({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          question.questionTrueFalseAnswerFalse,
          question.questionTrueFalseAnswerTrue,
        ]
            .map((option) => buildSecondOption(
                context,
                Option(
                    text: option,
                    correct: question.questionTrueFalseAnswerTrue)))
            .toList(),
      ),
    );
  }

  Widget buildSecondOption(BuildContext context, Option option) {
    final color = getSecondColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.fromLTRB(29, 20, 0, 20),
        margin: REdgeInsets.fromLTRB(25, 0, 25, 8),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            color: Color.fromRGBO(245, 246, 250, 1),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          option.text,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 17.sp,
            color: Color.fromRGBO(66, 63, 63, 1),
          ),
        ),
      ),
    );
  }

  Color getSecondColorForOption(
      Option option, QuestionTrueFalseAnswer question) {
    final isSelected = option.text == question.selectedOption?.text;
    if (question.isLocked) {
      if (isSelected) {
        if (option.text == option.correct) {
          rightPrevious = true;
        }
        if (option.text != option.correct) {
          rightPrevious = false;
        }
        return option.text == option.correct ? Colors.green : Colors.red;
      } else if (option.text == option.correct) {
        return Colors.green;
      }
    }
    return Colors.transparent;
  }
}

class OptionsFourthPattern extends StatelessWidget {
  final QuestionPictureOneAnswer question;
  final ValueChanged<Option> onClickedOption;
  const OptionsFourthPattern({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          question.variant1,
          question.variant3,
          question.variant2,
          question.questionPictureOneAnswerTrue,
        ]
            .map((option) => buildFourthOption(
                context,
                Option(
                    text: option,
                    correct: question.questionPictureOneAnswerTrue)))
            .toList(),
      ),
    );
  }

  Widget buildFourthOption(BuildContext context, Option option) {
    final color = getFourthColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.fromLTRB(29, 20, 0, 20),
        margin: REdgeInsets.fromLTRB(25, 0, 25, 8),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            color: Color.fromRGBO(245, 246, 250, 1),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          option.text,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 17.sp,
            color: Color.fromRGBO(66, 63, 63, 1),
          ),
        ),
      ),
    );
  }

  Color getFourthColorForOption(
      Option option, QuestionPictureOneAnswer question) {
    final isSelected = option.text == question.selectedOption?.text;
    if (question.isLocked) {
      if (isSelected) {
        if (option.text == option.correct) {
          rightPrevious = true;
        }
        if (option.text != option.correct) {
          rightPrevious = false;
        }
        return option.text == option.correct ? Colors.green : Colors.red;
      } else if (option.text == option.correct) {
        return Colors.green;
      }
    }
    return Colors.transparent;
  }
}

class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  String text;
  final String correct;
  Option({
    required this.text,
    required this.correct,
  });
}

class QuestionIndicator extends StatelessWidget {
  const QuestionIndicator(
      {Key? key, required int questionsNumber, required this.totalQuestions})
      : _questionsNumber = questionsNumber,
        super(key: key);

  final int _questionsNumber;
  final int? totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 50),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: LinearProgressIndicator(
              value: _questionsNumber / totalQuestions!,
              color: Color(0xFF2BC0EF),
              backgroundColor: Color.fromRGBO(217, 217, 217, 1),
              minHeight: 12,
            ),
          ),
          Row(
            children:
                List.generate(totalQuestions!, (index) => ProgressBarSection()),
          )
        ],
      ),
    );
  }
}

class ProgressBarSection extends StatelessWidget {
  const ProgressBarSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        foregroundDecoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(1, 0),
                blurStyle: BlurStyle.outer),
            BoxShadow(
                color: Colors.white,
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(-1, 0),
                blurStyle: BlurStyle.outer),
          ],
          color: Colors.transparent,
          border: Border.all(
              color: Colors.white, width: 4, style: BorderStyle.solid),
        ),
        height: 13,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 4),
        ),
      ),
    );
  }
}
