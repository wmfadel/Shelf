import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/market_book.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/chat/chat_market_list_item.dart';

class BookBubble extends StatelessWidget {
  final Message message;
  const BookBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentUSerID =
        Provider.of<AuthProvider>(context, listen: false).uid!;
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('market')
          .doc(message.marketBook)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SizedBox(
              height: 150,
              width: 280,
              child: Center(child: CircularProgressIndicator()));
        if (snapshot.hasError || !snapshot.hasData) return Container();
        MarketBook book = MarketBook.fromJson(snapshot.data!.data()!);

        return Row(
          mainAxisAlignment: currentUSerID == message.user
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ChatMarketListItem(
              book: book,
              isInChat: true,
            ),
          ],
        );
      },
    );
  }
}
