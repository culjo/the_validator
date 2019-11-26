library the_validator;

//import 'package:flutter/widgets.dart' show FormFieldValidator;
import 'package:flutter/widgets.dart';

/**
 * Todo:
 * - Collect list of TextField controllers
 * - Use
 * - Specify our error label using dart streams
 */

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
  static bool required({String value}) {
    if (value == null || value.isEmpty) {
      return false;
    } else {
      return true; // passed
    }
  }

  static bool email(String email) {
    if (!required(value: email)) return false;

    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (emailRegex.hasMatch(email))
      return true;
    else
      return false;
  }

  /// Todo: Implement reason for failure
  static bool password(String password,
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

    if (shouldContainNumber) {
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

  static bool equalTo(dynamic value, dynamic valueToCompare) {
    if (value == valueToCompare) return true;
    else return false;
  }

  static isNumber(String value) {}

}

class FieldValidators {
  /// You can override the error message
  static FormFieldValidator<String> required([String errorMessage]) {
    return (fieldValue) {
      if (Validator.required(value: fieldValue)) {
        return null;
      } else {
        return errorMessage ?? "This Field is Required";
      }
    };
  }

  static FormFieldValidator<String> email([String errorMessage]) {
    return (fieldValue) {
      if (Validator.email(fieldValue)) {
        return null;
      } else {
        return errorMessage ?? "Email is not correct";
      }
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
