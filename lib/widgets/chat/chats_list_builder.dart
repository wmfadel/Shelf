import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/chat/chat_room_list_item.dart';

class ChatsListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('users', arrayContains: authProvider.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          List<Chat> chats = [];
          if (snapshot.data!.docs.isNotEmpty)
            for (QueryDocumentSnapshot chat in snapshot.data!.docs) {
              chats.add(Chat.fromJson(chat.data()!));
            }
          if (chats.isEmpty)
            return Center(child: Text('You have no chats with other users'));
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatRoomListItem(chats[index]);
            },
          );
        });
  }
}
