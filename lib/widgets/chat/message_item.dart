import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat_user.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/providers/auth_provider.dart';

class MessageItem extends StatelessWidget {
  late final Message message;
  late final ChatUser otherUser;
  late AuthProvider authProvider;

  MessageItem({required this.message, required this.otherUser});
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool shouldRevere = isFromThisUser();

    List<Widget> items = [
      CircleAvatar(
        backgroundImage: NetworkImage(
          isFromThisUser() ? authProvider.photo! : otherUser.photo,
        ),
      ),
      Container(
        child: Column(
          children: [
            Text(
              message.text!,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        margin: EdgeInsets.only(
          left: isFromThisUser() ? 20 : 5,
          right: isFromThisUser() ? 5 : 20,
        ),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isFromThisUser()
              ? Theme.of(context).primaryColor.withOpacity(0.75)
              : Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topLeft: isFromThisUser() ? Radius.circular(8) : Radius.zero,
            topRight: isFromThisUser() ? Radius.zero : Radius.circular(8),
            bottomLeft: isFromThisUser() ? Radius.circular(8) : Radius.zero,
            bottomRight: isFromThisUser() ? Radius.zero : Radius.circular(8),
          ),
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isFromThisUser() ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: shouldRevere ? items.reversed.toList() : items,
      ),
    );
  }

  bool isFromThisUser() {
    return authProvider.uid == message.user;
  }
}
