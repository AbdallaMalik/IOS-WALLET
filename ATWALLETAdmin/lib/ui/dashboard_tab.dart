// ignore_for_file: must_be_immutable

import 'package:cryptomask_admin/constant.dart';
import 'package:cryptomask_admin/service/remote/model/app_settings_response.dart';
import 'package:cryptomask_admin/ui/shared/token_list.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text.dart';
import 'package:cryptomask_admin/utilities/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jazzicon/jazzicon.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({
    super.key,
  });

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab>
    with SingleTickerProviderStateMixin {
  int selectedChain = 1;
  final appSettings = Get.find<AppSettings>();

  onCopyAddressHandler(String address) async {
    await copyToClipboard(address);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: WalletText(
          localizeKey: 'addressCopied',
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Admin Earnings"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: WalletText(
                    localizeKey: showEllipse(appSettings.adminAddress),
                  ),
                  trailing: IconButton(
                      onPressed: () =>
                          onCopyAddressHandler(appSettings.adminAddress),
                      icon: const Icon(Icons.copy)),
                  leading: Hero(
                    tag: 'avatar',
                    child: Jazzicon.getIconWidget(
                      Jazzicon.getJazziconData(
                        40,
                        address: appSettings.adminAddress,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonHideUnderline(
                    child: DropdownButton(
                  padding: const EdgeInsets.all(0),
                  elevation: 1,
                  value: selectedChain,
                  items: networks
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.chainId,
                          child: Text(e.networkName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedChain = value ?? 1;
                    });
                  },
                )),
                const SizedBox(
                  height: 10,
                ),
                TokenList(
                    selectedAddress: appSettings.adminAddress,
                    selectedChain: selectedChain)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
