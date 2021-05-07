import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/post.dart';
import 'package:shelf/widgets/social_content/post_list_item.dart';

class CommentHandler extends StatelessWidget {
  final String commentId;
  CommentHandler(this.commentId);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('social')
          .doc(commentId)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Image.asset('assets/pics/error.png'));
        if (!snapshot.hasData)
          return Center(child: Image.asset('assets/pics/empty.png'));
        Post post = Post.fromJson(snapshot.data!.data()!, snapshot.data!.id);
        return PostListItem(post: post);
      },
    );
  }
}
