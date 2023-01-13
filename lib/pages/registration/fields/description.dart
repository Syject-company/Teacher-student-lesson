import 'package:formz/formz.dart';

enum DescriptionError { empty, invalid }

class Description extends FormzInput<String, DescriptionError> {
  const Description.pure([String value = '']) : super.pure(value);
  const Description.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    r'^(?=.*[a-z])[A-Za-z ]{2,}$',
  );

  @override
  DescriptionError? validator(String value) {
    if (value.isNotEmpty == false) {
      return DescriptionError.empty;
    }
    return _nameRegExp.hasMatch(value) ? null : DescriptionError.invalid;
  }
}

extension Explanation on DescriptionError {
  String? get title {
    switch (this) {
      case DescriptionError.invalid:
        return "Maximum number of characters 50";
      default:
        return null;
    }
  }
}
