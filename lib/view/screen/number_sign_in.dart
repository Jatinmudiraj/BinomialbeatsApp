import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:music_app/resources/reusable_widget.dart/reusable_widget.dart';
import 'package:music_app/resources/utils/color_utils.dart';
import 'package:music_app/view/screen/my_home_page.dart';
import 'package:music_app/view/widget/loading.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class NumberSignIn extends StatefulWidget {
  const NumberSignIn({Key? key}) : super(key: key);

  @override
  _NumberSignInState createState() => _NumberSignInState();
}

class _NumberSignInState extends State<NumberSignIn> {
  var verId;
  var phone;
  bool codeSent = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                "SIGN IN",
                style: TextStyle(fontSize: 25),
              ),
              backgroundColor: hexStringToColor("CB2B93"),
              elevation: 0,
              foregroundColor: Colors.white,
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
              child: Column(
                children: [
                  logoWidget("assets/img/pic2.png"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Phone Authentication",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        codeSent
                            ? OTPTextField(
                                length: 6,
                                width: MediaQuery.of(context).size.width,
                                fieldWidth: 30,
                                style: TextStyle(fontSize: 20),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.underline,
                                onCompleted: (pin) {
                                  verifyPin(pin);
                                },
                              )
                            : IntlPhoneField(
                                decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    )),
                                initialCountryCode: 'IN',
                                onChanged: (phoneNumber) {
                                  setState(() {
                                    phone = phoneNumber.completeNumber;
                                  });
                                },
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            verifyPhone();
                          },
                          child: Text("Verify"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> verifyPhone() async {
    setState(() => loading = true);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ),
          );
          final snackBar = SnackBar(content: Text("Login Success"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            loading = false;

            final snackBar = SnackBar(content: Text("${e.message}"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        },
        codeSent: (verficationId, resendToken) {
          setState(() {
            loading = false;
            codeSent = true;
            verId = verficationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            loading = false;
            verId = verificationId;
          });
        },
        timeout: Duration(seconds: 60));
  }

  void verifyPin(String pin) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      final snackBar = SnackBar(content: Text("Login Success"));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text("${e.message}"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
