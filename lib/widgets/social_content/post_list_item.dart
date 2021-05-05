import 'package:flutter/material.dart';
import 'package:shelf/models/post.dart';
import 'package:shelf/widgets/social_content/post_images_view.dart';
import 'package:shelf/widgets/social_content/user_info.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  PostListItem({required this.post});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: UserInfo(userID: post.user)),
                    IconButton(
                        onPressed: () {},
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
                    fontSize: 18,
                  ),
                ),
                if (post.images!.isNotEmpty) ...[
                  SizedBox(height: 10),
                  PostImagesView(images: post.images!),
                ],
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Divider(),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.thumb_up,
                      ),
                    ),
                    Text(
                      '${post.likes?.length ?? 0}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.comment,
                      ),
                    ),
                    Text(
                      '${post.comments?.length ?? 0}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
