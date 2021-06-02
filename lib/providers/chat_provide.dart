import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shelf/models/chat.dart';

class ChatProvider with ChangeNotifier {
  BehaviorSubject<List<Chat>> _chatSubject = BehaviorSubject<List<Chat>>();
  late final String userID;
  Stream<List<Chat>> get chatStream => _chatSubject.stream;

  getUserChats(String userID) async {
    print('CHATPROVIDER: getting user chats');
    this.userID = userID;
    Stream<QuerySnapshot> userChatsStream = FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: userID)
        .snapshots();
    List<Chat> chats = [];
    userChatsStream.listen((QuerySnapshot event) {
      for (QueryDocumentSnapshot chatDoc in event.docs) {
        chats.add(Chat.fromJson(chatDoc.data()!, chatDoc.id));
      }
      _chatSubject.sink.add(chats);
      print(
          'CHATPROVIDER: chats we have in the provider ${_chatSubject.value.length}');
    });
  } // end getUserChats

  Future<Chat> getChatWithUser(String otherUserID) async {
    for (Chat c in _chatSubject.value) {
      if (c.users.contains(otherUserID)) return c;
    }

    // create chat
    Timestamp timeCreated = Timestamp.now();
    DocumentReference doc =
        await FirebaseFirestore.instance.collection('chats').add({
      'date': timeCreated,
      'users': [otherUserID, userID],
    });
    DocumentSnapshot docSnapshot = await doc.get();
    return Chat.fromJson(docSnapshot.data()!, docSnapshot.id);
  }
}
