import 'package:flutter/material.dart';
import 'package:shelf/models/chat_user.dart';
import 'package:shelf/widgets/chat/chat_market_list_builder.dart';

class ChatMarket extends StatefulWidget {
  final ChatUser otherUser;
  const ChatMarket({
    Key? key,
    required this.otherUser,
  }) : super(key: key);

  @override
  _ChatMarketState createState() => _ChatMarketState();
}

class _ChatMarketState extends State<ChatMarket> {
  static final double OPEN_HEIGHT = 200;
  static final double CLOSED_HEIGHT = 50;
  double height = CLOSED_HEIGHT;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 200),
      margin: EdgeInsets.only(bottom: 1),
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Books on market from ${widget.otherUser.name}'),
                IconButton(
                    onPressed: () {
                      if (height == OPEN_HEIGHT) {
                        setState(() {
                          height = CLOSED_HEIGHT;
                        });
                      } else {
                        setState(() {
                          height = OPEN_HEIGHT;
                        });
                      }
                    },
                    icon: Icon(height == OPEN_HEIGHT
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down))
              ],
            ),
          ),
          if (height == OPEN_HEIGHT)
            Container(
              height: 150,
              child: ChatMarketListBuiler(
                otherUserID: widget.otherUser.id,
                userName: widget.otherUser.name,
              ),
            )
        ],
      ),
    );
  }
}
