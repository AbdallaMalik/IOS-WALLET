// ignore_for_file: must_be_immutable

import 'package:cryptomask_admin/constant.dart';
import 'package:cryptomask_admin/core/core.dart';
import 'package:cryptomask_admin/service/remote/remote_service.dart';
import 'package:cryptomask_admin/service/remote/model/user.dart';
import 'package:cryptomask_admin/ui/shared/token_list.dart';
import 'package:cryptomask_admin/ui/shared/wallet_button.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text.dart';
import 'package:cryptomask_admin/utilities/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:routerino/routerino.dart';

enum UserAction { block, unblock, deactivate, activate }

class ActionType {
  final UserAction action;
  final String actionText;

  ActionType({required this.action, required this.actionText});
}

class UserDetailScreen extends StatefulWidget {
  User user;
  UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen>
    with SingleTickerProviderStateMixin {
  String? selectedAddress;
  int selectedChain = 137;
  bool loading = false;

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

  Widget getActionButton() {
    if (widget.user.isDeactivated) {
      return WalletButton(
        localizeKey: "activeUser",
        disabled: selectedAddress != null &&
            selectedAddress?.toLowerCase() != widget.user.address.toLowerCase(),
        onPressed: () => manageUserStatus(
            ActionType(action: UserAction.activate, actionText: "Activate")),
      );
    }
    return Column(
      children: [
        !widget.user.isTransactionBlocked
            ? WalletButton(
                disabled: selectedAddress != null &&
                    selectedAddress?.toLowerCase() !=
                        widget.user.address.toLowerCase(),
                localizeKey: "blockTransactions",
                onPressed: () => manageUserStatus(ActionType(
                    action: UserAction.block, actionText: "Block transaction")),
              )
            : WalletButton(
                localizeKey: "unblockTransactions",
                disabled: selectedAddress != null &&
                    selectedAddress?.toLowerCase() !=
                        widget.user.address.toLowerCase(),
                onPressed: () => manageUserStatus(ActionType(
                    action: UserAction.unblock, actionText: "Unblock")),
              ),
        !widget.user.isDeactivated
            ? WalletButton(
                disabled: selectedAddress != null &&
                    selectedAddress?.toLowerCase() !=
                        widget.user.address.toLowerCase(),
                localizeKey: "deactivateUser",
                onPressed: () => manageUserStatus(ActionType(
                    action: UserAction.deactivate, actionText: "Deactivate")),
              )
            : const SizedBox()
      ],
    );
  }

  manageUserStatus(ActionType actionType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Are you surely want to ${actionType.actionText.toLowerCase()} this user?",
        ),
        actions: [
          WalletButton(
            fullWidth: true,
            type: WalletButtonType.filled,
            onPressed: () async {
              switch (actionType.action) {
                case UserAction.block:
                  setState(() {
                    loading = true;
                  });
                  await RemoteService.block(
                      Core.getAuthToken(context), widget.user.id);
                  if (context.mounted) {
                    Core.getCore(context)
                        .updateUser(widget.user.id, actionType.action);
                    context.pop();
                  }
                  setState(() {
                    loading = false;
                  });
                  return;
                case UserAction.unblock:
                  setState(() {
                    loading = true;
                  });
                  await RemoteService.unblock(
                      Core.getAuthToken(context), widget.user.id);
                  if (context.mounted) {
                    Core.getCore(context)
                        .updateUser(widget.user.id, actionType.action);
                    context.pop();
                  }
                  setState(() {
                    loading = false;
                  });
                  return;
                case UserAction.deactivate:
                  setState(() {
                    loading = true;
                  });
                  await RemoteService.deactivateUser(
                      Core.getAuthToken(context), widget.user.id);
                  if (context.mounted) {
                    Core.getCore(context)
                        .updateUser(widget.user.id, actionType.action);
                    context.pop();
                  }
                  setState(() {
                    loading = false;
                  });
                  return;
                case UserAction.activate:
                  setState(() {
                    loading = true;
                  });
                  await RemoteService.activateUser(
                      Core.getAuthToken(context), widget.user.id);
                  if (context.mounted) {
                    Core.getCore(context)
                        .updateUser(widget.user.id, actionType.action);
                    context.pop();
                  }
                  setState(() {
                    loading = false;
                  });
                  return;
              }
            },
            localizeKey: actionType.actionText,
          ),
          WalletButton(
            onPressed: () {
              context.pop();
            },
            localizeKey: "cancel",
          ),
        ],
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
            title: const Text("User detail"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  trailing: IconButton(
                      onPressed: () =>
                          onCopyAddressHandler(widget.user.address),
                      icon: const Icon(Icons.copy)),
                  leading: Hero(
                    tag: 'avatar',
                    child: Jazzicon.getIconWidget(
                      Jazzicon.getJazziconData(
                        40,
                        address: widget.user.address,
                      ),
                    ),
                  ),
                  subtitle: widget.user.getStatusForDiplay(),
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(
                    padding: const EdgeInsets.all(0),
                    elevation: 1,
                    isExpanded: true,
                    value: selectedAddress ?? widget.user.address,
                    items: [widget.user.address, ...widget.user.subAddress]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (e.toLowerCase() ==
                                      widget.user.address.toLowerCase())
                                    const WalletText(
                                      localizeKey: '#main',
                                      size: 12,
                                    ),
                                  Text(
                                    showEllipse(e),
                                  ),
                                ]),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAddress = value;
                      });
                    },
                  )),
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
                getActionButton(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const WalletText(
                            localizeKey: 'holdings',
                            size: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: kPrimaryColor,
                            height: 3,
                            width: 100,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                TokenList(
                    selectedAddress: selectedAddress ?? widget.user.address,
                    selectedChain: selectedChain)
              ],
            ),
          ),
        ),
        if (loading)
          Material(
            color: Colors.black.withAlpha(100),
            child: Container(
              color: Colors.black.withAlpha(100),
              height: Get.height,
              width: Get.width,
              child: const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            ),
          )
      ],
    );
  }
}
