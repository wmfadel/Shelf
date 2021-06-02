import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat_user.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/chat/bubble_item.dart';

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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (message.text != null)
                Flexible(
                  child: BubbleItem(
                      text: message.text!, isFromThisUser: isFromThisUser()),
                ),
              if (message.photo != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      message.photo!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              if (message.location != null)
                BubbleItem(
                  text:
                      '${message.location!.latitude},${message.location!.longitude}',
                  isFromThisUser: isFromThisUser(),
                  isLocation: true,
                ),
            ],
          ),
        ],
      ),
    );
  }

  bool isFromThisUser() {
    return authProvider.uid == message.user;
  }
}
