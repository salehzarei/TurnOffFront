import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:turnoff/GetX/GetController.dart';
import 'package:turnoff/widget/AddressCard.dart';
import 'package:universe/universe.dart';

import 'widget/Map.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TurnOffController c = Get.put(TurnOffController());
    return GetX<TurnOffController>(
        initState: (_) {
          c.determinePosition();
        },
        builder: (x) => Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.blueGrey),
                  actions: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "ذخیره تنظیمات",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                  centerTitle: true,
                  title: Text('تنظیمات من',
                      style: TextStyle(color: Colors.blueGrey))),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        x.userData.value.userphone,
                        style: Get.textTheme.headline1,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Text(
                              'آدرس های من',
                              style: Get.textTheme.headline5,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            color: Colors.blueGrey,
                            height: 0.5,
                          )),
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.blueGrey,
                          )
                        ],
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              // color: Colors.amber,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: x.userData.value.addresses.length,
                                  itemBuilder: (context, index) {
                                    return AddressCard(
                                      userAddress:
                                          x.userData.value.addresses[index],
                                    );
                                  }))),
                      Visibility(
                          visible: x.userData.value.addresses.length < 4,
                          child: TextButton(
                              onPressed: () async {
                                //x.determinePosition();
                                // await Future.delayed(
                                //     Duration(milliseconds: 300));
                                if (x.isGPSEnable.value &&
                                    !x.isGPSDenied.value) {
                                  x.userPosition.value.latitude != 0.0
                                      ? await x.getNeshani(LatLng(
                                          x.userPosition.value.latitude,
                                          x.userPosition.value.longitude))
                                      : Future.error(
                                          'خطا در دریافت نشانی از سرور نشان');
                                  Get.defaultDialog(
                                      title: 'آدرس کنونی موقعیت شما',
                                      content: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                            '${x.neshani.value.state},${x.neshani.value.city}\n${x.neshani.value.addresses[0].formatted}',
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl),
                                      ),
                                      confirm: TextButton(
                                          onPressed: () => Get.to(TurnOffMap()),
                                          child: Text('انتخاب از روی نقشه')),
                                      cancel: TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text('تایید میکنم')));
                                } else
                                  Get.defaultDialog(
                                      title: '!مشکل ریزی پیش آمده',
                                      titleStyle: TextStyle(color: Colors.red),
                                      content: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "دسترسی به موقعیت یاب گوشی شما فعال نیست یا به این برنامه مجوز استفاده ندادید، برای ثبت آدرس نیاز به فعال سازی آن دارید",
                                          textAlign: TextAlign.justify,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                      cancel: TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text('بستن')));
                              },
                              child: Text(" + اضافه کردن آدرس جدید"))),
                      Expanded(
                          flex: 3,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              // color: Colors.red,
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        child: Text(
                                          'تنظیم اعلان ها',
                                          style: Get.textTheme.headline5,
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        color: Colors.blueGrey,
                                        height: 0.5,
                                      )),
                                      Icon(
                                        Icons.notifications_on_outlined,
                                        color: Colors.blueGrey,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                    child: Text(
                                        'از چه طریق به شما اطلاع رسانی انجام شود ؟',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: x.isReciveMesseage.value,
                                          onChanged: (v) =>
                                              x.isReciveMesseage(v)),
                                      Text('دریافت پیامک'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Checkbox(
                                          value: x.isReciveNotification.value,
                                          onChanged: (v) =>
                                              x.isReciveNotification(v)),
                                      Text('نوتیفیکشن ( رایگان )')
                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                    child: Text(
                                        'چند دقیقه قبل قطعی اطلاع رسانی انجام شود؟',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: 15,
                                          groupValue: x.reminderTime.value,
                                          onChanged: (v) =>
                                              x.changeRemiderTime(15)),
                                      Text(
                                        '15',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Radio(
                                          value: 30,
                                          groupValue: x.reminderTime.value,
                                          onChanged: (v) =>
                                              x.changeRemiderTime(30)),
                                      Text('30',
                                          style: TextStyle(fontSize: 20)),
                                      Radio(
                                          value: 60,
                                          groupValue: x.reminderTime.value,
                                          onChanged: (v) =>
                                              x.changeRemiderTime(60)),
                                      Text('60',
                                          style: TextStyle(fontSize: 20)),
                                      Radio(
                                          value: 120,
                                          groupValue: x.reminderTime.value,
                                          onChanged: (v) =>
                                              x.changeRemiderTime(120)),
                                      Text('120',
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                    child: Text(
                                        'مایل به دریافت اطلاع رسانی کدام هستید؟',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Checkbox(value: true, onChanged: (v) {}),
                                      Column(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 15,
                                              backgroundImage: AssetImage(
                                                  'assets/images/bargh.png')),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("شرکت برق")
                                        ],
                                      ),
                                      Spacer(),
                                      // Checkbox(value: false, onChanged: (v) {}),
                                      // Column(
                                      //   children: [
                                      //     CircleAvatar(
                                      //         backgroundColor: Colors.white,
                                      //         radius: 15,
                                      //         backgroundImage:
                                      //             AssetImage('assets/images/ab.png')),
                                      //     SizedBox(
                                      //       height: 5,
                                      //     ),
                                      //     Text("آب")
                                      //   ],
                                      // ),
                                      // Spacer(),
                                      // Checkbox(value: false, onChanged: (v) {}),
                                      // Column(
                                      //   children: [
                                      //     CircleAvatar(
                                      //         backgroundColor: Colors.white,
                                      //         radius: 15,
                                      //         backgroundImage:
                                      //             AssetImage('assets/images/gaz.png')),
                                      //     SizedBox(
                                      //       height: 5,
                                      //     ),
                                      //     Text("گاز")
                                      //   ],
                                      // ),
                                      // Spacer(),
                                      // Checkbox(value: false, onChanged: (v) {}),
                                      // Column(
                                      //   children: [
                                      //     CircleAvatar(
                                      //         backgroundColor: Colors.white,
                                      //         radius: 15,
                                      //         backgroundImage: AssetImage(
                                      //             'assets/images/mokhaberat.png')),
                                      //     SizedBox(
                                      //       height: 5,
                                      //     ),
                                      //     Text("تلفن")
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ],
                              )))
                    ],
                  ),
                ),
              ),
            ));
  }
}
