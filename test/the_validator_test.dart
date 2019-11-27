import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:the_validator/the_validator.dart';

void main() {
  test('Check if the string is a valid email', () {
    // final calculator = Validator();
    expect(Validator.email("myemail.com"), false);
    expect(Validator.email("my@email.com"), true);
    expect(Validator.email("my@emailcom"), true); // Todo: this should fail (Please fix)

    /*final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
    expect(() => calculator.addOne(null), throwsNoSuchMethodError);*/
  });

  test("Check if value is required", () {
    expect(Validator.required(value: ""), false);
    expect(Validator.required(value: "  ", allowEmptySpaces: false), false); // Todo: Should we make empty string acceptable
    expect(Validator.required(value: "A Required Value"), true);
  });

  group("Password Strenght", () {

    test("Check if password is Strong enough", () {
      expect(Validator.password(""), false);
      expect(Validator.password("qwe"), false);
      expect(Validator.password("qwerty"), true);
      expect(Validator.password("qwerty", shouldContainCapitalLetter: true), false);
      expect(Validator.password("Qwerty", shouldContainCapitalLetter: true), true);
      expect(Validator.password("qwerty1", shouldContainNumber: true), true);
      expect(Validator.password("qwerty1%", shouldContainSpecialChars: true), true);
      expect(Validator.password("Qwerty1%", shouldContainSpecialChars: true, shouldContainCapitalLetter: true, shouldContainNumber: true), true);
      expect(Validator.password("Qwertyuiop1%", minLength: 10, shouldContainSpecialChars: true, shouldContainCapitalLetter: true, shouldContainNumber: true), true);
      expect(Validator.password("Qwerty100#", maxLength: 10, shouldContainSpecialChars: true, shouldContainCapitalLetter: true, shouldContainNumber: true), true);

    });

    test("Confirm Password", () {
      var password = "Password";
      if (Validator.password(password, shouldContainCapitalLetter: true)) {
        expect(Validator.equalTo(password, "Password"), true);
        expect(Validator.equalTo(password, "WrongPassword"), false);
      } else {
        expect(false, throwsAssertionError);
      }
    });

  });




}
