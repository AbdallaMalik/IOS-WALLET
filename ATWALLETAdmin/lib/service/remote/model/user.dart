// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:cryptomask_admin/ui/shared/dot.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String address;
  bool seedPhraseBackedUp;
  bool isDeactivated;
  bool isTransactionBlocked;
  List<String> subAddress;

  User({
    required this.id,
    required this.address,
    required this.seedPhraseBackedUp,
    required this.isDeactivated,
    required this.isTransactionBlocked,
    required this.subAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        address: json["address"],
        seedPhraseBackedUp: json["seedPhraseBackedUp"],
        isDeactivated: json["isDeactivated"],
        isTransactionBlocked: json["isTransactionBlocked"],
        subAddress: List<String>.from(json["subAddress"].map((x) => x)),
      );

  Widget getStatusForDiplay() {
    if (isDeactivated) {
      return const Row(
        children: [
          Dot(color: Colors.red),
          SizedBox(
            width: 10,
          ),
          WalletText(
            localizeKey: "userDeactivated",
          )
        ],
      );
    }
    if (isTransactionBlocked) {
      return const Row(
        children: [
          Dot(color: Colors.orange),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: WalletText(
              localizeKey: "userTransactionBlock",
            ),
          )
        ],
      );
    }
    return const Row(
      children: [
        Dot(color: Colors.green),
        SizedBox(
          width: 10,
        ),
        WalletText(
          localizeKey: "activeAccount",
        )
      ],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "seedPhraseBackedUp": seedPhraseBackedUp,
        "isDeactivated": isDeactivated,
        "isTransactionBlocked": isTransactionBlocked,
        "subAddress": List<dynamic>.from(subAddress.map((x) => x)),
      };
}
