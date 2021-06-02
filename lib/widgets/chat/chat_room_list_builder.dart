import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/models/chat_user.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/providers/chat_provide.dart';
import 'package:shelf/widgets/chat/messages_list.dart';

class ChatRoomListBuilder extends StatelessWidget {
  final ChatUser otherUser, currentUser;

  ChatRoomListBuilder({
    required this.otherUser,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Chat>(
      future: Provider.of<ChatProvider>(context).getChatWithUser(otherUser.id),
      builder: (BuildContext context, AsyncSnapshot<Chat> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        return StreamBuilder<List<Message>>(
          stream: chatSnapshot.data!.messeges,
          builder:
              (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(child: Text('Error getting this chat messeges'));
            if (!snapshot.hasData || snapshot.data!.isEmpty)
              return Center(
                  child:
                      Text('You have no messeges with ${otherUser.name} yet'));

            return MesssagesList(
                messages: snapshot.data!, otherUser: otherUser);
          },
        );
      },
    );
  }
}
