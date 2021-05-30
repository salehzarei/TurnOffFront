import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurnOffController extends GetxController {
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
                DataColumn(label: Text('روزها')),
                DataColumn(
                  label: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      backgroundImage: AssetImage('assets/images/bargh.png')),
                ),
                DataColumn(
                  label: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      backgroundImage: AssetImage('assets/images/ab.png')),
                ),
                DataColumn(
                  label: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      backgroundImage: AssetImage('assets/images/gaz.png')),
                ),
                DataColumn(
                  label: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      backgroundImage:
                          AssetImage('assets/images/mokhaberat.png')),
                ),
              ], rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'شنبه',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text(
                      '19:30 الی 20:30',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('20:30 الی 22:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'یکشنبه',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                  ],
                ),
                DataRow(
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    // if (states.contains(MaterialState.selected))
                    //   return Get.theme.colorScheme.primary.withOpacity(0.08);
                    return Colors.yellow.shade100.withOpacity(0.5); // Use the default value.
                  }),
                  cells: <DataCell>[
                    DataCell(Text(
                      'دوشنبه',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('11:30 الی 12:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    DataCell(Text('14:30 الی 17:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'سه شنبه',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'چهارشنبه',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('13:00 الی 14:00',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    DataCell(Text('19:30 الی 20:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'پنجشنبه',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('19:30 الی 20:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('19:30 الی 20:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                      'جمعه',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text('19:30 الی 20:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('اعلام نشده')),
                    DataCell(Text('19:30 الی 20:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                  ],
                ),
              ])
            ],
          ),
        ),
      ));
}
