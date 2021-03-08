import 'package:flutter/material.dart';
import 'package:shelf/widgets/shelf_grid/profile_shelf_grid_builder.dart';

class TabsHandleWidget extends StatelessWidget {
  final String uid;
  TabsHandleWidget(this.uid);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height - 270,
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              child: TabBar(
                tabs: [
                  Tab(text: "Shelfs"),
                  Tab(text: "People"),
                  Tab(text: "Activity"),
                  Tab(text: "Qoutes"),
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
                    padding: const EdgeInsets.only(top: 8),
                    child: ProfileShelfGridBuilder(uid: uid),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.red,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.green,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.blue,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}