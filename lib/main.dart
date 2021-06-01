import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homePage.dart';

main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'iransans',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 25,fontWeight: FontWeight.bold) ,
          headline3: TextStyle(fontSize: 16,fontWeight: FontWeight.bold , color: Colors.grey),
          headline5: TextStyle(fontSize: 16, color: Colors.blueGrey),
            bodyText1: TextStyle(color: Colors.green),
            // bodyText2: TextStyle(color: Colors.red)
            ),
        iconTheme: IconThemeData(color: Color(0xFFF3D24F))),
  //  textDirection: TextDirection.rtl,
    home: HomePage(),
  ));
}

