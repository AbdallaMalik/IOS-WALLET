import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:wallet_cryptomask/core/model/network_model.dart';

NetworkProvider getLiveNetworkProvider(BuildContext context) =>
    Provider.of<NetworkProvider>(context);

NetworkProvider getNetworkProvider(BuildContext context) =>
    Provider.of<NetworkProvider>(context, listen: false);

class NetworkProvider extends ChangeNotifier {
  List<Network> networks = [];

  NetworkProvider() {
    networks = loadNetworks();
    notifyListeners();
  }

  loadNetworks() {
    return [
      Network(
          nameSpace: "eip155",
          networkName: "Ethereum mainnet",
          url: dotenv.env['ETHEREUM_RPC_URL'] ?? "",
          symbol: "ETH",
          currency: "ETH",
          chainId: 1,
          logo: "assets/images/eth.png",
          apiKey: dotenv.env['ETHEREUM_ETHERSCAN_API_KEY'] ?? "",
          isMainnet: true,
          addressViewUrl: "https://etherscan.io/address/",
          transactionViewUrl: "https://etherscan.io/tx/",
          dotColor: Colors.yellow,
          priceId: "ethereum",
          etherscanApiBaseUrl: "https://api.etherscan.io/"),
      Network(
          networkName: "Polygon Mainnet",
          url: dotenv.env['POLYGON_RPC_URL'] ?? "",
          symbol: "MATIC",
          currency: "MATIC",
          logo: "assets/images/polygon.png",
          nameSpace: "eip155",
          chainId: 137,
          priceId: "matic-network",
          apiKey: dotenv.env['POLYGON_POLYSCAN_API_KEY'] ?? "",
          isMainnet: true,
          addressViewUrl: "https://polygonscan.com/address/",
          transactionViewUrl: "https://polygonscan.com/tx/",
          dotColor: const Color(0xff8247e5),
          etherscanApiBaseUrl: "https://api.polygonscan.com/"),
      Network(
          networkName: "Binace Smart Chain Mainnet",
          url: dotenv.env['BINANCE_SMART_CHAIN_RPC_URL'] ?? "",
          symbol: "BNB",
          currency: "BNB",
          logo: "assets/images/bnb.png",
          nameSpace: "eip155",
          chainId: 56,
          priceId: "binancecoin",
          apiKey: dotenv.env['BINANCE_SMART_CHAIN_BSCSCAN_API_KEY'] ?? "",
          isMainnet: true,
          addressViewUrl: "https://bscscan.com/address/",
          transactionViewUrl: "https://bscscan.com/tx/",
          dotColor: Colors.orange,
          etherscanApiBaseUrl: "https://api.bscscan.com/"),
      Network(
          networkName: "Binace Smart Chain Testnet",
          url: dotenv.env['BINANCE_SMART_CHAIN_TESTNET_RPC_URL'] ?? "",
          symbol: "BNB",
          currency: "BNB",
          logo: "assets/images/bnb.png",
          nameSpace: "eip155",
          chainId: 97,
          priceId: "binancecoin",
          apiKey: dotenv.env['BINANCE_SMART_CHAIN_BSCSCAN_API_KEY'] ?? "",
          isMainnet: true,
          addressViewUrl: "https://testnet.bscscan.com/address/",
          transactionViewUrl: "https://testnet.bscscan.com/tx/",
          dotColor: Colors.orange,
          etherscanApiBaseUrl: "https://api-testnet.bscscan.com/"),
      Network(
          networkName: "Polygon Amoy Testnet",
          url: dotenv.env['POLYGON_TESTNET_AMOY_RPC_URL'] ?? "",
          symbol: "MATIC",
          currency: "MATIC",
          logo: "assets/images/polygon.png",
          nameSpace: "eip155",
          chainId: 80002,
          priceId: "matic-network",
          apiKey: dotenv.env['POLYGON_POLYSCAN_API_KEY'] ?? "",
          isMainnet: false,
          addressViewUrl: "https://amoy.polygonscan.com/address/",
          transactionViewUrl: "https://amoy.polygonscan.com/tx/",
          dotColor: const Color(0xff8247e5),
          etherscanApiBaseUrl: "https://api-amoy.polygonscan.com/"),
    ];
  }
}
