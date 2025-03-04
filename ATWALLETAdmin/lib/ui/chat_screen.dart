// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:cryptomask_admin/constant.dart';
import 'package:cryptomask_admin/core/core.dart';
import 'package:cryptomask_admin/core/message_engine.dart';
import 'package:cryptomask_admin/service/remote/remote_service.dart';
import 'package:cryptomask_admin/service/remote/model/user.dart';
import 'package:cryptomask_admin/ui/shared/wallet_button.dart';
import 'package:cryptomask_admin/ui/user_detail_screen.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:provider/provider.dart';
import 'package:routerino/routerino.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final int forId;
  final User user;
  final Function(String message) onSendMessage;
  const ChatScreen(
      {super.key,
      required this.onSendMessage,
      required this.forId,
      required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatUser user = ChatUser(
    id: "admin",
    firstName: "Admin",
  );

  List<ChatMessage> messages = <ChatMessage>[];

  @override
  void initState() {
    super.initState();
    final messageEngine = MessageEngine.getMessageEngine(context);
    messageEngine.getChatFor(widget.forId);
    messageEngine.markAsChatRead();
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      if (context.mounted) {
        showSendFileConfirmation(
          name: result.files.single.name,
          onSend: (message) async {
            final media = await RemoteService.uploadFile(
                Core.getAuthToken(context), file, result.files.single.name);
            if (media != null) {
              if (!mounted) return;
              await MessageEngine.getMessageEngine(context)
                  .sendMessageWithAttachment(message, media);
              if (!mounted) return;
              context.pop();
            }
          },
        );
      }
    }
  }

  showSendFileConfirmation(
      {required String name, required Function(String message) onSend}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text("Confirmation"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Do yo want to send a file to admin ?",
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                  color: kPrimaryColor.withAlpha(70),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Icon(Icons.attach_file),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: WalletButton(
                    onPressed: () => context.pop(),
                    localizeKey: 'cancel',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: WalletButton(
                    type: WalletButtonType.filled,
                    onPressed: () => onSend(""),
                    localizeKey: 'send',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onMediaPressHandler(ChatMedia media) {
    launchUrl(Uri.parse(media.url),
        mode: LaunchMode.externalApplication,
        webViewConfiguration: WebViewConfiguration(headers: {
          'Authorization': 'Bearer ${Core.getAuthToken(context)}'
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () =>
                  context.push(() => UserDetailScreen(user: widget.user)),
              child: Hero(
                tag: 'avatar',
                child: Jazzicon.getIconWidget(
                    Jazzicon.getJazziconData(30, address: widget.user.address)),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                widget.user.address,
                maxLines: 2,
                // overflow: TextOverflow.clip,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      body: DashChat(
        inputOptions: InputOptions(
          alwaysShowSend: true,
          textCapitalization: TextCapitalization.sentences,
          sendButtonBuilder: (send) => Row(
            children: [
              IconButton(
                  onPressed: pickFile, icon: const Icon(Icons.attach_file)),
              IconButton(onPressed: send, icon: const Icon(Icons.send)),
            ],
          ),
        ),
        messageListOptions: const MessageListOptions(),
        currentUser: user,
        messageOptions:
            MessageOptions(showTime: true, onTapMedia: onMediaPressHandler),
        onSend: (ChatMessage message) {
          widget.onSendMessage(message.text);
        },
        messages: Provider.of<MessageEngine>(context).messages,
      ),
    );
  }
}
