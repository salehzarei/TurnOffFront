import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:turnoff/Model/NeshanModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turnoff/Model/UserProfileModel.dart';
import 'package:universe/universe.dart';
import 'ServerHandler.dart';

class TurnOffController extends GetxController {
  final todayindex = DateTime.now().weekday;
  final isReciveMesseage = false.obs;
  final isReciveNotification = true.obs;
  final reminderTime = 15.obs;
  final isloadingData = true.obs;
  final neshani = NeshanModel(
          status: "",
          neighbourhood: "",
          municipalityZone: "",
          state: "",
          city: "",
          inOddEvenZone: false,
          addresses: [],
          routeName: "",
          routeType: "",
          place: "",
          formattedAddress: "")
      .obs;

  final userPosition = Position(
          longitude: 0.0,
          latitude: 0.0,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0)
      .obs;

  final userData = UserProfile(
          userphone: "",
          addresses: [],
          charge: 0,
          notetype: [],
          remindtime: 15,
          selectedcompany: [],
          status: false)
      .obs;
  final mapContoller = MapController().obs;
  final mapKey = UniqueKey();
  //MapData? mapData;
  final mapData = MapData(center: LatLng(0, 0), zoom: 15.5).obs;
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void changeRemiderTime(int value) {
    reminderTime(value);
  }

  void listenPositionStream() {
    mapData.value = MapData(
      center: mapContoller.value.center,
      zoom: mapContoller.value.zoom!,
    );

    // listen everytime the map data changes (move or zoom)
    mapContoller.value.positionStream?.listen((data) async {
      mapData.value = data;
      await Future.delayed(Duration(milliseconds: 5000));
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    loadUserData().whenComplete(() => upDateUserSetting());
  }

  Future loadUserData() async {
    isloadingData(true);
    final response = await TurnOffConnect().getUserProfileData();
    // print("Is Loading Data: " + response.toString());
    // print(UserProfile.fromJson(jsonDecode(response)));
    userData(UserProfile.fromJson(jsonDecode(response)));
    isloadingData(false);
  }

  Future getDeviceLocation() async {
    // userPosition.value = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    userPosition.value = await determinePosition();
    print(userPosition);
  }

  void upDateUserSetting() {
    switch (userData.value.remindtime) {
      case 15:
        reminderTime(15);
        break;
      case 30:
        reminderTime(30);
        break;
      case 60:
        reminderTime(60);
        break;
      case 120:
        reminderTime(120);
        break;
      default:
    }

    if (userData.value.notetype.contains("notification"))
      isReciveNotification(true);
    if (userData.value.notetype.contains("sms")) isReciveMesseage(true);
  }

  getNeshani() async {
    Response locationName = await TurnOffConnect().getLocationNameData(
        mapData.value.center.latitudeStr, mapData.value.center.longitudeStr);
    // print(locationName.body);
    neshani.value = NeshanModel.fromJson(locationName.body);
  }

  informationDialog() => Get.defaultDialog(
      title: 'جدول اعلام قطعی هفته جاری',
      confirm:
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.cancel)),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: Get.width * 0.90,
          height: Get.height * 0.55,
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
