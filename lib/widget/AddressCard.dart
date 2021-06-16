import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:turnoff/GetX/GetController.dart';
import 'package:turnoff/Model/UserProfileModel.dart';

class AddressCard extends StatelessWidget {
  final UserAddress userAddress;
  final int index;

  const AddressCard({required this.userAddress, required this.index});
  @override
  Widget build(BuildContext context) {
    final TurnOffController x = Get.put(TurnOffController());
    final TextEditingController title = TextEditingController();
    return GetBuilder<TurnOffController>(
        builder: (_) => Card(
              color: Colors.grey.shade200,
              child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                        size: 15,
                      ),
                      Text(
                        userAddress.title,
                        style: Get.textTheme.headline3,
                      ),
                      Spacer(),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: Get.width,
                      height: 20,
                      child: Marquee(
                        text:
                            '${userAddress.province}، ${userAddress.city}، ${userAddress.local} ، ${userAddress.street}',
                        style: Get.textTheme.headline6,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // blankSpace: 5.0,
                        // pauseAfterRound: Duration(seconds: 1),
                        // startPadding: 10.0,
                        blankSpace: Get.width * 0.20,
                        velocity: -15,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () => Get.defaultDialog(
                          title: 'ویرایش آدرس',
                          content: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: title,
                                maxLength: 40,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 22),
                                decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'نام محل را اینجا وارد کنید',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade300)),
                              )),
                          confirm: TextButton(
                              onPressed: () {
                                x.updateAddress(index, title.text);
                                Get.back();
                              },
                              child: Text('ذخیره نام')),
                          cancel: TextButton(
                              onPressed: () {
                                x.deleteAddress(index);
                                Get.back();
                              },
                              style: ButtonStyle(),
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ))),
                      icon: Icon(Icons.edit_location_outlined))),
            ));
  }
}
