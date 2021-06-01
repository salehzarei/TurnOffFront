import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
            //  height: 208,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
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
                    Text(
                      'اطلاع رسانی فعال',
                      style: Get.textTheme.bodyText1,
                    ),
                    Icon(
                      Icons.notifications_active_rounded,
                      color: Colors.green,
                      size: 16,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'خراسان رضوی، مشهد، ناحیه 12، رحمانیه 19، کوچه فرعی',
                    style: Get.textTheme.headline6,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_active_rounded,
                        color: Colors.grey,
                        size: 15,
                      ),
                      Text(
                        'اعلان های قطعی برق در روز جاری',
                        style: Get.textTheme.headline3,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 15,
                            backgroundImage:
                                AssetImage('assets/images/bargh.png')),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            'قطعی برق',
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 10,),
                    Row(children: [
                      Text(' امروز شنبه 1400/3/10',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              )),
                              Text(' از ساعت 15:30 الی 16:30',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))
                    ]),

                    // Column(
                    //   children: [
                    //     CircleAvatar(
                    //         backgroundColor: Colors.white,
                    //         radius: 15,
                    //         backgroundImage:
                    //             AssetImage('assets/images/ab.png')),
                    //     Padding(
                    //       padding: const EdgeInsets.only(top: 5.0),
                    //       child: Text('قطعی آب' , style: TextStyle(fontSize: 12)),
                    //     )
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     CircleAvatar(
                    //         backgroundColor: Colors.white,
                    //         radius: 15,
                    //         backgroundImage:
                    //             AssetImage('assets/images/gaz.png')),
                    //     Padding(
                    //       padding: const EdgeInsets.only(top: 5.0),
                    //       child: Text('قطعی گاز' , style: TextStyle(fontSize: 12)),
                    //     )
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     CircleAvatar(
                    //         backgroundColor: Colors.white,
                    //         radius: 15,
                    //         backgroundImage:
                    //             AssetImage('assets/images/mokhaberat.png')),
                    //     Padding(
                    //       padding: const EdgeInsets.only(top: 5.0),
                    //       child: Text('قطعی تلفن' , style: TextStyle(fontSize: 12)),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'مشاهده اعلان های هفته جاری',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, -16),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.info_outline,
              size: 25,
              color: Colors.blueGrey,
            ),
          ),
        )
      ],
    );
  }
}
