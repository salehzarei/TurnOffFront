import 'package:flutter/services.dart';
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
          c.loadUSerSetting();
        },
        builder: (x) => Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.deepOrange,
                  elevation: 0.0,
                  //  iconTheme: IconThemeData(color: Colors.blueGrey),
                  actions: [
                    //  Text(
                    //         // c.isSystemActive.value
                    //         c.userData.value.status == '1'
                    //             ? 'اطلاع رسانی فعال'
                    //             : 'اطلاع رسانی غیرفعال',
                    //         textAlign: TextAlign.right,
                    //         style: TextStyle(
                    //             color: c.userData.value.status == '1'
                    //                 ? Colors.green
                    //                 : Colors.red,
                    //             fontSize: 16),
                    //       ),
                    TextButton(
                        onPressed: () => x.updateUserSetting().whenComplete(
                            () => !x.isloadingData.value
                                ? Get.snackbar("اعلان", "",
                                    backgroundColor:
                                        Colors.green.withOpacity(0.7),
                                    titleText: Icon(
                                      Icons.add_reaction,
                                      color: Colors.white,
                                    ),
                                    messageText: Text(
                                      "تنظیمات شما با موفقیت ذخیره شد",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM)
                                : null),
                        child: Text(
                          "ذخیره تنظیمات",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ))
                  ],
                  centerTitle: true,
                  title: Text('تنظیمات من',
                      style: TextStyle(color: Colors.white))),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          x.userData.value.userphone,
                          style: Get.textTheme.headline1!
                              .copyWith(color: Colors.deepOrange),
                        ),
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
                          flex: x.userData.value.addresses.length < 2
                              ? 1
                              : x.userData.value.addresses.length - 1,
                          child: Container(
                              height: 200,
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
                                      index: index,
                                    );
                                  }))),
                      Visibility(
                          visible: x.userData.value.addresses.length < 4,
                          child: TextButton(
                              onPressed: () async {
                                if (x.isGPSEnable.value &&
                                    !x.isGPSDenied.value) {
                                  await x.getNeshani(LatLng(
                                      x.userPosition.value.latitude,
                                      x.userPosition.value.longitude));
                                  x.userPosition.value.latitude != 0.0
                                      ? Get.defaultDialog(
                                          title: 'آدرس کنونی موقعیت شما',
                                          content: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                  '${x.neshani.value.state},${x.neshani.value.city}\n${x.neshani.value.addresses[0].formatted}',
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      TextDirection.rtl)),
                                          confirm: TextButton(
                                              onPressed: () {
                                                Get.back();
                                                Get.to(TurnOffMap());
                                              },
                                              child:
                                                  Text('انتخاب از روی نقشه')),
                                          cancel: TextButton(
                                              onPressed: () {
                                                x.addNewAddress();
                                                Get.back();
                                              },
                                              child: Text('تایید میکنم')))
                                      : Future.error(
                                          'خطا در دریافت نشانی از سرور نشان');
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
                              child: x.isloadingData.value
                                  ? CircularProgressIndicator()
                                  : Text(" + اضافه کردن آدرس جدید"))),
                      Expanded(
                          flex: x.userData.value.addresses.length > 3
                              ? 3
                              : x.userData.value.addresses.length < 2
                                  ? 6
                                  : x.userData.value.addresses.length,
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
                                          style: Get.textTheme.headline5!
                                              .copyWith(
                                                  color: Colors.deepOrange),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        color: Colors.deepOrange.shade200,
                                        height: 0.5,
                                      )),
                                      Icon(
                                        Icons.notifications_on_outlined,
                                        color: Colors.deepOrange.shade300,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                    child: Text(
                                        'از چه طریق به شما اطلاع رسانی انجام شود ؟',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: x.isReciveMesseage.value,
                                          onChanged: (v) {
                                            x.isReciveMesseage(v);
                                            x.userData.update((userData) {
                                              if (v == true)
                                                userData!.notetype.add("sms");
                                              else
                                                userData!.notetype
                                                    .remove("sms");
                                            });
                                          }),
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
                                        'چند دقیقه قبل قطعی اطلاع رسانی به شما انجام شود؟',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: 15,
                                          groupValue: x.reminderTime.value,
                                          onChanged: (v) {
                                            x.changeRemiderTime(15);
                                            x.userData.update((userData) {
                                              userData!.remindtime = 15;
                                            });
                                          }),
                                      Text(
                                        '15',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Radio(
                                          value: 30,
                                          groupValue: x.reminderTime.value,
                                          onChanged: (v) {
                                            x.changeRemiderTime(30);
                                            x.userData.update((userData) {
                                              userData!.remindtime = 30;
                                            });
                                          }),
                                      Text('30',
                                          style: TextStyle(fontSize: 20)),
                                      Radio(
                                          value: 60,
                                          groupValue: x.reminderTime.value,
                                          onChanged: (v) {
                                            x.changeRemiderTime(60);
                                            x.userData.update((userData) {
                                              userData!.remindtime = 60;
                                            });
                                          }),
                                      Text('60',
                                          style: TextStyle(fontSize: 20)),
                                      Radio(
                                          value: 120,
                                          groupValue: x.reminderTime.value,
                                          onChanged: (v) {
                                            x.changeRemiderTime(120);
                                            x.userData.update((userData) {
                                              userData!.remindtime = 120;
                                            });
                                          }),
                                      Text('120',
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                    child: Text(
                                        'مایل به دریافت اطلاع رسانی کدام شرکت هستید؟',
                                        style: TextStyle(
                                            fontSize: 16,
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
                                  TextButton(
                                      onPressed: () {
                                        x.setTokeninPhone("").whenComplete(
                                            () => SystemNavigator.pop());
                                      },
                                      child: Text(
                                        "خروج از برنامه",
                                        style:
                                            TextStyle(color: Colors.deepOrange),
                                      ))
                                ],
                              )))
                    ],
                  ),
                ),
              ),
            ));
  }
}
