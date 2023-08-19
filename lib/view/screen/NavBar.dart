import 'dart:io';
import 'package:flutter_share/flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:music_app/main.dart';
import 'package:music_app/model/signin_screen.dart';
import 'package:music_app/view/screen/list.dart';
import 'package:music_app/view/screen/my_home_page.dart';
import 'package:share/share.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);
  // Future<void> share(dynamic link, String title) async {
  //   await FlutterShare.share(
  //     title: 'Music Therapy',
  //     text: title,
  //     linkUrl: link,
  //     chooserTitle: 'Where You Want to share',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        UserAccountsDrawerHeader(
          accountName: Text('Music App'),
          accountEmail: Text('example@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBmNyK5FXbYrMhKrD9szqcn4naSokfa4NY2zrbg-sox8HHRMKTCJRHVVF4R63epT-A8R8&usqp=CAU",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTYQAIaz24z1xrKBUtBsX7Yyts6ZC3of6ymQ&usqp=CAU'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage())),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Favorite'),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListPage())),
        ),
        ListTile(
            leading: Icon(Icons.share),
            title: Text('Refer'),
            onTap: () {
              Share.share(
                  "https://www.youtube.com/channel/UCi5JJbGp_u9E5d0bL7BkJiQ");
            }),
        ListTile(
          leading: Icon(Icons.category),
          title: Text('Categorys'),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListPage())),
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            }),
      ]),
    );
  }
}
