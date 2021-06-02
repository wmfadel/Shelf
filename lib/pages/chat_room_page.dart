import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/models/chat_user.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/providers/chat_provide.dart';
import 'package:shelf/services/location_service.dart';
import 'package:shelf/widgets/chat/chat_room_list_builder.dart';
import 'package:shelf/widgets/social_content/user_info.dart';

class ChatRoomPage extends StatefulWidget {
  static final String routeName = 'ChatRoom_page';

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController messageController = TextEditingController();
  String? chatID;
  late ChatUser otherUser;
  late ChatUser currentUser;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments! as Map<String, dynamic>;

    otherUser = ChatUser.otherUser(arguments);
    currentUser = ChatUser.user(arguments);

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
                      String? locationString =
                          await LocationService().getUserLocation();
                      print(locationString);
                      GeoPoint geoPoint =
                          LocationService.parseLatLang(locationString!);
                      sendMessage(Message(
                        time: Timestamp.now(),
                        user: currentUser.id,
                        location: geoPoint,
                      ));
                    },
                    icon: Icon(
                      Icons.location_on_outlined,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      sendMessage(Message(
                        time: Timestamp.now(),
                        user: currentUser.id,
                        text: messageController.text.trim(),
                      ));
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

  sendMessage(Message message) async {
    if (chatID == null) {
      Chat temp = await Provider.of<ChatProvider>(context, listen: false)
          .getChatWithUser(otherUser.id);
      chatID = temp.id;
    }
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatID)
        .collection('messages')
        .add(message.toJson());
    print('sent message to $chatID');
    messageController.clear();
  }
}
