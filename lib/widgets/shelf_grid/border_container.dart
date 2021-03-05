import 'package:flutter/material.dart';
import 'package:shelf/models/api_book.dart';

class BorderContainer extends StatelessWidget {
  final List<APIBook> books;
  BorderContainer({required this.books});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 150,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 4,
              child: books.length > 0
                  ? ImageLoader(
                      image: books[0].thumbnail!,
                    )
                  : Container(
                      color: Colors.grey[300],
                    ),
            ),
            SizedBox(width: 1),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: books.length > 1
                        ? ImageLoader(
                            image: books[1].thumbnail!,
                          )
                        : Container(
                            color: Colors.grey[300],
                          ),
                  ),
                  SizedBox(height: 1),
                  Expanded(
                    child: books.length > 2
                        ? ImageLoader(
                            image: books[2].thumbnail!,
                          )
                        : Container(
                            color: Colors.grey[300],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, child, ImageChunkEvent? event) {
        if (event == null) return child;
        int loaded = event.cumulativeBytesLoaded;
        int total = event.expectedTotalBytes ?? 1;
        return Center(
          child: CircularProgressIndicator(
            value: loaded / total,
          ),
        );
      },
    );
  }
}
