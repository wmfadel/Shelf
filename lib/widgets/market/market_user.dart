import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/pages/chat_room_page.dart';
import 'package:shelf/pages/profile_page.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/chat_provide.dart';

class MarketUser extends StatelessWidget {
  final String id, name, photo, email;

  MarketUser({
    required this.id,
    required this.name,
    required this.photo,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(ProfilePage.routeName, arguments: id),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(photo),
              radius: 25,
            ),
            SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            FutureBuilder<Chat>(
                future: Provider.of<ChatProvider>(context).getChatWithUser(id),
                builder: (BuildContext context, AsyncSnapshot<Chat> snapshot) {
                  return ElevatedButton(
                    onPressed: snapshot.connectionState ==
                            ConnectionState.waiting
                        ? null
                        : () async {
                            // find chat with the other user
                            Navigator.of(context)
                                .pushNamed(ChatRoomPage.routeName, arguments: {
                              'oUser': id,
                              'oName': name,
                              'oEmail': email,
                              'oPhoto': photo,
                              'user': authProvider.uid,
                              'name': authProvider.name,
                              'email': authProvider.email,
                              'photo': authProvider.photo,
                            });
                          },
                    child: Text('Buy'),
                  );
                })
          ],
        ),
      ),
    );
  }
}
