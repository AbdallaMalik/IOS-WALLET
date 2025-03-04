import 'package:cryptomask_admin/constant.dart';
import 'package:cryptomask_admin/core/core.dart';
import 'package:cryptomask_admin/service/remote/model/app_settings_response.dart';
import 'package:cryptomask_admin/service/remote/remote_service.dart';
import 'package:cryptomask_admin/ui/shared/wallet_button.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text_field.dart';
import 'package:cryptomask_admin/utilities/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  final appSettings = Get.find<AppSettings>();
  final tcController = TextEditingController();
  final ppController = TextEditingController();
  final helpController = TextEditingController();
  final aboutController = TextEditingController();
  final adminFeeController = TextEditingController();
  final adminAddressController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    tcController.text = appSettings.termsAndConditionUrl;
    ppController.text = appSettings.privacyPolicyUrl;
    helpController.text = appSettings.helpUrl;
    aboutController.text = appSettings.aboutUs;
    adminFeeController.text = appSettings.fee.toString();
    adminAddressController.text = appSettings.adminAddress;
    super.initState();
  }

  onUpdate() async {
    setState(() {
      isLoading = true;
    });
    final modifiedappSettings = AppSettings(
        id: appSettings.id,
        helpUrl: helpController.text,
        privacyPolicyUrl: ppController.text,
        termsAndConditionUrl: tcController.text,
        aboutUs: aboutController.text,
        fee: double.parse(adminFeeController.text),
        adminAddress: adminAddressController.text);
    final updatedAppSettings = await RemoteService.updateAppSettings(
        Core.getAuthToken(context), modifiedappSettings);
    Get.delete<AppSettings>();
    Get.put(updatedAppSettings.data);
    if (context.mounted) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: WalletText(
            localizeKey: 'settingsUpdated',
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const WalletText(
          localizeKey: 'walletSettings',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              addHeight(SpacingSize.s),
              WalletTextField(
                textEditingController: tcController,
                textFieldType: TextFieldType.input,
                labelLocalizeKey: 'terms',
              ),
              addHeight(SpacingSize.s),
              WalletTextField(
                textEditingController: ppController,
                textFieldType: TextFieldType.input,
                labelLocalizeKey: 'pp',
              ),
              addHeight(SpacingSize.s),
              WalletTextField(
                textEditingController: helpController,
                textFieldType: TextFieldType.input,
                labelLocalizeKey: 'help',
              ),
              addHeight(SpacingSize.s),
              WalletTextField(
                textEditingController: aboutController,
                textFieldType: TextFieldType.input,
                labelLocalizeKey: 'aboutUrl',
              ),
              addHeight(SpacingSize.s),
              WalletTextField(
                textEditingController: adminFeeController,
                textFieldType: TextFieldType.input,
                labelLocalizeKey: 'adminFee',
              ),
              addHeight(SpacingSize.s),
              WalletTextField(
                textEditingController: adminAddressController,
                textFieldType: TextFieldType.input,
                labelLocalizeKey: 'feeWallet',
              ),
              addHeight(SpacingSize.s),
              !isLoading
                  ? WalletButton(
                      type: WalletButtonType.filled,
                      onPressed: onUpdate,
                      localizeKey: 'update',
                    )
                  : const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    ),
              addHeight(SpacingSize.l),
            ],
          ),
        ),
      ),
    );
  }
}
