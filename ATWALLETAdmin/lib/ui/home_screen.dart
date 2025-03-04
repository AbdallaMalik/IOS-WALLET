import 'package:cryptomask_admin/ui/app_settings_screen.dart';
import 'package:cryptomask_admin/ui/converation_list_screen.dart';
import 'package:cryptomask_admin/ui/dashboard_tab.dart';
import 'package:cryptomask_admin/ui/users_list_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: IndexedStack(
            index: index,
            children: const [
              DashboardTab(),
              UserListScreen(),
              ConversationListScreen(),
              AppSettingsScreen(),
            ],
          )),
          BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              currentIndex: index,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dashboard,
                  ),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people_sharp), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message), label: 'Messages'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ])
        ],
      ),
    );
  }
}
