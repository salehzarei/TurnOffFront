import 'dart:convert';
import 'package:get/get.dart';

class TurnOffConnect extends GetConnect {
  // final String serverURL = 'https://shifon.ir';
  // final String serverURL = 'http://10.0.2.2:3000';
  final String serverURL = 'http://192.168.1.100:3000';

  Future getUserProfileData(String token) async {
    final response =
        //   await rootBundle.loadString('assets/json/userprofilesample.json');
        //delay for test
        // await Future.delayed(Duration(milliseconds: 5000));

        await post('$serverURL/users/getdata', {"turnofftoken": token});

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
    final response = await get('$serverURL/users/$phone');
    return response;
  }

  Future checkOTP(String mobile, String verificationCode) async {
    final response = await post('$serverURL/users/checkotp',
        {"phone": mobile, "otp": verificationCode});
    return response;
  }

  Future updateUserData(userData) async {
    print(jsonEncode(userData.value));
    final response =
        await post('$serverURL/users/update', jsonEncode(userData.value));
    return response;
  }

  Future getAds() async {
    final response = await get('$serverURL/ads');
    return response;
  }
}
