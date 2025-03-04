import 'package:cryptomask_admin/service/remote/model/message.dart';
import 'package:cryptomask_admin/service/socket/socket_service.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageEngine extends ChangeNotifier {
  final SocketService _socketService = SocketService();
  List<Message> conversationList;
  List<ChatMessage> messages;

  MessageEngine({required this.conversationList, required this.messages}) {
    _socketService.updateConversationList = updateConversationList;
    _socketService.updateMessages = updateMessages;
  }

  updateConversationList(List<Message> conversationList) {
    this.conversationList = conversationList;
    notifyListeners();
  }

  setToken(String token) {
    _socketService.token = token;
  }

  updateMessages(List<ChatMessage> messages) {
    this.messages = messages;
    notifyListeners();
  }

  connect() {
    _socketService.connect();
  }

  sendMessage(String message) {
    _socketService.sendMessage(message);
  }

  getChatFor(int id) {
    updateMessages([]);
    _socketService.getChatsByForId(id);
  }

  markAsChatRead() {
    _socketService.markAsChatRead();
  }

  sendMessageWithAttachment(String message, Media attachment) {
    _socketService.sendMessageWithAttachment(message, attachment);
  }

  static MessageEngine getMessageEngine(BuildContext context,
      {bool listen = false}) {
    return Provider.of<MessageEngine>(context, listen: listen);
  }

  SocketService get socketService => _socketService;
}
