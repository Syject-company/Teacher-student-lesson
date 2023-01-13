import 'package:tutor/constants/api.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/my_children/my_child_class.dart';
import 'package:tutor/utils/model/grade/grade_class.dart';
import 'package:tutor/utils/model/section/section_class.dart';
import 'package:tutor/utils/model/sub_section/sub_section.dart';
import 'package:tutor/utils/model/subject/subject_class.dart';

class LessonsRepository {
  final DioClient dioClient;
  LessonsRepository({required this.dioClient});

  Future<List<Grade>> fetchGrades() async {
    final gradeRaw = await dioClient.getList(Api.gradesEndpoint);
    return gradeRaw!.map((e) => Grade.fromJson(e)).toList();
  }

  Future<Subject> fetchSubjects(gradeId) async {
    final subjectsRaw =
        await dioClient.getAndAddItem(Api.subjectsEndpoint, 'gradeId=$gradeId');
    print(Subject.fromJson(subjectsRaw));
    return Subject.fromJson(subjectsRaw);
  }

  Future<Section> fetchSections(gradeId, subjectId) async {
    final sectionssRaw = await dioClient.getAndAddItem(
        Api.sectionsEndpoint, 'gradeId=$gradeId&subjectId=$subjectId');
    print(Section.fromJson(sectionssRaw));
    return Section.fromJson(sectionssRaw);
  }

  Future<SubSection> fetchSubSections(sectionId) async {
    final sectionssRaw = await dioClient.getAndAddItem(
        Api.subSectionsEndpoint, 'sectionId=$sectionId');
    print(SubSection.fromJson(sectionssRaw));
    return SubSection.fromJson(sectionssRaw);
  }

  Future<List<MyChild>> fetchMyChildren() async {
    final childrenRaw = await dioClient.getList(Api.getChildrenEndpoint);
    return childrenRaw!.map((e) => MyChild.fromJson(e)).toList();
  }

  asignMyChild(childId, sectionId) async {
    print(Api.assignSectionEndpoint +
        'childId=${childId}&' +
        'sectionId=${sectionId}');
    await dioClient.putUser(Api.assignSectionEndpoint +
        'childId=${childId}&' +
        'sectionId=${sectionId}');
  }
}
