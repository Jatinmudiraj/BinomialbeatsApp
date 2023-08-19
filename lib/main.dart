import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/signin_screen.dart';
import 'package:music_app/view/screen/list.dart';
import 'package:music_app/view/screen/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

User? firebaseUser = FirebaseAuth.instance.currentUser;
var firstWidget;



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  

  // This widget is the root of your application.
  @override
  
  Widget build(BuildContext context) {
    if (firebaseUser != null){
    firstWidget = MyHomePage();
  } else {
    firstWidget = SignInScreen();
  }
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: firstWidget,
      // initialRoute: '/home',
      routes: {
        '/home': (context) => SignInScreen(),
        '/home2': (context) => MyHomePage(),
        '/list': (context) => ListPage(),
      },
    );
  }
}
