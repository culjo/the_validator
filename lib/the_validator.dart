library the_validator;

//import 'package:flutter/widgets.dart' show FormFieldValidator;
import 'package:flutter/widgets.dart';

/// - Collect list of TextField controllers
/// - Specify our error label using dart streams
///
///
class ErrorLabel extends StatelessWidget {
  ValueNotifier<String> text = new ValueNotifier("");

  // final String text;
  final TextStyle style;

  ErrorLabel(this.text, {Key key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: text,
        builder: (BuildContext context, String value, Widget child) {
          return Text("");
        });
  }
}

/// A Validator.
class Validator {
  /*static bool notNull(String value) {
    return value != null;
  }*/

  static bool isRequired(String value, {bool allowEmptySpaces = true}) {
    if (value == null || value.isEmpty) {
      return false;
    } else {
      if (!allowEmptySpaces) {
        // Check if the string is not only made of empty spaces
        if (RegExp(r"\s").hasMatch(value)) {
          return false;
        }
      }
      return true; // passed
    }
  }

  static bool isEmail(String email) {
    if (!isRequired(email)) return false;

    // final emailRegex = RegExp(
    // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    // RegExp(r'(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

    final emailRegex = RegExp(
        r"^((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
    if (emailRegex.hasMatch(email))
      return true;
    else
      return false;
  }

  /// Todo: Implement reason for failure
  static bool isPassword(
    String password, {
    int minLength = 4,
    int maxLength,
    bool shouldContainNumber = false,
    bool shouldContainSpecialChars = false,
    bool shouldContainCapitalLetter = false,
    Function reason,
    void Function(bool) isNumberPresent,
    void Function(bool) isSpecialCharsPresent,
    void Function(bool) isCapitalLetterPresent,
    void Function() isMaxLengthFailed,
    void Function() isMinLengthFailed,
  }) {
    if (password == null) {
      return false;
    }
    if (password.trim().length == 0) {
      return false;
    }

    if (password.length < minLength) {
      if (isMinLengthFailed != null) isMinLengthFailed();
      return false;
    }

    if (maxLength != null) {
      if (password.length > maxLength) {
        if (isMaxLengthFailed != null) isMaxLengthFailed();
        return false;
      }
    }

    if (shouldContainNumber) {
      final numberRegex = RegExp(r"[0-9]+");
      if (!numberRegex.hasMatch(password)) {
        if (isNumberPresent != null) isNumberPresent(false);
        return false;
      } else if (isNumberPresent != null) isNumberPresent(true);
    }

    if (shouldContainCapitalLetter) {
      final capitalRegex = RegExp(r"[A-Z]+");
      if (!capitalRegex.hasMatch(password)) {
        if (isCapitalLetterPresent != null) isCapitalLetterPresent(false);
        return false;
      } else if (isCapitalLetterPresent != null) isCapitalLetterPresent(true);
    }

    if (shouldContainSpecialChars) {
//      final numberRegex = RegExp(r'(?=.*?[#?!@$%^&*-])');
      final specialRegex = RegExp(r"[\'^£$%&*()}{@#~?><>,|=_+¬-]");
      if (!specialRegex.hasMatch(password)) {
        if (isSpecialCharsPresent != null) isSpecialCharsPresent(false);
        return false;
      } else if (isSpecialCharsPresent != null) isSpecialCharsPresent(true);
    }

    return true;
  }

  static bool isEqualTo(dynamic value, dynamic valueToCompare) {
    if (value == valueToCompare)
      return true;
    else
      return false;
  }

  static isNumber(String value, {bool allowSymbols = true}) {
    if (value == null) return false;

    var numericRegEx = RegExp(r"^[+-]?([0-9]*[.])?[0-9]+$");
    var numericNoSymbolsRegExp = RegExp(r"^[0-9]+$");

    if (allowSymbols) {
      return numericRegEx.hasMatch(value);
    } else
      return numericNoSymbolsRegExp.hasMatch(value);
  }

  static bool minLength(String value, int minLength) {
    if (value.isEmpty) return false;
    if (value.length >= minLength)
      return true;
    else
      return false;
  }

  static bool maxLength(String value, int maxLength) {
    if (value.isEmpty) return false;
    if (value.length <= maxLength)
      return true;
    else
      return false;
  }

  static bool maxValue(double value, double maxValue) {
    if (value < maxValue) return true;
    return false;
  }

  static bool minValue(double value, double minValue) {
    if (value > minValue) return true;
    return false;
  }

  static bool isUppercase(String value) {
    if (value == null) return false;
    return value.compareTo(value.toUpperCase()) == 0;
  }

  static bool isLowercase(String value) {
    if (value == null) return false;
    return value.compareTo(value.toLowerCase()) == 0;
  }

  static bool isAlphaNumeric(String value) {
    if (value == null) return false;
    var alphaNumRegExp = RegExp(r"^[0-9A-Z]+$", caseSensitive: false);
    return alphaNumRegExp.hasMatch(value);
  }

  static bool isAlpha(String value) {
    if (value == null) return false;
    var alphaRegExp = RegExp(r"^[A-Z]+$", caseSensitive: false);
    return alphaRegExp.hasMatch(value);
  }

/*static bool _isUrl(String url) {
    return false;
  }

  // Todo: Add Date Validations also
  _isDate() {

  }

  _isDateGreater() {

  }*/

}

class FieldValidator {
  /// You can override the error message
  static FormFieldValidator<String> required({String message}) {
    return (fieldValue) {
      if (Validator.isRequired(fieldValue)) {
        return null;
      } else {
        return message ?? "This Field is Required";
      }
    };
  }

  static FormFieldValidator<String> email({String message}) {
    return (fieldValue) {
      if (Validator.isEmail(fieldValue)) {
        return null;
      } else {
        return message ?? "Email is not correct";
      }
    };
  }

  static FormFieldValidator<String> password({
    String errorMessage,
    int minLength = 4,
    int maxLength,
    bool shouldContainNumber = false,
    bool shouldContainSpecialChars = false,
    bool shouldContainCapitalLetter = false,
    Function reason,
    String Function() isNumberNotPresent,
    String Function() isSpecialCharsNotPresent,
    String Function() isCapitalLetterNotPresent,
  }) {
    return (fieldValue) {
      var mainError = errorMessage;

      if (Validator.isPassword(
        fieldValue,
        minLength: minLength,
        maxLength: maxLength,
        shouldContainSpecialChars: shouldContainSpecialChars,
        shouldContainCapitalLetter: shouldContainCapitalLetter,
        shouldContainNumber: shouldContainNumber,
        isNumberPresent: (present) {
          if (!present) mainError = isNumberNotPresent();
        },
        isCapitalLetterPresent: (present) {
          if (!present) mainError = isCapitalLetterNotPresent();
        },
        isSpecialCharsPresent: (present) {
          if (!present) mainError = isSpecialCharsNotPresent();
        },
      )) {
        return null;
      } else {
        return mainError ?? "Password must match the required format";
      }
    };
  }

  static FormFieldValidator<String> equalTo(dynamic value, {String message}) {
    return (fieldValue) {
      var valueToCompare;
      if (value is TextEditingController) {
        valueToCompare = value.text;
      } else {
        valueToCompare = value;
      }
      if (Validator.isEqualTo(fieldValue, valueToCompare)) {
        return null;
      } else {
        return message ?? "Values do not match";
      }
    };
  }

  static FormFieldValidator<String> number(
      {bool noSymbols = true, String message}) {
    return (fieldValue) {
      if (Validator.isNumber(fieldValue, allowSymbols: noSymbols)) {
        return null;
      } else {
        return message ?? "Field must be numbers only";
      }
    };
  }

  static FormFieldValidator<String> alphaNumeric({String message}) {
    return (fieldValue) {
      if (Validator.isAlphaNumeric(fieldValue)) {
        return null;
      } else {
        return message ?? "Field must contain both alphabets and numbers";
      }
    };
  }

  static FormFieldValidator<String> minLength(int minLength, {String message}) {
    return (fieldValue) {
      if (Validator.minLength(fieldValue, minLength)) {
        return null;
      } else {
        return message ?? "Field must be of minimum length of $minLength";
      }
    };
  }

  static FormFieldValidator<String> maxLength(int maxLength, {String message}) {
    return (fieldValue) {
      if (Validator.maxLength(fieldValue, maxLength)) {
        return null;
      } else {
        return message ?? "Field must be of maximum length of $maxLength";
      }
    };
  }

  static FormFieldValidator<String> maxValue(
      {double maxValue, String message}) {
    return (fieldValue) {
      if (fieldValue.trim().isEmpty)
        return message ?? "Field must be lesser than $maxValue";
      double dFieldValue = double.parse(fieldValue
          .replaceAll(" ", "")
          .replaceAll(",", "")
          .replaceAll(".", ""));
      if (Validator.maxValue(dFieldValue, maxValue)) {
        return null;
      } else {
        return message ?? "Field must be lesser than $maxValue";
      }
    };
  }

  static FormFieldValidator<String> minValue(
      {double minValue, String message}) {
    return (fieldValue) {
      if (fieldValue.trim().isEmpty)
        return message ?? "Field must be greater than $maxValue";
      double dFieldValue = double.parse(fieldValue
          .replaceAll(" ", "")
          .replaceAll(",", "")
          .replaceAll(".", ""));
      if (Validator.minValue(dFieldValue, minValue)) {
        return null;
      } else {
        return message ?? "Field must be greater than $maxValue";
      }
    };
  }

  static FormFieldValidator<String> regExp(RegExp pattern,
      [String errorMessage]) {
    return (value) {
      if (value.isEmpty) return null;

      if (pattern.hasMatch(value))
        return null;
      else
        return errorMessage ?? "Do not match the required pattern rules";
    };
  }

  static FormFieldValidator multiple(
      List<FormFieldValidator<String>> validators) {
    return (fieldValue) {
      for (FormFieldValidator validator in validators) {
        var outcome = validator(fieldValue);
        if (outcome != null) return outcome;
      }
      return null; // all validators were passed
    };
  }
}
