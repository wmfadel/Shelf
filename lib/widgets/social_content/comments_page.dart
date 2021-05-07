import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/post.dart';
import 'package:shelf/pages/create_post_page.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/post_provider.dart';
import 'package:shelf/widgets/social_content/comment_handler.dart';
import 'package:shelf/widgets/social_content/post_images_view.dart';
import 'package:shelf/widgets/social_content/user_info.dart';

class CommentsPage extends StatelessWidget {
  final Post parentPost;

  CommentsPage({required this.parentPost});

  @override
  Widget build(BuildContext context) {
    String currentUserId =
        Provider.of<AuthProvider>(context, listen: false).uid!;
    bool isLikedByThisUser = parentPost.likes!.contains(
      currentUserId,
    );

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('social')
              .doc(parentPost.id)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(child: Image.asset('assets/pics/error.png'));
            if (!snapshot.hasData)
              return Center(child: Image.asset('assets/pics/empty.png'));
            Post post =
                Post.fromJson(snapshot.data!.data()!, snapshot.data!.id);
            unlikePost(String userID) {
              post.likes!.remove(userID);
              FirebaseFirestore.instance
                  .collection('social')
                  .doc(parentPost.id)
                  .update({'likes': parentPost.likes});
            }

            likePost(String userID) {
              post.likes!.add(userID);
              FirebaseFirestore.instance
                  .collection('social')
                  .doc(parentPost.id)
                  .update({'likes': parentPost.likes});
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: UserInfo(
                          userID: post.user,
                          name: post.name,
                          email: post.email,
                          photo: post.photo,
                        )),
                        if (currentUserId == post.user)
                          IconButton(
                              onPressed: () {
                                // show confirmation dialog => delete / cancel
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Confirm',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              'Are you sure you want to delete this post',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Provider.of<PostProvider>(context,
                                                      listen: false)
                                                  .deletePost(post);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('delete'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      post.text ?? '',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    if (post.images!.isNotEmpty) ...[
                      SizedBox(height: 10),
                      PostImagesView(
                        images: post.images!,
                        size: 180,
                      ),
                    ],
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Divider(),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: currentUserId == post.user
                              ? null
                              : () {
                                  // allow liking only by other users
                                  // handle like by user
                                  // check if user alreay liked the photo
                                  if (isLikedByThisUser) {
                                    // unLike this photo
                                    unlikePost(currentUserId);
                                  } else {
                                    // like this photo
                                    likePost(currentUserId);
                                  }
                                },
                          icon: Icon(
                            (currentUserId != post.user && isLikedByThisUser)
                                ? Icons.thumb_up
                                : Icons.thumb_up_alt_outlined,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '${post.likes?.length ?? 0} likes',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 25),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                CreatePostPage.routeName,
                                arguments: post.id);
                          },
                          icon: Icon(
                            Icons.comment,
                          ),
                        ),
                        Text(
                          '${post.comments?.length ?? 0} comments',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Divider(),
                    ),
                    if (post.comments!.isEmpty)
                      Center(child: Text('no comments yet')),
                    if (post.comments!.isNotEmpty) ...[
                      Text(
                        'comments',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      ...post.comments!
                          .map((String commentId) => CommentHandler(commentId))
                          .toList(),
                    ]
                  ],
                ),
              ),
            );
          },
        ));
  }
}
