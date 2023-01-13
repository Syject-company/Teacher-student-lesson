import 'package:formz/formz.dart';

enum CodeError { empty, invalid }

class Code extends FormzInput<String, CodeError> {
  const Code.pure([String value = '']) : super.pure(value);
  const Code.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    dotAll: true,
    caseSensitive: false,
    unicode: true,
    r'^[0-9]+$',
  );

  @override
  CodeError? validator(String value) {
    print(value.length);
    if (value.isNotEmpty == false) {
      return CodeError.empty;
    }
    return _nameRegExp.hasMatch(value) && value.length == 4
        ? null
        : CodeError.invalid;
  }
}

extension Explanation on CodeError {
  String? get title {
    switch (this) {
      case CodeError.invalid:
        return "Enter correct code, 4 digit";
      default:
        return null;
    }
  }
}
