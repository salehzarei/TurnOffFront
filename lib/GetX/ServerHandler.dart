import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TurnOffConnect extends GetConnect {
  Future getUserProfileData() async {
    final response =
        await rootBundle.loadString('assets/json/userprofilesample.json');
    //delay for test
    await Future.delayed(Duration(milliseconds: 5000));
    return response;
  }

  Future getLocationNameData(String lat, String lon) async {
    final response = await get(
        'https://api.neshan.org/v2/reverse?lat=$lat&lng=$lon',
        headers: {
          "Api-Key": "service.BnkIsMhYrHF5iP0bKw3yTNnNMJv7OsDj4fc2Ybrb"
        });
    return response;
  }

  Future checkUserNumber(String phone) async {
    final response = await get('https://shifon.ir/users/$phone');
    return response;
  }
}
