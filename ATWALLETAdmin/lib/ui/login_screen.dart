import 'package:cryptomask_admin/core/core.dart';
import 'package:cryptomask_admin/l10n/transalation.dart';
import 'package:cryptomask_admin/service/remote/remote_service.dart';
import 'package:cryptomask_admin/ui/home_screen.dart';
import 'package:cryptomask_admin/ui/shared/wallet_button.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text_field.dart';
import 'package:cryptomask_admin/utilities/spaces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routerino/routerino.dart';

import '../constant.dart';

class LoginScreen extends StatefulWidget {
  static const route = "login_screen_route";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController =
      TextEditingController(text: kDebugMode ? "superuserdemo" : null);
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? "password" : null);
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;

  onLoginHandler() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final token = await RemoteService.login(
            usernameController.text, passwordController.text);
        if (!mounted) return;
        Core.getCore(context).updateToken(token);
        final appSettings = await RemoteService.appSettings(token);
        Get.put(appSettings.data);
        if (!mounted) return;
        context.pushAndRemoveUntil(
          removeUntil: bool,
          builder: () => const HomeScreen(),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              addHeight(SpacingSize.xs),
              const Expanded(child: SizedBox()),
              const Center(
                child: WalletText(
                  localizeKey: 'appName',
                  textVarient: TextVarient.hero,
                ),
              ),
              addHeight(SpacingSize.m),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WalletText(
                    localizeKey: 'welcomeBack',
                    textVarient: TextVarient.hero,
                  ),
                ],
              ),
              addHeight(SpacingSize.m),
              WalletTextField(
                  textEditingController: usernameController,
                  validator: (String? string) {
                    if (string!.isEmpty) {
                      return getText(context, key: 'userNameShouldnBeEmpty');
                    }
                    return null;
                  },
                  textFieldType: TextFieldType.input,
                  labelLocalizeKey: 'username'),
              const SizedBox(
                height: 20,
              ),
              WalletTextField(
                  textEditingController: passwordController,
                  validator: (String? string) {
                    if (string!.isEmpty) {
                      return getText(context, key: 'passwordShouldntBeEmpy');
                    }
                    return null;
                  },
                  textFieldType: TextFieldType.password,
                  labelLocalizeKey: 'password'),
              addHeight(SpacingSize.s),
              const Expanded(child: SizedBox()),
              !isLoading
                  ? WalletButton(
                      onPressed: onLoginHandler,
                      localizeKey: 'login',
                    )
                  : const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
