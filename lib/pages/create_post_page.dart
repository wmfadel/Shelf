import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {
  static final String routeName = 'CreatePost_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        centerTitle: true,
      ),
    );
  }
}
