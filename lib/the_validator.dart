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

  static bool isRequired({String value, bool allowEmptySpaces = true}) {
    if (value == null || value.isEmpty) {
      return false;
    } else {
      if (!allowEmptySpaces) { // Check if the string is not only made of empty spaces
         if (RegExp(r"\s").hasMatch(value)) {
           return false;
         }
      }
      return true; // passed
    }
  }

  static bool isEmail(String email) {
    if (!isRequired(value: email)) return false;

    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (emailRegex.hasMatch(email))
      return true;
    else
      return false;
  }

  /// Todo: Implement reason for failure
  static bool isPassword(String password,
      {int minLength = 4,
      int maxLength,
      bool shouldContainNumber = false,
      bool shouldContainSpecialChars = false,
      bool shouldContainCapitalLetter = false,
        Function reason,
      }) {

    if (password.length < minLength) return false;

    if (maxLength != null) {
      if (password.length > maxLength) return false;
    }

    if (shouldContainNumber) {
      final numberRegex = RegExp(r"[0-9]+");
      if (!numberRegex.hasMatch(password)) return false;
    }

    if (shouldContainCapitalLetter) {
      final capitalRegex = RegExp(r"[A-Z]+");
      if (!capitalRegex.hasMatch(password)) return false;
    }

    if (shouldContainSpecialChars) {
//      final numberRegex = RegExp(r'(?=.*?[#?!@$%^&*-])');
      final specialRegex = RegExp(r"[\'^£$%&*()}{@#~?><>,|=_+¬-]");
      if (!specialRegex.hasMatch(password)) return false;
    }

    return true;

  }

  static bool isEqualTo(dynamic value, dynamic valueToCompare) {
    if (value == valueToCompare) return true;
    else return false;
  }


  static isNumber(String value, {bool noSymbols = true}) {
    if (value == null) return false;

    var numericRegEx = RegExp(r"^[+-]?([0-9]*[.])?[0-9]+$");
    var numericNoSymbolsRegExp = RegExp(r"^[0-9]+$");

    if (noSymbols) {
      return numericNoSymbolsRegExp.hasMatch(value);
    } else return numericRegEx.hasMatch(value);

  }

  static bool minLength(String value, int minLength) {
    if (value.isEmpty) return false;
    if (value.length < minLength) return true;
    else return false;
  }

  static bool maxLength(String value, int maxLength) {
    if (value.isEmpty) return false;
    if (value.length > maxLength) return true;
    else return false;
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
    var alphaNumRegExp = RegExp(r"[0-9A-Z]+$");
    return alphaNumRegExp.hasMatch(value);
  }


  // Todo:
  static bool _isUrl(String url) {
    return false;
  }

  // Todo: Add Date Validations also
  _isDate() {

  }

  _isDateGreater() {

  }


}

class FieldValidator {
  /// You can override the error message
  static FormFieldValidator<String> required({String message}) {
    return (fieldValue) {
      if (Validator.isRequired(value: fieldValue)) {
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


  static FormFieldValidator<String> password({String errorMessage, int minLength = 4,
    int maxLength,
    bool shouldContainNumber = false,
    bool shouldContainSpecialChars = false,
    bool shouldContainCapitalLetter = false,
    Function reason,
  }) {
    return (fieldValue) {
      if (Validator.isPassword(fieldValue)) {
        return null;
      } else {
        return errorMessage ?? "Email is not correct";
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
      if (Validator.isEqualTo(fieldValue, "")) {
        return null;
      } else {
        return message ?? "Email is not correct";
      }
    };
  }


  static FormFieldValidator<String> number({bool noSymbols = true, String message}) {
    return (fieldValue) {
      if (Validator.isNumber(fieldValue, noSymbols: noSymbols)) {
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

  static FormFieldValidator<String> maxValue({double maxValue, String message}) {
    return (fieldValue) {
      if (fieldValue.trim().isEmpty) return message ?? "Field must be lesser than $maxValue";
      double dFieldValue = double.parse(fieldValue.replaceAll(" ", "").replaceAll(",", "").replaceAll(".", ""));
      if (Validator.maxValue(dFieldValue, maxValue)) {
        return null;
      } else {
        return message ?? "Field must be lesser than $maxValue";
      }
    };
  }

  static FormFieldValidator<String> minValue({double minValue, String message}) {
    return (fieldValue) {
      if (fieldValue.trim().isEmpty) return message ?? "Field must be greater than $maxValue";
      double dFieldValue = double.parse(fieldValue.replaceAll(" ", "").replaceAll(",", "").replaceAll(".", ""));
      if (Validator.minValue(dFieldValue, minValue)) {
        return null;
      } else {
        return message ?? "Field must be greater than $maxValue";
      }
    };
  }


  static FormFieldValidator<String> regExp(
      RegExp pattern, [String errorMessage]) {
    return (value) {
      if (value.isEmpty) return null;

      if (pattern.hasMatch(value))
        return null;
      else
        return errorMessage ?? "Do not match the required pattern rules";
    };
  }


  static FormFieldValidator multiple (List<FormFieldValidator<String>> validators) {
    return (fieldValue) {
      for (FormFieldValidator validator in validators) {
        var outcome = validator(fieldValue);
        if (outcome != null) return outcome;
      }
      return null; // all validators were passed
    };
  }


}
