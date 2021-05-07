import 'package:flutter/material.dart';
import 'package:shelf/widgets/social_content/post_image.dart';

class PostImagesView extends StatelessWidget {
  final List<String> images;
  final double size;
  PostImagesView({required this.images, this.size = 120});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: images
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(4),
                child: PostImage(e, size),
              ),
            )
            .toList(),
      ),
    );
  }
}
