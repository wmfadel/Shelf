import 'package:flutter/material.dart';
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
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        centerTitle: true,
      ),
      body: PostsHandler(),
    );
  }
}
