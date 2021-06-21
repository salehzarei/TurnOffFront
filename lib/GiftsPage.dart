import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turnoff/UserScore.dart';

class GiftPages extends StatelessWidget {
  const GiftPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('جوایز و هدایا'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Directionality(
          child: ListView(
            children: [
              Container(
                height: Get.height * 0.10,
                child: Image.asset('assets/images/presents.png'),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'توضیحات : ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.deepOrange),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'مشترکینی که مصرف برق ماهانه آنها نسبت به سال قبل کمتر شده باشد مشمول شرکت در قرعه کشی ها خواهند شد ',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  children: [
                    Text('جهت ثبت نام یکی از گزینه های زیر را تکمیل کنید',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w700)),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('کد اشتراک قبض',
                                  style: TextStyle(fontSize: 16))),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              maxLength: 11,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 19),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.deepOrange, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  counterText: '',
                                  hintText: 'کد اشتراک قبض',
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade300)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('شناسه پرداخت',
                                  style: TextStyle(fontSize: 16))),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              maxLength: 11,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 19),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.deepOrange, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  counterText: '',
                                  hintText: 'شناسه پرداخت',
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade300)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('شماره کنتور',
                                  style: TextStyle(fontSize: 16))),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              maxLength: 11,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 19),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.deepOrange, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                  counterText: '',
                                  hintText: 'شماره کنتور',
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade300)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 13.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            alignment: Alignment.center,
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                4 == 4
                                    ? Colors.deepOrange.shade600
                                    : Colors.deepOrange.shade100),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                    side: BorderSide(
                                        color: Colors
                                            .deepOrangeAccent.shade100)))),
                        onPressed: () {},
                        child: Text(
                          "بررسی و ثبت نام",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(vertical: 3),
                color: Colors.deepOrange.shade100,
                child: Text(
                  'مشاهده لیست جوایز و هدایای صرفه جویی مصرف برق',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                //margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(15),
                color: Colors.deepOrange.shade50,
                height: Get.height * 0.17,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/gold-medal.png',
                          height: 50,
                        ),
                        Text('جوایز طلایی'),
                        Text(
                          '30% صرفه جویی به بالا',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/silver-medal.png',
                            height: 50),
                        Text('جوایز نقره ای'),
                        Text(
                          'بین 20% تا 30% صرفه جویی',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/bronze-medal.png',
                            height: 50),
                        Text('جوایز برنزی'),
                        Text(
                          'کمتر از 20% صرفه جویی',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 13),
                child: ElevatedButton(
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          4 == 4 ? Colors.blue.shade300 : Colors.blue.shade100),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                              side: BorderSide(color: Colors.blue.shade100)))),
                  onPressed: () => Get.to(UserScorePage()),
                  child: Text(
                    "مشاهده امتیازات و سوابق",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          textDirection: TextDirection.rtl,
        ));
  }
}
