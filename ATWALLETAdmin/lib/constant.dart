import 'package:cryptomask_admin/service/local/model/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color kPrimaryColor = Color(0xff7b15ef);

List<Network> networks = [
  Network(
    networkName: "Ethereum mainnet",
    currency: "ETH",
    chainId: 1,
  ),
  Network(
    networkName: "Polygon Mainnet",
    currency: "MATIC",
    chainId: 137,
  ),
  Network(
    networkName: "Binace Smart Chain Mainnet",
    currency: "BNB",
    chainId: 56,
  ),
  Network(
    networkName: "Binace Smart Chain Testnet",
    currency: "BNB",
    chainId: 97,
  ),
];

Network? getNetwork(int chainId) {
  return networks.firstWhereOrNull((element) => element.chainId == chainId);
}
