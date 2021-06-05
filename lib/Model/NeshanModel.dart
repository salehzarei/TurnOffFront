import 'dart:convert';

NeshanModel neshanModelFromJson(String str) =>
    NeshanModel.fromJson(json.decode(str));

String neshanModelToJson(NeshanModel data) => json.encode(data.toJson());

class NeshanModel {
  NeshanModel({
    required this.status,
    required this.neighbourhood,
    required this.municipalityZone,
    required this.state,
    required this.city,
    required this.inOddEvenZone,
    required this.addresses,
    required this.routeName,
    required this.routeType,
    required this.place,
    required this.formattedAddress,
  });

  final String status;
  final String neighbourhood;
  final String municipalityZone;
  final String state;
  final String city;
  final bool inOddEvenZone;
  final List<Address> addresses;
  final String routeName;
  final String routeType;
  final String place;
  final String formattedAddress;

  factory NeshanModel.fromJson(Map<String, dynamic> json) => NeshanModel(
        status: json["status"] == null ? "" : json["status"],
        neighbourhood:
            json["neighbourhood"] == null ? "" : json["neighbourhood"],
        municipalityZone:
            json["municipality_zone"] == null ? "" : json["municipality_zone"],
        state: json["state"] == null ? "" : json["state"],
        city: json["city"] == null ? "" : json["city"],
        inOddEvenZone:
            json["in_odd_even_zone"] == null ? true : json["in_odd_even_zone"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        // addresses: json["addresses"] ??
        //     List<Address>.from(
        //         json["addresses"].map((x) => Address.fromJson(x))),
        routeName: json["route_name"] == null ? "" : json["route_name"],
        routeType: json["route_type"] == null ? "" : json["route_type"],
        place: json["place"] == null ? "" : json["place"],
        formattedAddress:
            json["formatted_address"] == null ? "" : json["formatted_address"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "neighbourhood": neighbourhood == null ? null : neighbourhood,
        "municipality_zone": municipalityZone == null ? null : municipalityZone,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "in_odd_even_zone": inOddEvenZone == null ? null : inOddEvenZone,
        "addresses": addresses == null
            ? null
            : List<dynamic>.from(addresses.map((x) => x.toJson())),
        "route_name": routeName == null ? null : routeName,
        "route_type": routeType == null ? null : routeType,
        "place": place == null ? null : place,
        "formatted_address": formattedAddress == null ? null : formattedAddress,
      };
}

class Address {
  Address({
    required this.formatted,
    required this.components,
  });

  final String formatted;
  final List<Component> components;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        formatted: json["formatted"] == null ? "" : json["formatted"],
        // components: json["components"] == null ? null : List<Component>.from(json["components"].map((x) => Component.fromJson(x))),
        components: List<Component>.from(
            json["components"].map((x) => Component.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "formatted": formatted == null ? "" : formatted,
        "components": components == null
            ? ""
            : List<dynamic>.from(components.map((x) => x.toJson())),
      };
}

class Component {
  Component({
    required this.name,
    required this.type,
  });

  final String name;
  final String type;

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        name: json["name"] == null ? "" : json["name"],
        type: json["type"] == null ? "" : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? "" : name,
        "type": type == null ? "" : type,
      };
}
