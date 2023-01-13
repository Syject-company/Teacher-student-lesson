import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:tutor/pages/registration/fields/child_image.dart';
import 'package:tutor/pages/registration/fields/email.dart';
import 'package:tutor/pages/registration/fields/name.dart';
import 'package:tutor/pages/registration/fields/oldPassword.dart';
import 'package:tutor/pages/registration/fields/password.dart';
import 'package:tutor/pages/registration/fields/confirm_password.dart';
import 'package:tutor/pages/registration/fields/year_of_birth.dart';
import 'package:tutor/utils/model/image_model/image_model.dart';

class RegState extends Equatable {
  const RegState({
    this.oldPassword = const OldPassword.pure(),
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.dateOfBirth = const YearOfBirth.pure(),
    this.childImageId = const ChildImg.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage = null,
    this.photo,
    this.country = const ChildImg.pure(),
  });

  final Email email;
  final Name name;
  final YearOfBirth dateOfBirth;
  final ChildImg childImageId;
  final Password password;
  final OldPassword oldPassword;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;
  final String? errorMessage;
  final List<ImageModel>? photo;
  final ChildImg country;
  @override
  List<Object?> get props => [
        email,
        password,
        name,
        confirmPassword,
        status,
        photo,
        dateOfBirth,
        childImageId,
        country,
        oldPassword
      ];

  RegState copyWith(
      {Email? email,
      Password? password,
      OldPassword? oldPassword,
      Name? name,
      List<ImageModel>? photo,
      ConfirmPassword? confirmPassword,
      YearOfBirth? dateOfBirth,
      ChildImg? childImageId,
      ChildImg? country,
      FormzStatus? status,
      String? errorMessage}) {
    return RegState(
        email: email ?? this.email,
        childImageId: childImageId ?? this.childImageId,
        country: country ?? this.country,
        name: name ?? this.name,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        photo: photo ?? this.photo,
        password: password ?? this.password,
        oldPassword: oldPassword ?? this.oldPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        status: status ?? this.status,
        errorMessage: errorMessage);
  }
}

class FailureState extends RegState {
  final String error;

  const FailureState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' LoginFailure { error: $error }';
}
