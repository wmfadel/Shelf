import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostImage extends StatelessWidget {
  final String image;
  final double size;

  PostImage(this.image, this.size);
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: size,
            height: size,
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            /* child: Image.network(
              image,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadProgress) {
                if (loadProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadProgress.expectedTotalBytes != null
                        ? loadProgress.cumulativeBytesLoaded /
                            loadProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),*/
          ),
        ),
      ],
    );
  }
}
