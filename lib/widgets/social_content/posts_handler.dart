import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/post.dart';
import 'package:shelf/widgets/social_content/posts_list.dart';

class PostsHandler extends StatelessWidget {
  final String? userId;
  PostsHandler({this.userId});
  @override
  Widget build(BuildContext context) {
    var query;
    if (userId == null) {
      query = FirebaseFirestore.instance
          .collection('social')
          .where('reply-to', isNull: true);
    } else {
      query = FirebaseFirestore.instance
          .collection('social')
          .where('reply-to', isNull: true)
          .where('user', isEqualTo: userId);
    }
    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Image.asset('assets/pics/error.png'));
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
          return Center(child: Image.asset('assets/pics/empty.png'));
        List<Post> posts = [];
        snapshot.data!.docs.forEach((QueryDocumentSnapshot element) {
          posts.add(Post.fromJson(element.data()!, element.id));
        });
        return PostsList(posts: posts);
      },
    );
  }
}
