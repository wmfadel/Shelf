import 'package:flutter/material.dart';
import 'package:shelf/pages/profile_page.dart';

class MarketUser extends StatelessWidget {
  final String id, name, photo, email;

  MarketUser({
    required this.id,
    required this.name,
    required this.photo,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(ProfilePage.routeName, arguments: id),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(photo),
              radius: 25,
            ),
            SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Buy'),
            )
          ],
        ),
      ),
    );
  }
}
