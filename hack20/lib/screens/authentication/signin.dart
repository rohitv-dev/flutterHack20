import 'package:flutter/material.dart';
import 'package:hack20/services/auth.dart';
import 'package:hack20/shared/loading.dart';
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
  String warningText = '';
  String error = '';
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: response.setHeight(270.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/background.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: response.setHeight(10)),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: response.setFontSize(39.0),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: response.setFontSize(2.0)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(response.setFontSize(28.0)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(response.setFontSize(5.0)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    response.setFontSize(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(99, 107, 255, .2),
                                      blurRadius: response.setFontSize(20.0),
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding:
                                      EdgeInsets.all(response.setFontSize(8.0)),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[300]))),
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500])),
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.all(response.setFontSize(8.0)),
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[500])),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: response.setHeight(30.0),
                          ),
                          Container(
                            height: response.setHeight(46.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    response.setFontSize(10.0)),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(99, 107, 255, 1),
                                  Color.fromRGBO(130, 136, 255, 0.9),
                                ])),
                            child: Center(
                                child: TextButton(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                email =
                                    emailController.text.replaceAll(' ', '');
                                password =
                                    passwordController.text.replaceAll(' ', '');
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    warningText =
                                        'Could not sign in with those credentials';
                                  });
                                }
                              },
                            )),
                          ),
                          SizedBox(height: response.setHeight(20.0)),
                          Container(
                              child: GestureDetector(
                            child: Text('Not yet an user? Register now!',
                                style: TextStyle(
                                    color: Color.fromRGBO(90, 100, 251, 1),
                                    fontSize: response.setFontSize(18.0),
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              widget.toggleView();
                            },
                          )),
                          SizedBox(height: response.setHeight(20.0)),
                          Container(
                              child: Text(warningText,
                                  style: TextStyle(
                                      color: Color.fromRGBO(90, 100, 251, 1),
                                      fontSize: response.setFontSize(15.0))))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
