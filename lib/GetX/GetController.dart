import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turnoff/Model/AdsModel.dart';
import 'package:turnoff/Model/NeshanModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turnoff/Model/UserProfileModel.dart';
import 'package:turnoff/VerificationCodePage.dart';
import 'package:turnoff/HomePage.dart';
import 'package:universe/universe.dart';
// import '../main.dart';
import 'ServerHandler.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TurnOffController extends GetxController {
  final todayindex = DateTime.now().weekday;
  final isReciveMesseage = false.obs;
  final isReciveNotification = true.obs;
  final isSystemActive = true.obs;
  final reminderTime = 15.obs;
  final isloadingData = false.obs;
  final isGPSEnable = true.obs;
  final isGPSDenied = false.obs;
  final userToken = ''.obs;
  final firebaseToken = ''.obs;
  final userVerificationCode = ''.obs;
  final phoneRegContoller = TextEditingController().obs;
  final sliderController = CarouselSliderController().obs;
  final adsSlider = <AdsModel>[].obs;
  final neshani = NeshanModel(
          status: "",
          neighbourhood: "",
          municipalityZone: "",
          state: "",
          city: "",
          inOddEvenZone: false,
          addresses: [
            Address(
                components: [Component(name: "name", type: "type")],
                formatted: "")
          ],
          routeName: "",
          routeType: "",
          place: "",
          formattedAddress: "")
      .obs;

  var userPosition = Position(
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
          status: "1",
          userToken: "",
          firbaseToken: "")
      .obs;
  final mapContoller = MapController().obs;
  final mapKey = UniqueKey();

  final mapData = MapData(center: LatLng(0, 0), zoom: 15.5).obs;

// ?????????????? ???????????? ???????? ????????????
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
// ???????????? ???????? ???? ????????
  Future getTokenFromPhone() async {
    final SharedPreferences prefs = await _prefs;
    final String token = (prefs.getString('token') ?? '');
    if (token != '') {
      userToken(token);
      await loadUserData(token: token);
    }
  }

// ?????????? ?????????? ???????????? ???? ????????
  Future checkMobile() async {
    Response mobileStatus =
        await TurnOffConnect().checkUserNumber(phoneRegContoller.value.text);
    if (mobileStatus.status.code == 200) {
      Map<String, dynamic> result = mobileStatus.body;
      if (result['success'] == -1) {
        Get.off(VerificationCodePage());
      }
      if (result['success'] == 1) {
        print(result['data']['userToken']);
        userData(UserProfile.fromJson(mobileStatus.body['data']));
        setTokeninPhone(result['data']['userToken'])
            .whenComplete(() => Get.off(HomePage()));
      }
    } else
      print("?????? ???? ?????????? ???? ???? ?????????? ???? ???????? ????????????");
  }

// ?????????? ???? ?????????? ???????? ??????????
  Future checkVerificationCode() async {
    Response check = await TurnOffConnect()
        .checkOTP(phoneRegContoller.value.text, userVerificationCode.value);
    Map<String, dynamic> result = check.body;
    print(result);
    if (result['success'] == 0)
      Get.snackbar("??????????", "",
          backgroundColor: Colors.red.withOpacity(0.7),
          titleText: Icon(
            Icons.warning_amber_sharp,
            color: Colors.white,
          ),
          messageText: Text(
            result['message'],
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17),
          ),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    // ?????? ???? ???????? ?????? ???????????? ???????????? ???? ?????? ?? ???????? ??????
    if (result['success'] == 1) checkMobile();
  }

// ???????????? ?????????????? ???? ???????? ???? ???????? ????????
  Future loadUserData({required String token}) async {
    print("Run Load Data with Token $token");
    isloadingData(true);
    final Response response = await TurnOffConnect().getUserProfileData(token);
    print("Is Loading Data: " + response.body.toString());
    if (response.body['success'] == 1)
      userData(UserProfile.fromJson(response.body['data']));
    isloadingData(false);
  }

// ???????????? ?????????????? ?????????????????? ???? ????????
  Future getAdsData() async {
    final Response response = await TurnOffConnect().getAds();
    if (response.body == null) throw ("???????????? ???? ???????? ???????????? ??????");
    if (response.body['success'] == 1)
      adsSlider(List<AdsModel>.from(
          response.body['data'].map((x) => AdsModel.fromJson(x))));

    if (response.body['success'] == 0)
      adsSlider.add(AdsModel(
          adsid: 1,
          imageurl:
              'https://barghnews.com/files/fa/news/1399/5/6/93160_449.jpg',
          linkurl:
              'https://barghnews.com/files/fa/news/1399/5/6/93160_449.jpg'));
  }

// ???? ???????????????? ?????????????? ?? ?????????????? ?????????? ???? ????????
  Future updateUserSetting() async {
    loadUSerSetting();
    isloadingData(true);
    final Response response = await TurnOffConnect().updateUserData(userData);
    if (response.body['success'] == 1) {
      print("???????????? ???????? ??????");
      isloadingData(false);
    }
  }

// ?????????? ???????? ???? ????????
  Future setTokeninPhone(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', token);
  }

// ?????????? ???????? ???????? ???????? ???? ????????
  addNewAddress() {
    final UserLocation newLocation = UserLocation(
        // lat: userPosition.value.latitude.toString(),
        // lon: userPosition.value.longitude.toString()
        lat: mapData.value.center.latitudeStr,
        lon: mapData.value.center.longitudeStr);
    final UserAddress newAddress = UserAddress(
        province: neshani.value.state,
        city: neshani.value.city,
        local: neshani.value.municipalityZone,
        street: neshani.value.routeName,
        title: "???????? ?????? (???????????? ????????)",
        location: newLocation);
    userData.update((userData) {
      userData!.addresses.add(newAddress);
    });
  }

  deleteAddress(int index) {
    userData.update((userData) {
      userData!.addresses.removeAt(index);
    });
  }

  updateAddress(int index, String title) {
    if (title.length == 0) title = '???????? ??????';
    userData.update((userData) {
      userData!.addresses[index].title = title;
    });
  }

//???????????? ???? ???? ???? ???? ?? ?????????? ???????????? ?????????? ????????
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isGPSEnable(false);
      return Future.error('Location services are disabled.');
    } else
      isGPSEnable(true);
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isGPSDenied(true);
        return Future.error('Location permissions are denied');
      } else
        isGPSDenied(false);
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    userPosition.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return userPosition.value;
  }

// ???????????? ???????? ???? ???????? ???? ????????
  Future getNeshani(LatLng latlng) async {
    isloadingData(true);
    Response locationName = await TurnOffConnect()
        .getLocationNameData(latlng.latitudeStr, latlng.longitudeStr);
    print(locationName.body);
    neshani.value = NeshanModel.fromJson(locationName.body);
    isloadingData(false);
  }

// ???? ?????? ?????????? ???????????? ????????
  Future updateNeshani(newData) async {
    mapData.value = new MapData(zoom: 17, center: newData);
    await getNeshani(mapData.value.center);
  }

  void listenPositionStream() {
    mapData.value = MapData(
      center: mapContoller.value.center,
      zoom: mapContoller.value.zoom!,
    );

    // listen everytime the map data changes (move or zoom)
    mapContoller.value.positionStream?.listen((data) {
      mapData.value = data;
      update();
    });
  }

  @override
  void dispose() {
    mapContoller.value.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    //???? ???????? ???????? ??????????
    getTokenFromPhone();
    getAdsData();

    FirebaseMessaging.instance.getToken().then((token) {
      print("FireBase Token is :" + token.toString());
      firebaseToken(token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Get.dialog(AlertDialog(
          backgroundColor: Colors.yellow.shade400,
          title: Text(
            notification.title ?? "",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  notification.body ?? "",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ));
        // flutterLocalNotificationsPlugin.show(
        //     notification.hashCode,
        //     notification.title,
        //     notification.body,
        //     NotificationDetails(
        //       android: AndroidNotificationDetails(
        //         channel.id,
        //         channel.name,
        //         channel.description,
        //         color: Colors.blue,
        //         playSound: true,
        //         icon: '@mipmap/ic_launcher',
        //       ),
        //     ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Get.dialog(AlertDialog(
          backgroundColor: Colors.yellow.shade400,
          title: Text(notification.title ?? "", textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(notification.body ?? "", textAlign: TextAlign.center)
              ],
            ),
          ),
        ));
      }
    });
  }

  // void showNotification() {
  //   flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Testing ",
  //       "How you doin ?",
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               channel.id, channel.name, channel.description,
  //               importance: Importance.high,
  //               color: Colors.blue,
  //               playSound: true,
  //               icon: '@mipmap/ic_launcher')));
  // }

  void changeRemiderTime(int value) {
    reminderTime(value);
  }

  void loadUSerSetting() {
    // ?????????? ???????? ???????? ??????????????
    userData.update((userData) {
      userData!.firbaseToken = firebaseToken.value;
      print(userData.firbaseToken);
    });

    switch (userData.value.remindtime) {
      case 15:
        reminderTime(15);
        update();
        break;
      case 30:
        reminderTime(30);
        update();
        break;
      case 60:
        reminderTime(60);
        update();
        break;
      case 120:
        reminderTime(120);
        update();
        break;
      default:
    }

    if (userData.value.notetype.contains("notification"))
      isReciveNotification(true);
    if (userData.value.notetype.contains("sms")) isReciveMesseage(true);
  }

  informationDialog() => Get.defaultDialog(
      title: '???????? ?????????? ???????? ???????? ????????',
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
                DataColumn(label: Text('???????????? ????????')),
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
                  /// ????????
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
                      '19:30 ?????? 20:30',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                    //         DataCell(Text('?????????? ????????')),
                    //         DataCell(Text('?????????? ????????')),
                    //         DataCell(Text('20:30 ?????? 22:30',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold)
                    // )
                    // ),
                  ],
                ),
                DataRow(
                  /// ????????????
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
                    DataCell(Text('?????????? ????????')),
                    // DataCell(Text('?????????? ????????')),
                    // DataCell(Text('?????????? ????????')),
                    // DataCell(Text('?????????? ????????')),
                  ],
                ),
                DataRow(
                  /// ????????????
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
                    DataCell(Text('11:30 ?????? 12:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('14:30 ?????? 17:30',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('?????????? ????????')),
                    //         DataCell(Text('?????????? ????????')),
                  ],
                ),
                DataRow(
                  /// ???? ????????
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
                    DataCell(Text('?????????? ????????')),
                    // DataCell(Text('?????????? ????????')),
                    // DataCell(Text('?????????? ????????')),
                    // DataCell(Text('?????????? ????????')),
                  ],
                ),
                DataRow(
                  /// ????????????????

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
                    DataCell(Text('?????????? ????????')),
                    //         DataCell(Text('?????????? ????????')),
                    //         DataCell(Text('13:00 ?????? 14:00',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('19:30 ?????? 20:30',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold))),
                  ],
                ),
                DataRow(
                  /// ??????????????
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
                    DataCell(Text('19:30 ?????? 20:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('?????????? ????????')),
                    //         DataCell(Text('?????????? ????????')),
                    //         DataCell(Text('19:30 ?????? 20:30',
                    //             style: TextStyle(
                    // color: Colors.red, fontWeight: FontWeight.bold))),
                  ],
                ),
                DataRow(
                  /// ????????
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
                    DataCell(Text('19:30 ?????? 20:30',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))),
                    //         DataCell(Text('?????????? ????????')),
                    //         DataCell(Text('?????????? ????????')),
                    //         DataCell(Text('19:30 ?????? 20:30',
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
