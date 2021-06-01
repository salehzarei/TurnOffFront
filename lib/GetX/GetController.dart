import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TurnOffController extends GetxController {
  final todayindex = DateTime.now().weekday;
  final isReciveMesseage = false.obs;
  final isReciveNotification = true.obs;
  final reminderTime = 15.obs;

  void changeRemiderTime(int value) {
    reminderTime(value);
  }

  informationDialog() => Get.defaultDialog(
      title: 'جدول اعلام قطعی هفته جاری',
      confirm:
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.cancel)),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: Get.width * 0.90,
          height: Get.height * 0.45,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              DataTable(columnSpacing: 15, columns: <DataColumn>[
                DataColumn(label: Text('روزهای هفته')),
                DataColumn(
                  label: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      backgroundImage: AssetImage('assets/images/bargh.png')),
                ),
                // DataColumn(
                //   label: CircleAvatar(
                //       backgroundColor: Colors.white,
                //       radius: 15,
                //       backgroundImage: AssetImage('assets/images/ab.png')),
                // ),
                // DataColumn(
                //   label: CircleAvatar(
                //       backgroundColor: Colors.white,
                //       radius: 15,
                //       backgroundImage: AssetImage('assets/images/gaz.png')),
                // ),
                // DataColumn(
                //   label: CircleAvatar(
                //       backgroundColor: Colors.white,
                //       radius: 15,
                //       backgroundImage:
                //           AssetImage('assets/images/mokhaberat.png')),
                // ),
              ], rows: <DataRow>[
                DataRow(
                  /// شنبه
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (todayindex == 6)
                      return Colors.yellow.shade100.withOpacity(0.5);
                    else
                      return Colors.transparent; // Use the default value.
                  }),
                  cells: <DataCell>[
                    DataCell(Text(
                      DateTime.now()
                          .subtract(Duration(days: DateTime.now().weekday + 1))
                          .toPersianDateStr(showDayStr: true),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text(
                      '19:30 الی 20:30',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                    //         DataCell(Text('اعلام نشده')),
                    //         DataCell(Text('اعلام نشده')),
                    //         DataCell(Text('20:30 الی 22:30',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold)
                    // )
                    // ),
                  ],
                ),
                DataRow(
                  /// یکشنبه
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (todayindex == 0)
                      return Colors.yellow.shade100.withOpacity(0.5);
                    else
                      return Colors.transparent; // Use the default value.
                  }),
                  cells: <DataCell>[
                    DataCell(Text(
                      DateTime.now()
                          .subtract(Duration(days: DateTime.now().weekday))
                          .toPersianDateStr(showDayStr: true),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('اعلام نشده')),
                    // DataCell(Text('اعلام نشده')),
                    // DataCell(Text('اعلام نشده')),
                    // DataCell(Text('اعلام نشده')),
                  ],
                ),
                DataRow(
                  /// دوشنبه
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (todayindex == 1)
                      return Colors.yellow.shade100.withOpacity(0.5);
                    else
                      return Colors.transparent; // Use the default value.
                  }),
                  cells: <DataCell>[
                    DataCell(Text(
                      DateTime.now()
                          .subtract(Duration(days: DateTime.now().weekday - 1))
                          .toPersianDateStr(showDayStr: true),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('11:30 الی 12:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('14:30 الی 17:30',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('اعلام نشده')),
                    //         DataCell(Text('اعلام نشده')),
                  ],
                ),
                DataRow(
                  /// سه شنبه
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (todayindex == 2)
                      return Colors.yellow.shade100.withOpacity(0.5);
                    else
                      return Colors.transparent; // Use the default value.
                  }),
                  cells: <DataCell>[
                    DataCell(Text(
                      DateTime.now()
                          .subtract(Duration(days: DateTime.now().weekday - 2))
                          .toPersianDateStr(showDayStr: true),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('اعلام نشده')),
                    // DataCell(Text('اعلام نشده')),
                    // DataCell(Text('اعلام نشده')),
                    // DataCell(Text('اعلام نشده')),
                  ],
                ),
                DataRow(
                  /// چهارشنبه

                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (todayindex == 3)
                      return Colors.yellow.shade100.withOpacity(0.5);
                    else
                      return Colors.transparent; // Use the default value.
                  }),
                  cells: <DataCell>[
                    DataCell(Text(
                      DateTime.now()
                          .subtract(Duration(days: DateTime.now().weekday - 3))
                          .toPersianDateStr(showDayStr: true),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('اعلام نشده')),
                    //         DataCell(Text('اعلام نشده')),
                    //         DataCell(Text('13:00 الی 14:00',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('19:30 الی 20:30',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold))),
                  ],
                ),
                DataRow(
                  /// پنجشنبه
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (todayindex == 4)
                      return Colors.yellow.shade100.withOpacity(0.5);
                    else
                      return Colors.transparent; // Use the default value.
                  }),
                  cells: <DataCell>[
                    DataCell(Text(
                      DateTime.now()
                          .subtract(Duration(days: DateTime.now().weekday - 4))
                          .toPersianDateStr(showDayStr: true),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('19:30 الی 20:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('اعلام نشده')),
                    //         DataCell(Text('اعلام نشده')),
                    //         DataCell(Text('19:30 الی 20:30',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold))),
                  ],
                ),
                DataRow(
                  /// جمعه
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (todayindex == 5)
                      return Colors.yellow.shade100.withOpacity(0.5);
                    else
                      return Colors.transparent; // Use the default value.
                  }),
                  cells: <DataCell>[
                    DataCell(Text(
                      DateTime.now()
                          .subtract(Duration(days: DateTime.now().weekday - 5))
                          .toPersianDateStr(showDayStr: true),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('19:30 الی 20:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('اعلام نشده')),
                    //         DataCell(Text('اعلام نشده')),
                    //         DataCell(Text('19:30 الی 20:30',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold))),
                  ],
                ),
              ])
            ],
          ),
        ),
      ));
}
