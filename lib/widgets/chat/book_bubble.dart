import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/message.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/market_provider.dart';
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: currentUSerID == message.user
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          ChatMarketListItem(
            book: Provider.of<MarketProvider>(context, listen: false)
                .getBookByID(message.marketBook!),
            isInChat: true,
          ),
        ],
      ),
    );
  }
}
