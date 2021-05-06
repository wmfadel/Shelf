import 'package:flutter/material.dart';
import 'package:shelf/pages/create_post_page.dart';
import 'package:shelf/widgets/social_content/posts_handler.dart';

class SocialPage extends StatelessWidget {
  static final String routeName = 'Social_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Social',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CreatePostPage.routeName),
              icon: Icon(
                Icons.history_edu,
              ))
        ],
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        centerTitle: true,
      ),
      body: PostsHandler(
        key: PageStorageKey('activity'),
      ),
    );
  }
}
