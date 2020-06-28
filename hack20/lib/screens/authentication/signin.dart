import 'package:flutter/material.dart';
import 'package:hack20/screens/authentication/forgotPassword.dart';
import 'package:hack20/services/auth.dart';
import 'package:hack20/shared/loading.dart';
import 'package:hack20/shared/textDecoration.dart';
import 'package:response/response.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final response = ResponseUI.instance;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 3.0,
              title: Text('Sign In'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: response.setHeight(20.0), horizontal: response.setWidth(23.0)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: response.setHeight(20.0)),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email', labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val.replaceAll(' ', ''));
                      },
                    ),
                    SizedBox(height: response.setHeight(20.0)),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password', labelText: 'Password'),
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val.replaceAll(' ', ''));
                      },
                    ),
                    SizedBox(height: response.setHeight(20.0)),
                    Container(
                      width: response.setWidth(300),
                      child: RaisedButton(
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Could not sign in with those credentials';
                                });
                              }
                            }
                          }),
                    ),
                    SizedBox(height: response.setHeight(12.0)),
                    GestureDetector(
                        child: Text('Forgot password?',
                            style: TextStyle(fontSize: response.setFontSize(15.0))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()),
                          );
                        }),
                    SizedBox(height: response.setHeight(12.0)),
                    GestureDetector(
                      child: Text('Not yet a user? Sign up!',
                            style: TextStyle(color: Colors.blue, fontSize: response.setFontSize(16.0), decoration: TextDecoration.underline)),
                      onTap: () {
                        widget.toggleView();
                      },
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: response.setFontSize(14.0)),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
