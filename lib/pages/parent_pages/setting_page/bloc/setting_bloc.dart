import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:tutor/pages/registration/fields/name.dart';
import 'package:tutor/pages/registration/fields/year_of_birth.dart';
import 'package:tutor/services/dio_client.dart';
import 'package:tutor/utils/model/child_by_id_model/child_by_id_model.dart';
import 'package:tutor/utils/model/child_by_id_model/edit_child.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';
import 'package:tutor/utils/model/manage_child_model/manage_child_model.dart';
import 'package:tutor/utils/repository/photo_repository.dart';
import 'package:tutor/utils/repository/setting_repository.dart';
import 'package:tutor/utils/repository/user_repository.dart';
part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserRepository userRepository;

  final dio = DioClient();
  SettingBloc({
    required this.userRepository,
  })  : assert(userRepository != null),
        super(SettingState());

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is LoadSettingChildren) {
      final listOfChildren =
          await SettingRepository(dioClient: dio).fetchManageChildren();
      yield state.copyWith(listOfChildren: listOfChildren);
    }
    if (event is LoadChildById) {
      final childData =
          await SettingRepository(dioClient: dio).getChildById(event.childId);
      yield state.copyWith(childById: childData);
    } else if (event is LoadSettingPhoto) {
      final listOfPhoto =
          await PhotoRepository(dioClient: DioClient()).fetchChildsPhoto();
      yield state.copyWith(photo: listOfPhoto, status: FormzStatus.valid);
    } else if (event is EditNameChanged) {
      print(event.name);
      final name = Name.dirty(event.name);

      yield state.copyWith(
        name: name,
        status: Formz.validate([name]),
      );
      print(Formz.validate([
        name,
      ]));
    } else if (event is EditDOBChanged) {
      print(event.dateOfBirth);

      final dateOfBirth = YearOfBirth.pure(event.dateOfBirth);

      yield state.copyWith(
        dateOfBirth: dateOfBirth,
        status: Formz.validate([
          dateOfBirth,
        ]),
      );
    } else if (event is EditAvatarSelected) {
      yield state.copyWith(
        childImageId: event.childImageId,
      );
    } else if (event is EditChildEvent) {
      await SettingRepository(dioClient: dio).editChild(event.childData);
    } else if (event is DeleteChildEvent) {
      await SettingRepository(dioClient: dio).deleteChild(event.childId);
    }
  }
}
