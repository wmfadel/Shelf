import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/pages/chat_room_page.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/shimmer_items/shmr_shelf_item_user.dart';

class ChatRoomListItem extends StatelessWidget {
  final Chat chat;
  ChatRoomListItem(this.chat);
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    String otherUserID =
        chat.users.firstWhere((element) => element != authProvider.uid);
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(otherUserID)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return ShmrShelfItemUser();
          return ListTile(
            onTap: () async {
              Navigator.of(context)
                  .pushNamed(ChatRoomPage.routeName, arguments: {
                'oUser': otherUserID,
                'oName': snapshot.data!.get('name'),
                'oEmail': snapshot.data!.get('email'),
                'oPhoto': snapshot.data!.get('photo'),
                'user': authProvider.uid,
                'name': authProvider.name,
                'email': authProvider.email,
                'photo': authProvider.photo,
              });
            },
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(snapshot.data!.get('photo')),
            ),
            title: Text(
              snapshot.data!.get('name'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          );
        });
  }
}
