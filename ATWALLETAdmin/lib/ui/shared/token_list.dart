import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptomask_admin/constant.dart';
import 'package:cryptomask_admin/core/core.dart';
import 'package:cryptomask_admin/service/remote/remote_service.dart';
import 'package:cryptomask_admin/service/remote/model/token.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text.dart';
import 'package:flutter/material.dart';
import 'package:jazzicon/jazzicon.dart';

// ignore: must_be_immutable
class TokenList extends StatefulWidget {
  const TokenList(
      {super.key, required this.selectedAddress, required this.selectedChain});
  final String selectedAddress;
  final int selectedChain;

  @override
  State<TokenList> createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {
  List<Token> tokens = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  fetchToken() async {
    setState(() {
      loading = true;
    });
    tokens = await RemoteService.getWalletHoldings(Core.getAuthToken(context),
        widget.selectedAddress, widget.selectedChain);
    if (context.mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TokenList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedAddress != widget.selectedAddress ||
        oldWidget.selectedChain != widget.selectedChain) {
      fetchToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : tokens.isEmpty
              ? Center(
                  child: Text(
                    "Selected address don't have any token holdings in ${getNetwork(widget.selectedChain)?.networkName}",
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: tokens.length,
                  itemBuilder: (context, index) {
                    final token = tokens[index];
                    return ListTile(
                      leading: token.token.logo != null
                          ? CachedNetworkImage(
                              imageUrl: token.token.logo!,
                              width: 30,
                              height: 30,
                            )
                          : Jazzicon.getIconWidget(
                              Jazzicon.getJazziconData(
                                30,
                                address: token.token.contractAddress,
                              ),
                            ),
                      title: WalletText(
                        localizeKey: token.token.name,
                        size: 14,
                      ),
                      subtitle: WalletText(
                        localizeKey:
                            "${double.parse(token.value).toStringAsFixed(5)} ${token.token.symbol}",
                        size: 14,
                      ),
                      trailing: WalletText(
                        localizeKey:
                            "\$${token.token.fiatValue.toStringAsPrecision(5)}",
                      ),
                    );
                  }),
    );
  }
}
