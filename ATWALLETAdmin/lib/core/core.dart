import 'package:cryptomask_admin/service/remote/model/user.dart';
import 'package:cryptomask_admin/ui/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Core extends ChangeNotifier {
  String? token;
  List<User> users;

  Core({this.token, required this.users});

  updateToken(String token) {
    this.token = token;
  }

  updateUserList(List<User> users) {
    this.users = users;
    notifyListeners();
  }

  updateUser(int userId, UserAction action) {
    for (var i = 0; i < users.length; i++) {
      final user = users[i];
      if (user.id == userId) {
        if (action == UserAction.block) {
          user.isTransactionBlocked = true;
        }
        if (action == UserAction.unblock) {
          user.isTransactionBlocked = false;
        }
        if (action == UserAction.deactivate) {
          user.isDeactivated = true;
        }
        if (action == UserAction.activate) {
          user.isDeactivated = false;
        }
      }
    }
    notifyListeners();
  }

  static String getAuthToken(BuildContext context) {
    return Provider.of<Core>(context, listen: false).token ?? "";
  }

  static Core getCore(context) {
    return Provider.of<Core>(context, listen: false);
  }
}
