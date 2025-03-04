// To parse this JSON data, do
//
//     final appSettingsResponse = appSettingsResponseFromJson(jsonString);

import 'dart:convert';

AppSettingsResponse appSettingsResponseFromJson(String str) =>
    AppSettingsResponse.fromJson(json.decode(str));

String appSettingsResponseToJson(AppSettingsResponse data) =>
    json.encode(data.toJson());

class AppSettingsResponse {
  String status;
  AppSettings data;

  AppSettingsResponse({
    required this.status,
    required this.data,
  });

  factory AppSettingsResponse.fromJson(Map<String, dynamic> json) =>
      AppSettingsResponse(
        status: json["status"],
        data: AppSettings.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class AppSettings {
  int id;
  String helpUrl;
  String privacyPolicyUrl;
  String termsAndConditionUrl;
  String aboutUs;
  double fee;
  String adminAddress;

  AppSettings({
    required this.id,
    required this.helpUrl,
    required this.privacyPolicyUrl,
    required this.termsAndConditionUrl,
    required this.aboutUs,
    required this.fee,
    required this.adminAddress,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        id: json["id"],
        helpUrl: json["helpUrl"],
        privacyPolicyUrl: json["privacyPolicyUrl"],
        termsAndConditionUrl: json["termsAndConditionUrl"],
        aboutUs: json["aboutUs"],
        fee: double.parse(json["fee"].toString()),
        adminAddress: json["adminAddress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "helpUrl": helpUrl,
        "privacyPolicyUrl": privacyPolicyUrl,
        "termsAndConditionUrl": termsAndConditionUrl,
        "aboutUs": aboutUs,
        "fee": fee,
        "adminAddress": adminAddress,
      };
}
