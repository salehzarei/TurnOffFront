import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turnoff/GetX/GetController.dart';
import 'package:turnoff/HomePage.dart';

import 'RegisterPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final x = Get.put(TurnOffController());
    return GetBuilder<TurnOffController>(
        init: TurnOffController(),
        initState: (_) {
          Future.delayed(Duration(seconds: 3), () {
            print("بررسی اینکه توکن هست یا نیست بالاخره");
            if (x.userToken.value == "")
              Get.off(RegisterPage());
            else
              Get.off(HomePage());
          });
        },
        builder: (_) => Material(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/bargh.png'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'درحال دریافت اطلاعات',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  LinearProgressIndicator(),
                ],
              ),
            )));
  }
}
