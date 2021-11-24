import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/models/message.dart';

class ChatProvider with ChangeNotifier {
  // ignore: close_sinks
  BehaviorSubject<List<Chat>> _chatSubject = BehaviorSubject<List<Chat>>();
  late final String userID;
  Stream<List<Chat>> get chatStream => _chatSubject.stream;

  getUserChats(String userID) async {
    this.userID = userID;
    Stream<QuerySnapshot> userChatsStream = FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: userID)
        .snapshots();
    List<Chat> chats = [];
    userChatsStream.listen((QuerySnapshot event) async {
      for (QueryDocumentSnapshot chatDoc in event.docs) {
        Chat temp =
            Chat.fromJson((chatDoc.data() as Map<String, dynamic>), chatDoc.id);
        temp.messeges = await getChatMesseges(temp.id);
        chats.add(temp);
      }
      _chatSubject.sink.add(chats);
    });
  } // end getUserChats

  Future<Stream<List<Message>>> getChatMesseges(String chatID) async {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatID)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();

    return stream.map((qShot) =>
        qShot.docs.map((doc) => Message.fromJson(doc.data())).toList());
  }

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
