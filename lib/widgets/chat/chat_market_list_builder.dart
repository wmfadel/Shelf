import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/market_book.dart';
import 'package:shelf/widgets/chat/chat_market_list_item.dart';

class ChatMarketListBuiler extends StatelessWidget {
  final String otherUserID;
  final String userName;

  const ChatMarketListBuiler({
    Key? key,
    required this.otherUserID,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('market')
          .where('user-id', isEqualTo: otherUserID)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text('Error while fetching user books'));
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
          return Center(child: Text('$userName is not selling book now'));
        List<MarketBook> books = [];
        snapshot.data!.docs.forEach((QueryDocumentSnapshot element) {
          books.add(MarketBook.fromJson(element.data(), marketID: element.id));
        });
        return ListView.builder(
          itemCount: books.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return ChatMarketListItem(
              book: books[index],
            );
          },
        );
      },
    );
  }
}
