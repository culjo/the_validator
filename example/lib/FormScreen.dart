import 'package:flutter/material.dart';
import "package:the_validator/the_validator.dart";

///
/// project: the_validator
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 2019-12-01
class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormScreenState();
  }
}

class _FormScreenState extends State<FormScreen> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _fullnameController = TextEditingController();
  var _numberController = TextEditingController();
  var _addressController = TextEditingController();
  var _usernameController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Form Validation example"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                TextFormField(
                  controller: _fullnameController,
                  validator: FieldValidator.required(message: "Your full name is required"),
                  decoration: InputDecoration(labelText: "Fullname"),
                ),

                SizedBox(height: 10,),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _numberController,
                        validator: FieldValidator.number(),
                        decoration: InputDecoration(
                            labelText: "Mobile Number",

                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 10,),

                    Expanded(
                      child: TextFormField(
                        controller: _usernameController,
                        validator: FieldValidator.alphaNumeric(),
                        decoration: InputDecoration(labelText: "Username"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),

                TextFormField(
                  controller: _emailController,
                  validator: FieldValidator.email(),
                  decoration: InputDecoration(labelText: "Email"),
                ),

                SizedBox(height: 10,),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: false,
                        validator: FieldValidator.password(
                            minLength: 6,
                            maxLength: 10,
                            shouldContainNumber: true,
                            shouldContainCapitalLetter: true,
                          shouldContainSpecialChars: true,
                        ),
                        decoration: InputDecoration(labelText: "Password"),
                      ),
                    ),

                    SizedBox(width: 10,),

                    Expanded(
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        validator: FieldValidator.equalTo(_passwordController, message: "Password Mismatch"),
                        decoration: InputDecoration(labelText: "Confirm Password"),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Yay! we got it right!")));
                      }
                    },
                    child: Text("Submit"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
