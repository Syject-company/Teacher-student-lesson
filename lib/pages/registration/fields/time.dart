import 'package:formz/formz.dart';

enum TimeError { empty, invalid }

class Time extends FormzInput<String, TimeError> {
  const Time.pure([String value = '']) : super.pure(value);
  const Time.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    dotAll: true,
    caseSensitive: false,
    unicode: true,
    r'^[0-9]+$',
  );

  @override
  TimeError? validator(String value) {
    print(value.length);
    if (value.isNotEmpty == false) {
      return TimeError.empty;
    }
    return _nameRegExp.hasMatch(value[0] + value[1] + value[3] + value[4]) &&
            (int.parse(value[0] + value[1]) < 24) &&
            (int.parse((value[3] + value[4])) < 60)
        ? null
        : TimeError.invalid;
  }
}

extension Explanation on TimeError {
  String? get title {
    switch (this) {
      case TimeError.invalid:
        return "Enter correct time value";
      default:
        return null;
    }
  }
}
