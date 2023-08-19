import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/view/screen/my_home_page.dart';
import 'package:music_app/resources/reusable_widget.dart/reusable_widget.dart';
import 'package:music_app/resources/utils/color_utils.dart';
import 'package:music_app/view/widget/loading.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
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
                  padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter UserName", Icons.person_outline,
                          false, _userNameTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Email Id", Icons.person_outline,
                          false, _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Password", Icons.lock_outlined,
                          true, _passwordTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      signInSignUpButton(context, false, () {
                        setState(() => loading = true);
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                              final snackBar = SnackBar(content: Text("Register Successfully"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          print("Created New Account");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                          setState(() {
                             final snackBar = SnackBar(content: Text("Error: ${error.toString()}"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            loading = false;
                          });
                        });
                      })
                    ],
                  ),
                ))),
          );
  }
}
