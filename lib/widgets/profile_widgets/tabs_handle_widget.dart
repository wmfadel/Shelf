import 'package:flutter/material.dart';
import 'package:shelf/widgets/market/on_market.dart';
import 'package:shelf/widgets/quotes/quotes_list_builder.dart';
import 'package:shelf/widgets/shelf_grid/profile_shelf_grid_builder.dart';
import 'package:shelf/widgets/social_content/posts_handler.dart';

class TabsHandleWidget extends StatelessWidget {
  final String uid;
  TabsHandleWidget(this.uid);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height - 300,
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                tabs: [
                  Tab(text: "Shelfs"),
                  Tab(text: "Quotes"),
                  Tab(text: "Activity"),
                  Tab(text: "Market"),
                ],
                indicatorColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ProfileShelfGridBuilder(uid: uid),
                  ),
                  //PeopleHandle(uid: uid),
                  QuotesListBuilder(userID: uid),
                  PostsHandler(userId: uid),
                  OnMarket(userID: uid),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
