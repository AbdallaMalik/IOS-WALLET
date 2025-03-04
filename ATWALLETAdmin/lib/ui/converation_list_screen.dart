import 'dart:async';

import 'package:cryptomask_admin/core/message_engine.dart';
import 'package:cryptomask_admin/ui/chat_screen.dart';
import 'package:cryptomask_admin/utilities/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:jazzicon/jazzicon.dart';
import 'package:provider/provider.dart';
import 'package:routerino/routerino.dart';

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({super.key});

  @override
  State<ConversationListScreen> createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  @override
  void initState() {
    super.initState();
    MessageEngine.getMessageEngine(context).socketService.messageController =
        StreamController<String>();
    MessageEngine.getMessageEngine(context).socketService.getConversationList();
  }

  sendMessage(String message, int forId) {
    MessageEngine.getMessageEngine(context).sendMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: MessageEngine.getMessageEngine(context, listen: true)
              .socketService
              .messageController
              ?.stream,
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount:
                    Provider.of<MessageEngine>(context).conversationList.length,
                itemBuilder: (context, index) {
                  final lastMessage = Provider.of<MessageEngine>(context)
                      .conversationList[index];
                  return ListTile(
                    onTap: () => context.push(() => ChatScreen(
                          user: lastMessage.user,
                          forId: lastMessage.forId,
                          onSendMessage: (message) {
                            sendMessage(message, lastMessage.forId);
                          },
                        )),
                    leading: Jazzicon.getIconWidget(
                      Jazzicon.getJazziconData(30,
                          address: lastMessage.user.address),
                    ),
                    title: Text(
                      showEllipse(lastMessage.user.address),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      lastMessage.message,
                      style: TextStyle(
                          fontWeight:
                              lastMessage.seen ? null : FontWeight.bold),
                    ),
                  );
                });
          }),
    );
  }
}
