import 'package:flutter/material.dart';

class LocationCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 208,
        margin: EdgeInsets.all(08),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.home),
                Text('محل سکونت خودم'),
                Spacer(),
                Text(
                  'اطلاع رسانی فعال',
                ),
                Icon(Icons.notifications_active_rounded),
              ],
            ),
            Text('خراسان رضوی، مشهد، ناحیه 12، رحمانیه 19، کوچه فرعی'),
            Row(
              children: [
                Icon(Icons.notifications_active_rounded),
                Text('اعلان های درخواستی'),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/bargh.png')),
                    Text('قطعی برق')
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/ab.png')),
                    Text('قطعی آب')
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/gaz.png')),
                    Text('قطعی گاز')
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/mokhaberat.png')),
                    Text('قطعی تلفن')
                  ],
                ),
              ],
            ),
            Text('مشاهده وضعیت'),
            Transform.translate(
              offset: Offset(0.0, 25),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_circle_down_outlined,
                  size: 28,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
