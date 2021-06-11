import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turnoff/GetX/GetController.dart';
import 'package:turnoff/VerificationCodePage.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final x = Get.put(TurnOffController());
    return GetX<TurnOffController>(
        builder: (_) => Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "لطفا جهت دریافت پیامک اطلاع رسانی شماره تلفن همراه خود را وارد کنید",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      child: TextField(
                        controller: x.phoneRegContoller(),
                        maxLength: 11,
                        onChanged: (v) => x.phoneRegContoller.update((val) {}),
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.yellow, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            counterText: '',
                            hintText: '09154127181',
                            hintStyle: TextStyle(color: Colors.grey.shade300)),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all<Color>(
                              x.phoneRegContoller.value.text.length == 11
                                  ? Colors.yellow.shade600
                                  : Colors.yellow.shade100),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13.0),
                                      side: BorderSide(color: Colors.yellow)))),
                      onPressed: () =>
                          x.phoneRegContoller.value.text.length == 11
                              ? Get.to(VerificationCodePage())
                              : null,
                      child: Text(
                        "ثبت شماره تلفن",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
