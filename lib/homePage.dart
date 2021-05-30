import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'GetX/GetController.dart';
import 'settingPage.dart';
import 'widget/LocationCards.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TurnOffController c = Get.put(TurnOffController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Get.to(SettingPage()),
            icon: Icon(
              Icons.settings,
              color: Get.theme.iconTheme.color,
            )),
        actions: [
         Padding(
           padding: const EdgeInsets.only(right:8.0),
           child: Row(children: [
               Text(
              'اطلاع رسانی فعال',
              style: TextStyle(color: Colors.green , fontSize: 16),
            ),
            Icon(
              Icons.power_settings_new_outlined,
              color: Colors.green,
            ),
           ],),
         )
         
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Text(
                      'شماره موبایل شما',
                      style: Get.textTheme.headline5,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: Colors.blueGrey,
                    height: 0.5,
                  ))
                ],
              ),
              Text(
                '09154127181',
                style: Get.textTheme.headline1,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Text(
                      'تنظیمات شما',
                      style: Get.textTheme.headline5,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: Colors.blueGrey,
                    height: 0.5,
                  ))
                ],
              ),
              Container(
                height: Get.height * 0.78,
                child: ListView(
                  children: [
                    GestureDetector(
                        onTap: () => c.informationDialog(),
                        child: LocationCards()),
                    LocationCards(),
                    LocationCards(),
                    LocationCards()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
