// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tutor/flutter_flow/flutter_flow_theme.dart';
// import 'package:tutor/flutter_flow/flutter_flow_widgets.dart';
// import 'package:tutor/pages/child_pages/child_lessons_page/bloc/child_lessons_bloc.dart';

// import 'package:tutor/pages/quiz/quiz_title.dart';
// import 'package:tutor/utils/model/compleated_sections/compleated_sections.dart';
// import 'package:tutor/utils/model/sub_section/child_sub_section.dart';

// bool? rightPrevious;
// int rightAnswersRow = 0;

// class QuizWidget2 extends StatefulWidget {
//   final ChildLessonsState state;
//   final questions;
//   final CompletedSections completedSections;
//   const QuizWidget2(
//       {Key? key,
//       required this.questions,
//       required this.state,
//       required this.completedSections})
//       : super(key: key);

//   @override
//   State<QuizWidget2> createState() => _QuizWidget2State();
// }

// class _QuizWidget2State extends State<QuizWidget2> {
//   late PageController controller;
//   int _questionsNumber = 1;

//   var nextQuestion;
//   @override
//   void initState() {
//     super.initState();
//     controller = PageController(initialPage: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     CompletedSections completedSections = widget.completedSections;
//     final int? totalItems = widget.questions.length;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           QuizTopTitle(),
//           QuizSectionTitle(),
//           QuizQuestionNumber(text: 'Question $_questionsNumber'),
//           QuestionIndicator(
//               questionsNumber: _questionsNumber, totalQuestions: 10),
//           Expanded(
//               child: PageView.builder(
//             controller: controller,
//             itemCount: totalItems,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               if (rightPrevious != null &&
//                   rightPrevious! &&
//                   rightAnswersRow > 1) {
//                 nextQuestion = widget.questions.firstWhere(
//                     (e) => e.difficalty.name == "Medium",
//                     orElse: (() => widget.questions
//                         .firstWhere((e) => e.difficalty.name == "Easy")));
//               } else if (rightPrevious != null && !rightPrevious!) {
//                 nextQuestion = widget.questions.firstWhere(
//                     (e) => e.difficalty.name == "Easy",
//                     orElse: (() => widget.questions
//                         .firstWhere((e) => e.difficalty.name == "Medium")));
//               } else {
//                 nextQuestion = widget.questions.first;
//               }
//               if (nextQuestion.pattern == 0) {
//                 return _buildQuestionOneAnswer(
//                     nextQuestion as QuestionOneAnswer);
//               }
//               if (nextQuestion.pattern == 1) {
//                 return _buildQuestionTrueFalseAnswer(
//                     nextQuestion as QuestionTrueFalseAnswer);
//               }
//               if (nextQuestion.pattern == 2) {
//                 return _buildQuestionOneFalseAnswer(
//                     nextQuestion as QuestionOneFalseAnswer);
//               }
//               if (nextQuestion.pattern == 3) {
//                 return _buildQuestionPictureOneAnswer(
//                     nextQuestion as QuestionPictureOneAnswer);
//               }

//               return SizedBox.shrink();
//             },
//           )),
//           Padding(
//             padding: REdgeInsets.only(bottom: 44),
//             child: FFButtonWidget(
//               onPressed: () {
//                 // print(completedSections.questionOneAnswer.length);
//                 // if (_questionsNumber == 10 || totalItems == 1) {
//                 //   Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //       builder: (context) => BlocProvider(
//                 //         create: (context) => ChildLessonsBloc(
//                 //           userRepository: UserRepository(),
//                 //         ),
//                 //         child: QuizPausePage(
//                 //           state: widget.state,
//                 //           correctAnswers:
//                 //               '${completedSections.questionOneAnswer.length + completedSections.questionOneFalseAnswer.length + completedSections.questionPictureOneAnswer.length + completedSections.questionTrueFalse.length}/10',
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   );
//                 // }
//                 // setState(
//                 //   () {
//                 //     if (rightPrevious == true) {
//                 //       if (nextQuestion.pattern == 0) {
//                 //         completedSections.questionOneAnswer
//                 //             .add(nextQuestion.id);
//                 //       }
//                 //       if (nextQuestion.pattern == 1) {
//                 //         completedSections.questionOneFalseAnswer
//                 //             .add(nextQuestion.id);
//                 //       }
//                 //       if (nextQuestion.pattern == 2) {
//                 //         completedSections.questionPictureOneAnswer
//                 //             .add(nextQuestion.id);
//                 //       }
//                 //       if (nextQuestion.pattern == 3) {
//                 //         completedSections.questionTrueFalse
//                 //             .add(nextQuestion.id);
//                 //       }
//                 //       rightAnswersRow++;
//                 //     }
//                 //     if (rightPrevious == false) {
//                 //       rightAnswersRow = 0;
//                 //     }
//                 //     _questionsNumber++;
//                 //     if (widget.questions.length != 1) {
//                 //       widget.questions.remove(nextQuestion);
//                 //     }
//                 //   },
//                 // );
//               },
//               text: 'Next',
//               options: FFButtonOptions(
//                 width: 360.w,
//                 height: 60.h,
//                 color: Color(0xFF2BC0EF),
//                 textStyle: FlutterFlowTheme.of(context).subtitle2.override(
//                       fontFamily: 'Montserrat',
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                 borderSide: BorderSide(
//                   color: Colors.transparent,
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildQuestionOneAnswer(QuestionOneAnswer question) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: 140.h,
//           margin: REdgeInsets.fromLTRB(35, 50, 35, 50),
//           child: AutoSizeText(
//             question.question,
//             style: TextStyle(fontSize: 25),
//             maxLines: 4,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Expanded(
//             child: OptionsOneAnswer(
//           question: question,
//           onClickedOption: (Option option) {
//             if (question.isLocked) {
//               return;
//             } else {
//               setState(() {
//                 question.isLocked = true;
//                 question.selectedOption = option;
//               });
//             }
//           },
//         ))
//       ],
//     );
//   }

//   Widget _buildQuestionOneFalseAnswer(QuestionOneFalseAnswer question) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: 140.h,
//           margin: REdgeInsets.fromLTRB(35, 50, 35, 50),
//           child: AutoSizeText(
//             question.question,
//             style: TextStyle(fontSize: 25),
//             maxLines: 4,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Expanded(
//             child: OptionsOneFalseAnswer(
//           question: question,
//           onClickedOption: (
//             Option option,
//           ) {
//             {
//               if (question.isLocked1 && question.isLocked2) {
//                 setState(() {
//                   question.isLocked3 = true;
//                   question.selectedOptions3 = option;
//                 });
//               }
//               if (question.isLocked1 && !question.isLocked2) {
//                 setState(() {
//                   question.isLocked2 = true;
//                   question.selectedOptions2 = option;
//                 });
//               }
//               if (!question.isLocked1 &&
//                   !question.isLocked2 &&
//                   !question.isLocked3) {
//                 setState(() {
//                   question.isLocked1 = true;
//                   question.selectedOptions1 = option;
//                 });
//               }
//             }
//           },
//         ))
//       ],
//     );
//   }

//   Widget _buildQuestionTrueFalseAnswer(QuestionTrueFalseAnswer question) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: 140.h,
//           margin: REdgeInsets.fromLTRB(35, 50, 35, 50),
//           child: AutoSizeText(
//             question.question,
//             style: TextStyle(fontSize: 25),
//             maxLines: 4,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Expanded(
//             child: OptionsTrueFalseAnswer(
//           question: question,
//           onClickedOption: (Option option) {
//             if (question.isLocked) {
//               return;
//             } else {
//               setState(() {
//                 question.isLocked = true;
//                 question.selectedOption = option;
//               });
//             }
//           },
//         ))
//       ],
//     );
//   }

//   Widget _buildQuestionPictureOneAnswer(QuestionPictureOneAnswer question) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: 140.h,
//           margin: REdgeInsets.fromLTRB(35, 50, 35, 50),
//           child: AutoSizeText(
//             question.question,
//             style: TextStyle(fontSize: 25),
//             maxLines: 4,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Expanded(
//             child: OptionsFourthPattern(
//           question: question,
//           onClickedOption: (Option option) {
//             if (question.isLocked) {
//               return;
//             } else {
//               setState(() {
//                 question.isLocked = true;
//                 question.selectedOption = option;
//               });
//             }
//           },
//         ))
//       ],
//     );
//   }
// }

// class OptionsOneAnswer extends StatelessWidget {
//   final QuestionOneAnswer question;
//   final ValueChanged<Option> onClickedOption;
//   const OptionsOneAnswer({
//     Key? key,
//     required this.question,
//     required this.onClickedOption,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           question.variant1,
//           question.variant2,
//           question.variant3,
//           question.questionOneAnswerTrue,
//         ]
//             .map((option) => buildFirstOption(context,
//                 Option(text: option, correct: question.questionOneAnswerTrue)))
//             .toList(),
//       ),
//     );
//   }

//   Widget buildFirstOption(BuildContext context, Option option) {
//     final color = getFirstColorForOption(option, question);
//     return GestureDetector(
//       onTap: () => onClickedOption(option),
//       child: Container(
//         width: double.infinity,
//         padding: REdgeInsets.fromLTRB(29, 20, 0, 20),
//         margin: REdgeInsets.fromLTRB(25, 0, 25, 8),
//         decoration: BoxDecoration(
//             border: Border.all(color: color, width: 2),
//             color: Color.fromRGBO(245, 246, 250, 1),
//             borderRadius: BorderRadius.circular(20)),
//         child: Text(
//           option.text,
//           textAlign: TextAlign.start,
//           style: TextStyle(
//             fontSize: 17.sp,
//             color: Color.fromRGBO(66, 63, 63, 1),
//           ),
//         ),
//       ),
//     );
//   }

//   Color getFirstColorForOption(Option option, QuestionOneAnswer question) {
//     final isSelected = option.text == question.selectedOption?.text;
//     if (question.isLocked) {
//       if (isSelected) {
//         if (option.text == option.correct) {
//           rightPrevious = true;
//         }
//         if (option.text != option.correct) {
//           rightPrevious = false;
//         }
//         return option.text == option.correct ? Colors.green : Colors.red;
//       } else if (option.text == option.correct) {
//         return Colors.green;
//       }
//     }
//     return Colors.transparent;
//   }
// }

// class OptionsOneFalseAnswer extends StatelessWidget {
//   final QuestionOneFalseAnswer question;
//   final ValueChanged<Option> onClickedOption;
//   const OptionsOneFalseAnswer({
//     Key? key,
//     required this.question,
//     required this.onClickedOption,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           question.variant1,
//           question.variant3,
//           question.variant2,
//           question.questionOneFalseAnswerFalse,
//         ]
//             .map((option) => buildThirdOption(
//                 context,
//                 Option(
//                     text: option,
//                     correct: question.questionOneFalseAnswerFalse)))
//             .toList(),
//       ),
//     );
//   }

//   Widget buildThirdOption(BuildContext context, Option option) {
//     final color = getThirdColorForOption(option, question);
//     return GestureDetector(
//       onTap: () => onClickedOption(option),
//       child: Container(
//         width: double.infinity,
//         padding: REdgeInsets.fromLTRB(29, 20, 0, 20),
//         margin: REdgeInsets.fromLTRB(25, 0, 25, 8),
//         decoration: BoxDecoration(
//             border: Border.all(color: color, width: 2),
//             color: Color.fromRGBO(245, 246, 250, 1),
//             borderRadius: BorderRadius.circular(20)),
//         child: Text(
//           option.text,
//           textAlign: TextAlign.start,
//           style: TextStyle(
//             fontSize: 17.sp,
//             color: Color.fromRGBO(66, 63, 63, 1),
//           ),
//         ),
//       ),
//     );
//   }

//   Color getThirdColorForOption(
//     Option option,
//     QuestionOneFalseAnswer question,
//   ) {
//     if (question.isLocked3) {
//       final isSelected3 = option.text == question.selectedOptions3?.text;
//       if (isSelected3) {
//         if ((option.text != option.correct) && rightPrevious == true) {
//           rightPrevious = false;
//         }
//         if (option.text == option.correct) {
//           rightPrevious = true;
//         }

//         return question.selectedOptions3?.text == option.correct
//             ? Colors.red
//             : Colors.green;
//       } else if (option.text != option.correct) {
//         return Colors.green;
//       }
//     }
//     if (question.isLocked1) {
//       final isSelected1 = option.text == question.selectedOptions1?.text;
//       if (isSelected1) {
//         if (option.text != option.correct) {
//           rightPrevious = false;
//         }
//         return option.text == option.correct ? Colors.red : Colors.green;
//       }
//     }
//     if (question.isLocked2) {
//       final isSelected2 = option.text == question.selectedOptions2?.text;
//       if (isSelected2) {
//         if (option.text != option.correct) {
//           rightPrevious = false;
//         }
//         return question.selectedOptions2?.text == option.correct
//             ? Colors.red
//             : Colors.green;
//       }
//     }

//     return Colors.transparent;
//   }
// }

// class OptionsTrueFalseAnswer extends StatelessWidget {
//   final QuestionTrueFalseAnswer question;
//   final ValueChanged<Option> onClickedOption;
//   const OptionsTrueFalseAnswer({
//     Key? key,
//     required this.question,
//     required this.onClickedOption,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           question.questionTrueFalseAnswerFalse,
//           question.questionTrueFalseAnswerTrue,
//         ]
//             .map((option) => buildSecondOption(
//                 context,
//                 Option(
//                     text: option,
//                     correct: question.questionTrueFalseAnswerTrue)))
//             .toList(),
//       ),
//     );
//   }

//   Widget buildSecondOption(BuildContext context, Option option) {
//     final color = getSecondColorForOption(option, question);
//     return GestureDetector(
//       onTap: () => onClickedOption(option),
//       child: Container(
//         width: double.infinity,
//         padding: REdgeInsets.fromLTRB(29, 20, 0, 20),
//         margin: REdgeInsets.fromLTRB(25, 0, 25, 8),
//         decoration: BoxDecoration(
//             border: Border.all(color: color, width: 2),
//             color: Color.fromRGBO(245, 246, 250, 1),
//             borderRadius: BorderRadius.circular(20)),
//         child: Text(
//           option.text,
//           textAlign: TextAlign.start,
//           style: TextStyle(
//             fontSize: 17.sp,
//             color: Color.fromRGBO(66, 63, 63, 1),
//           ),
//         ),
//       ),
//     );
//   }

//   Color getSecondColorForOption(
//       Option option, QuestionTrueFalseAnswer question) {
//     final isSelected = option.text == question.selectedOption?.text;
//     if (question.isLocked) {
//       if (isSelected) {
//         if (option.text == option.correct) {
//           rightPrevious = true;
//         }
//         if (option.text != option.correct) {
//           rightPrevious = false;
//         }
//         return option.text == option.correct ? Colors.green : Colors.red;
//       } else if (option.text == option.correct) {
//         return Colors.green;
//       }
//     }
//     return Colors.transparent;
//   }
// }

// class OptionsFourthPattern extends StatelessWidget {
//   final QuestionPictureOneAnswer question;
//   final ValueChanged<Option> onClickedOption;
//   const OptionsFourthPattern({
//     Key? key,
//     required this.question,
//     required this.onClickedOption,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           question.variant1,
//           question.variant3,
//           question.variant2,
//           question.questionPictureOneAnswerTrue,
//         ]
//             .map((option) => buildFourthOption(
//                 context,
//                 Option(
//                     text: option,
//                     correct: question.questionPictureOneAnswerTrue)))
//             .toList(),
//       ),
//     );
//   }

//   Widget buildFourthOption(BuildContext context, Option option) {
//     final color = getFourthColorForOption(option, question);
//     return GestureDetector(
//       onTap: () => onClickedOption(option),
//       child: Container(
//         width: double.infinity,
//         padding: REdgeInsets.fromLTRB(29, 20, 0, 20),
//         margin: REdgeInsets.fromLTRB(25, 0, 25, 8),
//         decoration: BoxDecoration(
//             border: Border.all(color: color, width: 2),
//             color: Color.fromRGBO(245, 246, 250, 1),
//             borderRadius: BorderRadius.circular(20)),
//         child: Text(
//           option.text,
//           textAlign: TextAlign.start,
//           style: TextStyle(
//             fontSize: 17.sp,
//             color: Color.fromRGBO(66, 63, 63, 1),
//           ),
//         ),
//       ),
//     );
//   }

//   Color getFourthColorForOption(
//       Option option, QuestionPictureOneAnswer question) {
//     final isSelected = option.text == question.selectedOption?.text;
//     if (question.isLocked) {
//       if (isSelected) {
//         if (option.text == option.correct) {
//           rightPrevious = true;
//         }
//         if (option.text != option.correct) {
//           rightPrevious = false;
//         }
//         return option.text == option.correct ? Colors.green : Colors.red;
//       } else if (option.text == option.correct) {
//         return Colors.green;
//       }
//     }
//     return Colors.transparent;
//   }
// }

// class Option {
//   String text;
//   final String correct;
//   Option({
//     required this.text,
//     required this.correct,
//   });
// }

// class QuestionIndicator extends StatelessWidget {
//   const QuestionIndicator(
//       {Key? key, required int questionsNumber, required this.totalQuestions})
//       : _questionsNumber = questionsNumber,
//         super(key: key);

//   final int _questionsNumber;
//   final int? totalQuestions;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: REdgeInsets.symmetric(horizontal: 50),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 1.0),
//             child: LinearProgressIndicator(
//               value: _questionsNumber / totalQuestions!,
//               color: Color(0xFF2BC0EF),
//               backgroundColor: Color.fromRGBO(217, 217, 217, 1),
//               minHeight: 12,
//             ),
//           ),
//           Row(
//             children:
//                 List.generate(totalQuestions!, (index) => ProgressBarSection()),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ProgressBarSection extends StatelessWidget {
//   const ProgressBarSection({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         foregroundDecoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.white,
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: Offset(1, 0),
//                 blurStyle: BlurStyle.outer),
//             BoxShadow(
//                 color: Colors.white,
//                 spreadRadius: 0.5,
//                 blurRadius: 2,
//                 offset: Offset(-1, 0),
//                 blurStyle: BlurStyle.outer),
//           ],
//           color: Colors.transparent,
//           border: Border.all(
//               color: Colors.white, width: 4, style: BorderStyle.solid),
//         ),
//         height: 13,
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.white, width: 4),
//         ),
//       ),
//     );
//   }
// }
