// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:cryptomask_admin/config.dart';
import 'package:cryptomask_admin/service/remote/model/message.dart';
import 'package:cryptomask_admin/utilities/text_utils.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket;

class SocketEvent {
  static String update_admin = "update_admin";
  static String private_message = "private_message";
  static String admin_get_conversations = "admin_get_conversations";
  static String admin_get_chat = "admin_get_chat";
  static String admin_mark_chat_read = "admin_mark_chat_read";
}

class SocketService {
  Function(List<Message>)? updateConversationList;
  Function(List<ChatMessage>)? updateMessages;
  String? token;
  socket.Socket? _socket;
  StreamController<String>? messageController;
  int? forId;

  void connect() {
    _socket = socket.io(
        baseApiUrl,
        socket.OptionBuilder()
            .setExtraHeaders({'authorization': token})
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());

    if (!_socket!.connected) {
      _socket?.connect();
    }

    _socket?.onConnect((_) {
      _socket?.emit(SocketEvent.update_admin);
    });

    _socket?.on(SocketEvent.private_message, (data) {
      getConversationList();
      if (forId != null) {
        getChatsByForId(forId!);
      }
    });

    _socket?.on(SocketEvent.admin_get_conversations, (data) {
      List<Message> conversations = [];
      for (String key in data.keys) {
        final value = data[key];
        conversations.add(Message.fromJson(value));
      }
      updateConversationList?.call([...conversations]);
    });

    _socket?.on(SocketEvent.admin_mark_chat_read, (_) {
      getConversationList();
    });

    _socket?.on(SocketEvent.admin_get_chat, (data) {
      List<ChatMessage> chats = [];
      for (dynamic chat in data) {
        final message = Message.fromJson(chat);
        chats.add(
          ChatMessage(
            text: message.message,
            status: MessageStatus.received,
            medias: message.attachment != null
                ? [
                    ChatMedia(
                      url: message.attachment!.url,
                      fileName: message.attachment!.fileName,
                      type: MediaType.parse(message.attachment!.mediaType),
                    )
                  ]
                : null,
            user: ChatUser(
                firstName: message.isAdminMessage
                    ? "Admin"
                    : showEllipse(message.user.address),
                id: message.isAdminMessage ? "admin" : message.user.address),
            createdAt: message.timestamp,
          ),
        );
      }
      updateMessages?.call([...chats]);
    });

    _socket?.onDisconnect((_) {});
  }

  void getConversationList() {
    _socket?.emit(SocketEvent.admin_get_conversations);
  }

  void getChatsByForId(int forId) {
    this.forId = forId;
    _socket?.emit(SocketEvent.admin_get_chat, forId);
  }

  void sendMessage(String message) {
    final messageTemplate = {
      "timestamp": DateTime.now().toString(),
      "message": message,
      "forId": forId,
    };
    _socket?.emit(SocketEvent.private_message, messageTemplate);
  }

  void markAsChatRead() {
    _socket?.emit(SocketEvent.admin_mark_chat_read, forId);
  }

  void sendMessageWithAttachment(String message, Media media) {
    final messageTemplate = {
      "timestamp": DateTime.now().toString(),
      "message": message,
      "attachment": media.toJson(),
      "forId": forId,
    };
    _socket?.emit(SocketEvent.private_message, messageTemplate);
  }

  void dispose() {
    _socket?.disconnect();
    _socket?.close();
    messageController?.close();
  }
}
