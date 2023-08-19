import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/view/screen/catagorymusic.dart';
import 'package:music_app/view/screen/my_home_page.dart';
import 'package:music_app/resources/reusable_widget.dart/reusable_widget.dart';
import 'package:music_app/model/signup_screen.dart';
import 'package:music_app/resources/utils/color_utils.dart';
import 'package:music_app/view/screen/number_sign_in.dart';
import 'Package:music_app/view/widget/loading.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                hexStringToColor("CB2B93"),
                hexStringToColor("9546C4"),
                hexStringToColor("5E61F4")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                  child: Column(
                    children: <Widget>[
                      logoWidget("assets/img/pic2.png"),
                      SizedBox(
                        height: 30,
                      ),
                      reusableTextField("Enter Email", Icons.person_outline,
                          false, _emailTextController),
                      SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Password", Icons.lock_outline,
                          true, _passwordTextController),
                      SizedBox(
                        height: 20,
                      ),
                      signInSignUpButton(context, true, () {
                        setState(() => loading = true);
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                               final snackBar = SnackBar(content: Text("Login Success"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                          setState(() {
                            final snackBar = SnackBar(
                                content: Text("Error: ${error.toString()}"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            loading = false;
                          });
                        });
                      }),
                      signUpOption(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("OR"),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Row(
                          children: [
                            Icon(Icons.phone),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, top: 10.0, bottom: 10.0),
                                child: Text(
                                  "Sign in with Phone",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NumberSignIn()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
