import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                    onPressed: () => imageButtonAction(context),
                    icon: Icon(
                      Icons.image,
                      size: 30,
                    ),
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

  imageButtonAction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 10,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.photo_camera,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text('Camera'),
                  onTap: () => getImage(ImageSource.gallery, context),
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () => getImage(ImageSource.gallery, context),
                  title: Text('Gallery'),
                ),
                SizedBox(height: 10)
              ],
            ),
          );
        });
  }

  getImage(ImageSource imageSource, BuildContext context) async {
    final _picker = ImagePicker();
    Navigator.of(context).pop();
    PickedFile? pickedFile = await _picker.getImage(source: imageSource);
    if (pickedFile == null) return;

    String url = await frankUploadFile(pickedFile.path);
    sendMessage(
        Message(time: Timestamp.now(), user: currentUser.id, photo: url));
    Navigator.of(context).pop();
  }

  Future<String> frankUploadFile(String image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('photos/${DateTime.now()}');
    UploadTask uploadTask = storageReference.putFile(File(image));
    await uploadTask.whenComplete(() {});
    String url = await storageReference.getDownloadURL();
    return url;
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
