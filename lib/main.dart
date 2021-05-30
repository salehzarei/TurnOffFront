import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homePage.dart';

main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'iransans',
      iconTheme: IconThemeData(color: Color(0xFFF3D24F))
    ),
    textDirection: TextDirection.rtl,
    home: HomePage(),
  ));
}
