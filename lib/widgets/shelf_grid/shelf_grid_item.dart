import 'package:flutter/material.dart';
import 'package:shelf/models/shelf.dart';
import 'package:shelf/pages/shelf_page.dart';
import 'package:shelf/widgets/shelf_grid/shelf_overview.dart';
import 'package:shelf/widgets/shelf_grid/user_info.dart';

class ShelfGridItem extends StatelessWidget {
  final Shelf shelf;
  const ShelfGridItem({
    Key? key,
    required this.shelf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(ShelfPage.routeName, arguments: shelf.id),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ShelfOverview(shelfID: shelf.id),
                Positioned(
                  bottom: -25,
                  left: 10,
                  child: UserInfo(userID: shelf.user),
                ),
              ],
            ),
            SizedBox(height: 28),
            Text(
              shelf.name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
