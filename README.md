# The Validator

A simple & lightweight form and data validation package for flutter

## How to use
The Validator can be used directly on a TextFormField validator parameter 
`TextFormField(validator: FieldValidator.email())`

The Validator can also be used as a stand alone validator
`Validatror.isPassword('SecretPass', shouldContainCapitalLetter: true)`

## Sample Usage (FieldValidator)

```dart
TextFormField( 
    controller: _emailController,
    validator: FieldValidator.email(),
    decoration: InputDecoration(labelText: "Email"),
    ),
                
 TextFormField( 
    controller: _passwordController,
        validator: FieldValidator.password(
        minLength: 8,
        shouldContainNumber: true,
        shouldContainCapitalLetter: true,
        shouldContainSmallLetter: true,
        shouldContainSpecialChars: true,
        errorMessage: "Password must match the required format",
        isNumberNotPresent: () { return "Password must contain number"; },
        isSpecialCharsNotPresent: () { return "Password must contain special characters"; },
        isCapitalLetterNotPresent: () { return "Password must contain capital letters"; }
        ),
        decoration: InputDecoration(labelText: "Email"),
    ),

```

To validate confirm password field
```dart
  // To validate confirm password field
  TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      validator: FieldValidator.equalTo(_passwordController, message: "Password Mismatch"),
      decoration: InputDecoration(labelText: "Confirm Password"),
  )
```

Then make a call to formState `.validate()` to perform the validations on the textfields 
```dart

RaisedButton(
  onPressed: () {
    // validate() inputed data
    if (_formKey.currentState.validate()) {

          _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("Yay! we got it right!")));
                      
    }
  },
  child: Text("Submit"),                  
)

```

## Sample Usage 2 (Validator)
```dart
var password = 'Secret'
var confirmPassword = 'secret'
if (Validator.isPassword(password, shouldContainCapitalLetter: true)) {
  if (Validator.isEqualTo(password, confirmPassword)) {
    print("Go ahead & grant access")
  } else {
    print("Password mis match")
  }
}
```


## Error messages
By default **The Validator** will give you a nice default error based on the the type of validation you specify for field or an input. But you can also override the default message

**Default Error Messages**

`FieldValidator.alphaNumeric()` will output
**Field must contain both alphabets and numbers**

**User Defined Error Message**

`FieldValidator.alphaNumeric(message: 'Your username must contain both numbers & alphabets')`
