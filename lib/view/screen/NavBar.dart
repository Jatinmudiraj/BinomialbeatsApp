import 'package:flutter/material.dart';
class NavBar extends StatelessWidget {
  const NavBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(accountName: Text('Music App'), 
          accountEmail: Text('example@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBmNyK5FXbYrMhKrD9szqcn4naSokfa4NY2zrbg-sox8HHRMKTCJRHVVF4R63epT-A8R8&usqp=CAU",
            width: 90,
            height: 90,
            fit: BoxFit.cover,
            ),),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
              image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTYQAIaz24z1xrKBUtBsX7Yyts6ZC3of6ymQ&usqp=CAU'),
            fit: BoxFit.cover,
            ),
            
          ),),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite'),
            onTap: () => null,
          ),

          ListTile(
            leading: Icon(Icons.people),
            title: Text('Friends'),
            onTap: () => null,
          ),

          ListTile(
            leading: Icon(Icons.share),
            title: Text('Refer'),
            onTap: () => null,
          ),


          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categorys'),
            onTap: () => null,
          ),

          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () => null,
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () => null,
          ),

          
        ]
        ),
      
    );
  }
}