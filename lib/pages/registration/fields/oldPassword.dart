import 'package:formz/formz.dart';

enum OldPasswordValidationError { invalid, empty }

class OldPassword extends FormzInput<String, OldPasswordValidationError> {
  const OldPassword.pure() : super.pure('');
  const OldPassword.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp = RegExp(r'^[A-Za-z\d@$!%*?&]{8,}$');
  @override
  OldPasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return OldPasswordValidationError.empty;
    }
    return _passwordRegExp.hasMatch(value)
        ? null
        : OldPasswordValidationError.invalid;
  }
}

extension Explanation on OldPasswordValidationError? {
  String? get title {
    switch (this) {
      case OldPasswordValidationError.invalid:
        return "Enter min 8 symbols";
      default:
        return null;
    }
  }
}
