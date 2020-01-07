import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_validator/the_validator.dart';

void main() {
  test('Check if the string is a valid email', () {
    // final calculator = Validator();
    expect(Validator.isEmail("my.isEmail.com"), false);
    expect(Validator.isEmail("my@email.com"), true);
    expect(Validator.isEmail("my@emailcom"), true);

    /*final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
    expect(() => calculator.addOne(null), throwsNoSuchMethodError);*/
  });

  test("Check if value is required", () {
    expect(Validator.isRequired(""), false);
    expect(Validator.isRequired("  ", allowEmptySpaces: false), false); // Todo: Should we make empty string acceptable
    expect(Validator.isRequired("A Required Value"), true);
  });

  group("Password Strenght", () {

    test("Check if password is Strong enough", () {
      expect(Validator.isPassword(""), false);
      expect(Validator.isPassword("qwe"), false);
      expect(Validator.isPassword("qwerty"), true);
      expect(Validator.isPassword("qwerty", shouldContainCapitalLetter: true), false);
      expect(Validator.isPassword("Qwerty", shouldContainCapitalLetter: true), true);
      expect(Validator.isPassword("qwerty1", shouldContainNumber: true), true);
      expect(Validator.isPassword("qwerty1%", shouldContainSpecialChars: true), true);
      expect(Validator.isPassword("Qwerty1%", shouldContainSpecialChars: true, shouldContainCapitalLetter: true, shouldContainNumber: true), true);
      expect(Validator.isPassword("Qwertyuiop1%", minLength: 10, shouldContainSpecialChars: true, shouldContainCapitalLetter: true, shouldContainNumber: true), true);
      expect(Validator.isPassword("Qwerty100#", maxLength: 10, shouldContainSpecialChars: true, shouldContainCapitalLetter: true, shouldContainNumber: true), true);

    });

    test("Confirm Password", () {
      var password = "Password";
      if (Validator.isPassword(password, shouldContainCapitalLetter: true)) {
        expect(Validator.isEqualTo(password, "Password"), true);
        expect(Validator.isEqualTo(password, "WrongPassword"), false);
      } else {
        expect(false, throwsAssertionError);
      }
    });

  });


  test("Check if Numbers only", () {
    expect(Validator.isNumber("3456"), true);
    expect(Validator.isNumber("d3456"), false);
    expect(Validator.isNumber("+3456"), true);
    expect(Validator.isNumber("+3456", allowSymbols: false), false);
  });

  test("Alphanumeric Validation", () {
    expect(Validator.isAlphaNumeric("alph09a"), true);
    expect(Validator.isAlphaNumeric("alpha"), true);
  });

  test("Alpha Validation", () {
    expect(Validator.isAlpha("alphabet"), true);
    expect(Validator.isAlpha("al8phabet"), false);
    expect(Validator.isAlpha("alph0abet"), false);
  });

  test("Min Length Validation", () {
      expect(Validator.minLength("alpha", 8), false);
      expect(Validator.minLength("goodness", 4), true);
      expect(Validator.minLength("mini", 4), true);
    });

  test("Max Length Validation", () {
      expect(Validator.maxLength("alpha", 8), true);
      expect(Validator.maxLength("goodness", 4), false);
      expect(Validator.maxLength("good", 4), true);
    });


}
