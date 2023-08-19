import 'package:flutter/material.dart';

class MyBarData extends StatelessWidget {
  const MyBarData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: 
      // Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // children: [
          // const ImageIcon(
          //   AssetImage("assets/img/menu.png"),
          //   size: 35,
          //   color: Colors.black,
          // ),
          // Row(
          //   // ignore: prefer_const_literals_to_create_immutables
          //   children: [
          //     const Text(
          //       "Sound Theropy",
          //       style: TextStyle(
          //           fontSize: 30,
          //           color: Colors.red,
          //           fontWeight: FontWeight.w800),
          //     ),
            // ],
          // ),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            // children: [
            //   IconButton(
            //       onPressed: () {
            //         Navigator.pushNamed(context, '/list');
            //       },
            //       icon: Icon(Icons.category))
            // ],
          ),
        // ],
      // ),
    );
  }
}
