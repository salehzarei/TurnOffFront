import 'dart:convert';

import 'package:get/get_connect/http/src/request/request.dart';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    required this.userphone,
    required this.status,
    required this.notetype,
    required this.selectedcompany,
    required this.charge,
    required this.remindtime,
    required this.addresses,
    required this.userToken,
    required this.firbaseToken,
  });

  String userphone;
  String status;
  List<String> notetype;
  List<String> selectedcompany;
  int charge;
  int remindtime;
  List<UserAddress> addresses;
  String userToken;
  String firbaseToken;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
      userphone: json["userphone"],
      status: json["status"],
      // notetype: List<String>.from(json["notetype"].map((x) => x)),
      notetype: List<String>.from(jsonDecode(json["notetype"]).map((x) => x)),
      selectedcompany:
          List<String>.from(jsonDecode(json["selectedcompany"]).map((x) => x)),
      charge: json["charge"],
      remindtime: json["remindtime"],
      addresses: List<UserAddress>.from(
          jsonDecode(json["addresses"]).map((x) => UserAddress.fromJson(x))),
      userToken: json["userToken"],
      firbaseToken: json['firbaseToken']);

  Map<String, dynamic> toJson() => {
        "userphone": userphone,
        "status": status,
        "notetype": List<dynamic>.from(notetype.map((x) => x)),
        "selectedcompany": List<dynamic>.from(selectedcompany.map((x) => x)),
        "charge": charge,
        "remindtime": remindtime,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "userToken": userToken,
        "firbaseToken": firbaseToken
      };
}

class UserAddress {
  UserAddress({
    required this.province,
    required this.city,
    required this.local,
    required this.street,
    required this.title,
    required this.location,
  });

  String province;
  String city;
  String local;
  String street;
  String title;
  UserLocation location;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        province: json["province"],
        city: json["city"],
        local: json["local"],
        street: json["street"],
        title: json["title"],
        location: UserLocation.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "province": province,
        "city": city,
        "local": local,
        "street": street,
        "title": title,
        "location": location.toJson(),
      };
}

class UserLocation {
  UserLocation({
    required this.lat,
    required this.lon,
  });

  String lat;
  String lon;

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}
