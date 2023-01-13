import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/grade/grade_class.dart';
import 'package:tutor/utils/model/reward/test_results.dart';
import 'package:tutor/utils/model/section/child_section_class.dart';
import 'package:tutor/utils/model/sub_section/child_sub_section.dart';
import 'package:tutor/utils/model/subject/subject_class.dart';
import 'dart:developer';

class ChildLessonsRepository {
  final DioClient dioClient;
  ChildLessonsRepository({required this.dioClient});

  Future<List<Grade>> fetchGrades() async {
    final gradeRaw = await dioClient.getList(Api.childGradesEndpoint);
    return gradeRaw!.map((e) => Grade.fromJson(e)).toList();
  }

  Future<Subject> fetchSubjects(gradeId) async {
    final subjectsRaw = await dioClient.getAndAddItem(
        Api.childSubjectsEndpoint, 'gradeId=$gradeId');
    print(Subject.fromJson(subjectsRaw));
    return Subject.fromJson(subjectsRaw);
  }

  Future<List<ChildSection>> fetchSections(gradeId, subjectId) async {
    final sectionssRaw = await dioClient.getList(
        Api.childSectionsEndpoint + 'gradeId=$gradeId&subjectId=$subjectId');
    return sectionssRaw!.map((e) => ChildSection.fromJson(e)).toList();
  }

  Future<ChildSubSection> fetchSubSections(sectionId) async {
    final sectionssRaw = await dioClient.getAndAddItem(
        Api.childSubSectionsEndpoint, 'sectionId=$sectionId');
    return ChildSubSection.fromJson(sectionssRaw);
  }

  Future sendResults(Result result) async {
    log(result.toJson().toString());
    print(result.sectionId);
    await dioClient.postPrize(Api.childSendResultsEndpoint, result.toJson());
  }
}
