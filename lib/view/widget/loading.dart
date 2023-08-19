import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
 class Loading extends StatelessWidget {
   const Loading({ Key? key }) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     return Container(
       color: Colors.purple,
       child: Center(child: SpinKitChasingDots(color: Colors.blue,
       size: 50,),),
     );
   }
 }