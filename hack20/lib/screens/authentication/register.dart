import 'package:flutter/material.dart';
import 'package:hack20/services/auth.dart';
import 'package:hack20/shared/loading.dart';
import 'package:hack20/shared/textDecoration.dart';
import 'package:response/response.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final response = ResponseUI.instance;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 3.0,
              title: Text('Sign Up'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: response.setHeight(20.0), horizontal: response.setWidth(23.0)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: response.setHeight(20.0)),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email', labelText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val.replaceAll(' ', ''));
                        },
                      ),
                      SizedBox(height: response.setHeight(20.0)),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password', labelText: 'Password'),
                        obscureText: true,
                        controller: _pass,
                        validator: (val) {
                          if (val.length < 6)
                            return 'Enter a password 6+ chars long';
                          if (val.contains(' '))
                            return 'Passwords cannot contain space';
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: response.setHeight(20.0)),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Confirm Password', labelText: 'Confirm Password'),
                        obscureText: true,
                        controller: _confirmPass,
                        validator: (val) {
                          if (val.length < 6)
                            return 'Enter a password 6+ chars long';
                          if (val != _pass.text) return 'Not a match';
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: response.setHeight(20.0)),
                      Row(
                        children: <Widget>[
                          RaisedButton(
                              child: Text(
                                'Register as User',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password, 'USER');
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error =
                                      'Please supply a valid email or check password';
                                    });
                                  }
                                }
                              }),
                          SizedBox(width: response.setWidth(8.0)),
                          RaisedButton(
                              color: Colors.pink[400],
                              child: Text(
                                'Register as NGO',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password, 'NGO');
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error =
                                      'Please supply a valid email or check password';
                                    });
                                  }
                                }
                              }),
                        ],
                      ),
                      SizedBox(height: response.setHeight(12.0)),
                      GestureDetector(
                          child: Text('Already have an account? Sign In!',
                              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: response.setFontSize(17))
                          ),
                        onTap: () {
                            widget.toggleView();
                        },
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: response.setFontSize(14.0)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
