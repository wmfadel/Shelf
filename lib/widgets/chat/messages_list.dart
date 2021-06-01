import 'package:flutter/material.dart';
import 'package:shelf/models/chat_user.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/widgets/chat/message_item.dart';

class MesssagesList extends StatelessWidget {
  late final List<Message> messages;
  late final ChatUser otherUser;
  MesssagesList({required this.messages, required this.otherUser});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (context, index) {
        return MessageItem(message: messages[index], otherUser: otherUser);
      },
    );
  }
}
