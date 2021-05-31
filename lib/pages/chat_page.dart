import 'package:flutter/material.dart';
import 'package:shelf/widgets/chat/chats_list_builder.dart';

class ChatPage extends StatelessWidget {
  static final String routeName = 'Chat_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 5, bottom: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios)),
                Text(
                  'Chats',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: ChatsListBuilder()),
        ],
      ),
    );
  }
}
