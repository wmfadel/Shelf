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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            isFromThisUser() ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              child: Text(
                message.text!,
                style: TextStyle(color: Colors.white),
              ),
              margin: EdgeInsets.only(
                left: isFromThisUser() ? 50 : 5,
                right: isFromThisUser() ? 5 : 50,
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isFromThisUser()
                    ? Theme.of(context).primaryColor.withOpacity(0.75)
                    : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: isFromThisUser() ? Radius.circular(8) : Radius.zero,
                  topRight: isFromThisUser() ? Radius.zero : Radius.circular(8),
                  bottomLeft:
                      isFromThisUser() ? Radius.circular(8) : Radius.zero,
                  bottomRight:
                      isFromThisUser() ? Radius.zero : Radius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isFromThisUser() {
    return authProvider.uid == message.user;
  }
}
