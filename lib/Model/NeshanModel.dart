// To parse this JSON data, do
//
//     final neshanModel = neshanModelFromJson(jsonString);

import 'dart:convert';

NeshanModel neshanModelFromJson(String str) => NeshanModel.fromJson(json.decode(str));

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

    String status;
    String neighbourhood;
    String municipalityZone;
    String state;
    String city;
    bool inOddEvenZone;
    List<Address> addresses;
    String routeName;
    String routeType;
    String place;
    String formattedAddress;

    factory NeshanModel.fromJson(Map<String, dynamic> json) => NeshanModel(
        status: json["status"],
        neighbourhood: json["neighbourhood"],
        municipalityZone: json["municipality_zone"],
        state: json["state"],
        city: json["city"],
        inOddEvenZone: json["in_odd_even_zone"],
        addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
        routeName: json["route_name"],
        routeType: json["route_type"],
        place: json["place"],
        formattedAddress: json["formatted_address"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "neighbourhood": neighbourhood,
        "municipality_zone": municipalityZone,
        "state": state,
        "city": city,
        "in_odd_even_zone": inOddEvenZone,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "route_name": routeName,
        "route_type": routeType,
        "place": place,
        "formatted_address": formattedAddress,
    };
}

class Address {
    Address({
        required this.formatted,
        required this.components,
    });

    String formatted;
    List<Component> components;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        formatted: json["formatted"],
        components: List<Component>.from(json["components"].map((x) => Component.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "formatted": formatted,
        "components": List<dynamic>.from(components.map((x) => x.toJson())),
    };
}

class Component {
    Component({
        required this.name,
        required this.type,
    });

    String name;
    String type;

    factory Component.fromJson(Map<String, dynamic> json) => Component(
        name: json["name"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
    };
}
