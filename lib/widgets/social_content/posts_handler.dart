import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/post.dart';
import 'package:shelf/widgets/social_content/posts_list.dart';

class PostsHandler extends StatefulWidget {
  final String? userId;
  final Key key;
  const PostsHandler({
    required this.key,
    this.userId,
  }) : super(key: key);

  @override
  _PostsHandlerState createState() => _PostsHandlerState();
}

class _PostsHandlerState extends State<PostsHandler>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var query;
    if (widget.userId == null) {
      query = FirebaseFirestore.instance
          .collection('social')
          .where('reply-to', isNull: true)
          .orderBy('date', descending: true);
    } else {
      query = FirebaseFirestore.instance
          .collection('social')
          .where('reply-to', isNull: true)
          .where('user', isEqualTo: widget.userId)
          .orderBy('date', descending: true);
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
          Post temp = Post.fromJson(element.data()!, element.id);
          posts.add(temp);
        });
        return PostsList(posts: posts);
      },
    );
  }
}
