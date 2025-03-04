import 'package:cryptomask_admin/constant.dart';
import 'package:cryptomask_admin/core/core.dart';
import 'package:cryptomask_admin/core/message_engine.dart';
import 'package:cryptomask_admin/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:routerino/routerino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Core(users: []),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              MessageEngine(messages: [], conversationList: []),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
          useMaterial3: true,
        ),
        home: RouterinoHome(
          builder: () => const LoginScreen(),
        ),
      ),
    );
  }
}
