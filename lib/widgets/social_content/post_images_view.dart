import 'package:flutter/material.dart';
import 'package:shelf/widgets/social_content/post_image.dart';

class PostImagesView extends StatelessWidget {
  final List<String> images;
  PostImagesView({required this.images});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: images
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(4),
                child: PostImage(e),
              ),
            )
            .toList(),
      ),
    );
  }
}
