import 'package:flutter/material.dart';
import 'package:music_app/view/screen/list.dart';
import 'package:music_app/view/screen/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ListPage(),
      initialRoute: '/list',
      routes: {
        '/home':(context)=> MyHomePage(),
        '/list': (context)=> ListPage(),

      },
    );
  }
}
