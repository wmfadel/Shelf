import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/providers/chat_provide.dart';
import 'package:shelf/widgets/chat/chat_room_list_item.dart';

class ChatsListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<ChatProvider>(context).chatStream,
        builder: (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.data!.isEmpty)
            return Center(child: Text('You have no chats with other users'));
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatRoomListItem(snapshot.data![index]);
            },
          );
        });
  }
}
