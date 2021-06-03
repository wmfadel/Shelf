import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/chat.dart';
import 'package:shelf/models/market_book.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/providers/chat_provide.dart';

class ChatMarketListItem extends StatelessWidget {
  final MarketBook book;
  final bool isInChat;
  const ChatMarketListItem({
    Key? key,
    required this.book,
    this.isInChat = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      height: 150,
      width: 280,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isInChat ? Colors.grey[100] : Colors.white),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            child: Image.network(
              book.thumbnail!,
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    book.title!,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: book.authors!
                        .map(
                          (e) => Text(
                            e,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                        .take(2)
                        .toList(),
                  ),
                  SizedBox(height: 4),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: isInChat
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (book.price == 0)
                          Container(
                            width: 60,
                            height: 30,
                            child: Center(
                              child: Text(
                                'Free',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5)),
                          )
                        else
                          Text('${book.price} EGP'),
                        SizedBox(width: 10),
                        if (!isInChat)
                          MaterialButton(
                            onPressed: () async {
                              Chat chat = await Provider.of<ChatProvider>(
                                      context,
                                      listen: false)
                                  .getChatWithUser(book.userId!);
                              FirebaseFirestore.instance
                                  .collection('chats')
                                  .doc(chat.id)
                                  .collection('messages')
                                  .add(Message(
                                          time: Timestamp.now(),
                                          user: book.userId!,
                                          marketBook: book.marketID)
                                      .toJson());
                            },
                            minWidth: 80,
                            color: Theme.of(context).primaryColor,
                            disabledColor: Colors.grey.shade400,
                            disabledTextColor: Colors.white,
                            textColor: Colors.white,
                            height: 30,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text('Ask'),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
