import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/post_provider.dart';
import 'package:shelf/widgets/create_post/selected_image.dart';

class ImageSelector extends StatefulWidget {
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  late PostProvider postProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postProvider = Provider.of<PostProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      runSpacing: 8,
      spacing: 8,
      children: [
        ...postProvider.images.map((File f) => SelectedImage(f)).toList(),
        GestureDetector(
          onTap: postProvider.isUploading
              ? null
              : () => postProvider.getImage(ImageSource.camera),
          child: Container(
            width: 80,
            height: 80,
            child: Center(
              child: Icon(Icons.add_a_photo),
            ),
            decoration: BoxDecoration(
              color: postProvider.isUploading ? Colors.grey : Colors.white,
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        GestureDetector(
          onTap: postProvider.isUploading
              ? null
              : () => postProvider.getImage(ImageSource.gallery),
          child: Container(
            width: 80,
            height: 80,
            child: Center(
                child: Icon(
              Icons.photo_library,
            )),
            decoration: BoxDecoration(
              color: postProvider.isUploading ? Colors.grey : Colors.white,
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ],
    );
  }
}
