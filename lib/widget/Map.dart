import 'package:flutter/material.dart';
import 'package:turnoff/GetX/GetController.dart';
import 'package:universe/universe.dart';
import 'package:get/get.dart';

class TurnOffMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final x = Get.put(TurnOffController());
    return GetX<TurnOffController>(
        builder: (_) => Scaffold(
              floatingActionButton: SizedBox(
                height: 100,
                width: 100,
                child: FloatingActionButton(
                    child: Text(
                      'بررسی\nآدرس',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          height: 1.25),
                    ),
                    onPressed: () => x.getNeshani()),
              ),
              body: Stack(
                fit: StackFit.expand,
                children: [
                  U.OpenStreetMap(
                    key: x.mapKey,
                    controller: x.mapContoller.value,
                    center: [
                      x.userPosition.value.latitude,
                      x.userPosition.value.longitude
                    ],
                    zoom: 17,
                    showLocator: true,
                    showCenterMarker: true,
                    locator: Locator(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 10, bottom: 50),
                    ),
                    scale: Scale(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(bottom: 64, left: 90),
                      color: Colors.brown,
                      fontSize: 14,
                    ),
                    onReady: () {
                      x.listenPositionStream();
                      x.getNeshani();
                    },
                  ),
                  if (x.mapData.value != null)
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 100),
                        color: Colors.transparent,
                        child: Material(
                          elevation: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10),
                            child: Text(
                              '${x.neshani.value.state},${x.neshani.value.city}\n${x.neshani.value.addresses[0].formatted}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.25,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 40, right: 40),
                        color: Colors.transparent,
                        child: RaisedButton(
                          color: Colors.greenAccent.shade400,
                          onPressed: () => Get.back(),
                          child: Text(
                            "تایید و ثبت آدرس",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: Get.width,
                      height: 40,
                      margin: EdgeInsets.only(left: 0, bottom: 0, right: 0),
                      child: Material(
                        elevation: 6,
                        child: Container(
                          color: Colors.blue,
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                          child: Text(
                              'Center: ${x.mapData.value.center.toSimpleString()}\nZoom: ${x.mapData.value.zoom}'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
