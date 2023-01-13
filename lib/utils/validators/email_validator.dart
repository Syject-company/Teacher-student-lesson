class Validator {
  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value != null) {
      if (value.length > 5) {
        return null;
      }
      return 'Enter min 6 symbols';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value != null) {
      if (value.length == 1) {
        return 'Enter min 2 symbols';
      } else if (value.length < 11) {
        return null;
      }
      return 'Enter max 12 symbols';
    }
    return null;
  }

  String? validateTime(String? value) {
    if (value != null) {
      if (int.parse(value[0] + value[1]) > 24) {
        return 'Enter min 2 symbols';
      } else if (int.parse((value[3] + value[4])) > 60) {
        return null;
      }
      return 'Enter max 12 symbols';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value != null) {
      if (value.length == 1) {
        return 'Enter min 2 symbols';
      } else if (value.length < 49) {
        return null;
      }
      return 'Enter max 50 symbols';
    }
    return null;
  }
}
