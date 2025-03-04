import 'package:cryptomask_admin/core/core.dart';
import 'package:cryptomask_admin/core/message_engine.dart';
import 'package:cryptomask_admin/l10n/transalation.dart';
import 'package:cryptomask_admin/service/remote/remote_service.dart';
import 'package:cryptomask_admin/ui/shared/dot.dart';
import 'package:cryptomask_admin/ui/shared/wallet_text.dart';
import 'package:cryptomask_admin/ui/user_detail_screen.dart';
import 'package:cryptomask_admin/utilities/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:provider/provider.dart';
import 'package:routerino/routerino.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    fetchUsers();
    final messageEngine = MessageEngine.getMessageEngine(context);
    messageEngine.setToken(Core.getAuthToken(context));
    messageEngine.setToken(Core.getAuthToken(context));
    messageEngine.connect();
  }

  fetchUsers() async {
    final users = await RemoteService.getUser(Core.getAuthToken(context));
    if (!mounted) return;
    Core.getCore(context).updateUserList(users);
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Core>(context).users;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
          centerTitle: true,
        ),
        body: users.isEmpty
            ? const Center(
                child: WalletText(localizeKey: 'noUsersFound'),
              )
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    onTap: () => context.push(
                      () => UserDetailScreen(
                        user: user,
                      ),
                    ),
                    trailing: Dot(
                        color: user.isDeactivated
                            ? Colors.red
                            : user.isTransactionBlocked
                                ? Colors.orange
                                : Colors.green),
                    leading: Jazzicon.getIconWidget(
                      Jazzicon.getJazziconData(
                        40,
                        address: user.address,
                      ),
                    ),
                    subtitle: WalletText(
                      localizeKey:
                          "${user.subAddress.length} ${getText(context, key: "moreAddressAvailble")}",
                      size: 12,
                    ),
                    title: WalletText(
                      localizeKey: showEllipse(user.address),
                      size: 14,
                    ),
                  );
                },
              ));
  }
}
