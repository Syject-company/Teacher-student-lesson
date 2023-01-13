import 'package:formz/formz.dart';

enum YearOfBirthError { empty, invalid }

class YearOfBirth extends FormzInput<String, YearOfBirthError> {
  const YearOfBirth.pure([String? value]) : super.pure(value ?? '');
  const YearOfBirth.dirty([String? value]) : super.dirty(value ?? '');

  @override
  YearOfBirthError? validator(String value) {
    print('3$value');
    if (value.isEmpty == false) {
      return YearOfBirthError.empty;
    }
    // return YearOfBirthError.invalid;
  }
}
