import 'package:formz/formz.dart';

enum ChildImageError { empty, invalid }

class ChildImg extends FormzInput<String, ChildImageError> {
  const ChildImg.pure([String value = '']) : super.pure(value);
  const ChildImg.dirty([String value = '']) : super.dirty(value);

  @override
  ChildImageError? validator(String value) {
    if (value.isEmpty == false) {
      return ChildImageError.empty;
    }
  }
}
