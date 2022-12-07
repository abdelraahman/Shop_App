
import 'package:first/home_screen.dart';
import 'package:first/layout/layout_screen.dart';
import 'package:first/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BMIScreen.dart';
import 'Messenger_Screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:layoutScreen(),
    );
  }

}



//container
//column
//row
//singlechildscrollview
//expanded
//safearea
//iconbutton
//image