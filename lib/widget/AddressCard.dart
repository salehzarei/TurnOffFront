import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:turnoff/Model/UserProfileModel.dart';

class AddressCard extends StatelessWidget {
  final UserAddress userAddress;

  const AddressCard({required this.userAddress});
  @override
  Widget build(BuildContext context) {
    return Card(
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
              onPressed: () {}, icon: Icon(Icons.edit_location_outlined))),
    );
  }
}
