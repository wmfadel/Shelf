import 'package:flutter/material.dart';
import 'package:shelf/models/post.dart';
import 'package:shelf/widgets/social_content/post_list_item.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;
  PostsList({required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return PostListItem(post: posts[index]);
      },
    );
  }
}
