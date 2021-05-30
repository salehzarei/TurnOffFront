import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/LocationCards.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Get.theme.iconTheme.color,
              ))
        ],
        title: Row(
          children: [
            Icon(
              Icons.power_settings_new_outlined,
              color: Colors.green,
            ),
            Text(
              'اطلاع رسانی',
              style: TextStyle(color: Colors.green),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'شماره موبایل شما',
                  style:
                      TextStyle(color: Get.theme.iconTheme.color, fontSize: 18),
                ),
                Expanded(
                    child: Container(
                  color: Get.theme.iconTheme.color,
                  height: 2,
                ))
              ],
            ),
            Text('09154127181'),
            Row(
              children: [
                Text(
                  'تنظیمات شما',
                  style:
                      TextStyle(color: Get.theme.iconTheme.color, fontSize: 18),
                ),
                Expanded(
                    child: Container(
                  color: Get.theme.iconTheme.color,
                  height: 2,
                ))
              ],
            ),
            Container(
             
              height: Get.height * 0.78,
              child: ListView(
                children: [
                  LocationCards(),
                  LocationCards(),
                  LocationCards(),
                  LocationCards()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
