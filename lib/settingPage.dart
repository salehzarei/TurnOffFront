import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:turnoff/widget/AddressCard.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text('تنظیمات من', style: TextStyle(color: Colors.blueGrey))),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '09154127181',
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      // color: Colors.amber,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          AddressCard(),
                          AddressCard(),
                          AddressCard(),
                          TextButton(
                              onPressed: () {},
                              child: Text("افزودن آدرس جدید",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 20)))
                        ],
                      ))),
              Expanded(
                  flex: 3,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      // color: Colors.red,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
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
                                    fontSize: 19, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (v) {}),
                              Text('دریافت پیامک'),
                              SizedBox(
                                width: 20,
                              ),
                              Checkbox(value: true, onChanged: (v) {}),
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
                                    fontSize: 19, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: true,
                                  groupValue: "groupValue",
                                  onChanged: (v) {}),
                              Text(
                                '15',
                                style: TextStyle(fontSize: 20),
                              ),
                              Radio(
                                  value: true,
                                  groupValue: "groupValue",
                                  onChanged: (v) {}),
                              Text('30', style: TextStyle(fontSize: 20)),
                              Radio(
                                  value: true,
                                  groupValue: "groupValue",
                                  onChanged: (v) {}),
                              Text('60', style: TextStyle(fontSize: 20)),
                              Radio(
                                  value: true,
                                  groupValue: "groupValue",
                                  onChanged: (v) {}),
                              Text('120', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Text(
                                'مایل به دریافت اطلاع رسانی کدام هستید؟',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Text("برق")
                                ],
                              ),
                              Spacer(),
                              Checkbox(value: false, onChanged: (v) {}),
                              Column(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 15,
                                      backgroundImage:
                                          AssetImage('assets/images/ab.png')),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("آب")
                                ],
                              ),
                              Spacer(),
                              Checkbox(value: false, onChanged: (v) {}),
                              Column(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 15,
                                      backgroundImage:
                                          AssetImage('assets/images/gaz.png')),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("گاز")
                                ],
                              ),
                              Spacer(),
                              Checkbox(value: false, onChanged: (v) {}),
                              Column(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 15,
                                      backgroundImage: AssetImage(
                                          'assets/images/mokhaberat.png')),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("تلفن")
                                ],
                              ),
                            ],
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
