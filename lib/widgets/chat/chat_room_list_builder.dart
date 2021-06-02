import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/models/chat_user.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/widgets/chat/messages_list.dart';

class ChatRoomListBuilder extends StatelessWidget {
  final ChatUser otherUser, currentUser;

  ChatRoomListBuilder({
    required this.otherUser,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('chats')
          .where('users', arrayContains: currentUser.id)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        String? chatID;

        if (chatID == null) {
          print('111111111111');

          for (QueryDocumentSnapshot chatDoc in futureSnapshot.data!.docs) {
            // get the chat from list
            Chat temp = Chat.fromJson(chatDoc.data()!, chatDoc.id);
            if (temp.users.contains(otherUser.id)) {
              print(temp.users.toString());
              chatID = chatDoc.id;
              print('got chat id $chatID');
              break;
            }
          }
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .doc(chatID)
              .collection('messages')
              .orderBy('time', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(child: Text('Error getting this chat messeges'));
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
              return Center(
                  child:
                      Text('You have no messeges with ${otherUser.name} yet'));

            List<Message> messages = [];
            for (QueryDocumentSnapshot message in snapshot.data!.docs) {
              messages.add(Message.fromJson(message.data()!));
            }
            return MesssagesList(messages: messages, otherUser: otherUser);
          },
        );
      },
    );
  }
}
