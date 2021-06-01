import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/models/chat_user.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/widgets/chat/chat_room_list_builder.dart';
import 'package:shelf/widgets/social_content/user_info.dart';

class ChatRoomPage extends StatelessWidget {
  static final String routeName = 'ChatRoom_page';
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments! as Map<String, dynamic>;

    ChatUser otherUser = ChatUser.otherUser(arguments);
    ChatUser currentUser = ChatUser.user(arguments);
    String? chatID;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 8, bottom: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios)),
                Expanded(
                  child: UserInfo(
                    userID: otherUser.id,
                    name: otherUser.name,
                    email: otherUser.email,
                    photo: otherUser.photo,
                    large: true,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ChatRoomListBuilder(
              otherUser: otherUser,
              currentUser: currentUser,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: messageController,
                        maxLines: 2,
                        minLines: 1,
                        autocorrect: true,
                        scrollPadding: EdgeInsets.all(5),
                        decoration: InputDecoration(
                          hintText: 'type your message',
                          enabledBorder: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        )),
                  ),
                  IconButton(
                    onPressed: () async {
                      Message message = Message(
                        time: Timestamp.now(),
                        user: currentUser.id,
                        text: messageController.text.trim(),
                      );
                      if (chatID == null) {
                        print('111111111111');
                        QuerySnapshot userChats = await FirebaseFirestore
                            .instance
                            .collection('chats')
                            .where('users', arrayContains: currentUser.id)
                            .get();

                        for (QueryDocumentSnapshot chatDoc in userChats.docs) {
                          // get the chat from list
                          Chat temp = Chat.fromJson(chatDoc.data()!);
                          if (temp.users.contains(otherUser.id)) {
                            chatID = chatDoc.id;
                            print('got chat id $chatID');
                            break;
                          }
                        }
                      }
                      print('222222222222222');
                      print('chat id $chatID');
                      FirebaseFirestore.instance
                          .collection('chats')
                          .doc(chatID)
                          .collection('messages')
                          .add(message.toJson());
                      print('sent message to $chatID');
                      messageController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
