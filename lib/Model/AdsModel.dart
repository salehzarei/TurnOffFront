import 'dart:convert';

List<AdsModel> adsModelFromJson(String str) =>
    List<AdsModel>.from(json.decode(str).map((x) => AdsModel.fromJson(x)));

String adsModelToJson(List<AdsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdsModel {
  AdsModel({
    required this.adsid,
    required this.imageurl,
    required this.linkurl,
  });

  final int adsid;
  final String imageurl;
  final String linkurl;

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        adsid: json["adsid"] == null ? null : json["adsid"],
        imageurl: json["imageurl"] == null ? null : json["imageurl"],
        linkurl: json["linkurl"] == null ? null : json["linkurl"],
      );

  Map<String, dynamic> toJson() => {
        "adsid": adsid == null ? null : adsid,
        "imageurl": imageurl == null ? null : imageurl,
        "linkurl": linkurl == null ? null : linkurl,
      };
}
