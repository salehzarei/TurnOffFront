import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:get/get.dart';

import 'GetX/GetController.dart';
import 'settingPage.dart';
import 'widget/LocationCards.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TurnOffController c = Get.put(TurnOffController());

    return GetX<TurnOffController>(
        builder: (_) => Scaffold(
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
                  GestureDetector(
                    onTap: () => c.isSystemActive.toggle(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            c.isSystemActive.value
                                ? 'اطلاع رسانی غیرفعال'
                                : 'اطلاع رسانی فعال',
                                textAlign: TextAlign.right,
                            style: TextStyle(
                                color: c.isSystemActive.value
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 16),
                          ),
                          SizedBox(width: 3,),
                          Icon(
                            Icons.power_settings_new_outlined,
                            color: c.isSystemActive.value ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              body: c.isloadingData.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Container(
                              height: Get.height * 0.25,
                              margin: EdgeInsets.only(bottom: 15),
                              child: CarouselSlider.builder(
                                  controller: c.sliderController.value,
                                  slideIndicator: CircularSlideIndicator(
                                      padding: EdgeInsets.only(bottom: 15)),
                                  initialPage: 0,
                                  enableAutoSlider: true,
                                  unlimitedMode: true,
                                  slideBuilder: (index) {
                                    return CachedNetworkImage(
                                      imageUrl: c.sliderURls[index],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                    );
                                  },
                                  itemCount: 3),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
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
                              c.userData.value.userphone,
                              style: Get.textTheme.headline1,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
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
                            Expanded(
                              child: Container(
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ));
  }
}
