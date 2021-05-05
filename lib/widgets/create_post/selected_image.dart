import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/post_provider.dart';

class SelectedImage extends StatelessWidget {
  final File image;

  SelectedImage(this.image);
  @override
  Widget build(BuildContext context) {
    PostProvider postProvider = Provider.of<PostProvider>(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: -8,
          right: -8,
          child: GestureDetector(
            onTap: postProvider.isUploading
                ? null
                : () => postProvider.removeImage(image),
            child: Icon(
              Icons.remove_circle,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
