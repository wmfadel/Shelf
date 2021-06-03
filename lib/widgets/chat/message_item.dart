import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat_user.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/chat/bubble_item.dart';
import 'package:shelf/widgets/chat/location_bubble.dart';

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
          if (message.photo != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  message.photo!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            message.location != null
                ? LocationBubble(
                    location: message.location!,
                    isFromThisUser: isFromThisUser())
                : BubbleItem(
                    text: message.text!,
                    isFromThisUser: isFromThisUser(),
                  )
        ],
      ),
    );
  }

  bool isFromThisUser() {
    return authProvider.uid == message.user;
  }
}
