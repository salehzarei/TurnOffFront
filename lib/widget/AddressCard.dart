import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressCard extends StatelessWidget {
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
                'محل سکونت خودم',
                style: Get.textTheme.headline3,
              ),
              Spacer(),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Text(
              'خراسان رضوی، مشهد، ناحیه 12، رحمانیه 19، کوچه فرعی',
              style: Get.textTheme.headline6,
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
          ),
          trailing: IconButton(
              onPressed: () {}, icon: Icon(Icons.edit_location_outlined))),
    );
  }
}
