// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  String value;
  TokenClass token;

  Token({
    required this.value,
    required this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        value: ((double.parse(json["balance"].toString())) /
                pow(10, json["decimals"]))
            .toString(),
        token: TokenClass.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "token": token.toJson(),
      };
}

class TokenClass {
  String? logo;
  int decimals;
  String name;
  String symbol;
  String contractAddress;
  double fiatValue;
  bool possibleSpam;

  TokenClass({
    required this.decimals,
    required this.name,
    required this.symbol,
    required this.contractAddress,
    required this.possibleSpam,
    required this.fiatValue,
    this.logo,
  });

  factory TokenClass.fromJson(Map<String, dynamic> json) => TokenClass(
      decimals: json["decimals"],
      name: json["name"],
      symbol: json["symbol"],
      contractAddress: json['native_token'] ? "" : json["token_address"],
      possibleSpam: json["possible_spam"],
      fiatValue: double.parse(json['usd_value']?.toString() ?? "0.0"),
      logo: json["logo"]);

  Map<String, dynamic> toJson() => {
        "decimals": decimals,
        "name": name,
        "symbol": symbol,
        "contractAddress": contractAddress,
        "possibleSpam": possibleSpam,
        "logo": logo,
        "usd_value": fiatValue
      };
}
