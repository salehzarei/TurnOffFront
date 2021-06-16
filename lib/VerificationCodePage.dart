import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turnoff/homePage.dart';

import 'GetX/GetController.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _focus0 = FocusNode();
    final _focus1 = FocusNode();
    final _focus2 = FocusNode();
    final _focus3 = FocusNode();
    TextEditingController _n01 = TextEditingController();
    TextEditingController _n02 = TextEditingController();
    TextEditingController _n03 = TextEditingController();
    TextEditingController _n04 = TextEditingController();

    final x = Get.put(TurnOffController());
    return GetX<TurnOffController>(
        builder: (_) => Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "لطفا کد چهاررقمی پیامک شده را وارد کنید",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              controller: _n01,
                              maxLength: 1,
                              autofocus: true,
                              focusNode: _focus0,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (v) {
                                if (v.isNotEmpty)
                                  FocusScope.of(context).requestFocus(_focus1);
                              },
                              style: TextStyle(fontSize: 30),
                              decoration: InputDecoration(
                                counterText: '',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              controller: _n02,
                              maxLength: 1,
                              focusNode: _focus1,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (v) {
                                if (v.isNotEmpty)
                                  FocusScope.of(context).requestFocus(_focus2);
                                if (v.isEmpty)
                                  FocusScope.of(context).requestFocus(_focus0);
                              },
                              style: TextStyle(fontSize: 30),
                              decoration: InputDecoration(
                                counterText: '',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              controller: _n03,
                              maxLength: 1,
                              focusNode: _focus2,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (v) {
                                if (v.isNotEmpty)
                                  FocusScope.of(context).requestFocus(_focus3);
                                if (v.isEmpty)
                                  FocusScope.of(context).requestFocus(_focus1);
                              },
                              style: TextStyle(fontSize: 30),
                              decoration: InputDecoration(
                                counterText: '',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              controller: _n04,
                              maxLength: 1,
                              focusNode: _focus3,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (v) {
                                if (v.isNotEmpty)
                                  x.userVerificationCode(_n01.text +
                                      _n02.text +
                                      _n03.text +
                                      _n04.text);

                                if (v.isEmpty) {
                                  FocusScope.of(context).requestFocus(_focus2);
                                  x.userVerificationCode(
                                      _n01.text + _n02.text + _n03.text);
                                }
                              },
                              style: TextStyle(fontSize: 30),
                              decoration: InputDecoration(
                                counterText: '',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all<Color>(
                                x.userVerificationCode.value.length == 4
                                    ? Colors.yellow.shade600
                                    : Colors.yellow.shade100),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                    side: BorderSide(color: Colors.yellow)))),
                        onPressed: () {
                          if (x.userVerificationCode.value.length == 4)
                            x
                                .checkVerificationCode()
                                .then((value) => print("خطا در کد احراز هویت"));
                        },
                        child: Text(
                          "ثبت و تایید",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
