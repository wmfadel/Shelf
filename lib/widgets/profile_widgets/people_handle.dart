import 'package:flutter/material.dart';
import 'package:shelf/widgets/profile_widgets/followers_list.dart';
import 'package:shelf/widgets/profile_widgets/following_list.dart';

class PeopleHandle extends StatelessWidget {
  final String uid;
  PeopleHandle({required this.uid});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height - 280,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                tabs: [
                  Tab(text: "Following"),
                  Tab(text: "Followers"),
                ],
                indicatorColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  FollowingList(uid: uid),
                  FollowersList(uid: uid),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
