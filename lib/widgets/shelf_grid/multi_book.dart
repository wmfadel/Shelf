import 'package:flutter/material.dart';
import 'package:shelf/models/api_book.dart';

class MultiBook extends StatelessWidget {
  final List<APIBook> books;
  MultiBook({required this.books});

  @override
  Widget build(BuildContext context) {
    double pos = -35;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 150,
        child: Stack(
          children: [
            ...books
                .take(4)
                .map(
                  (e) => Positioned(
                    left: (pos += 35),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 148,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Image.network(
                          e.thumbnail!,
                          fit: BoxFit.cover,
                        )),
                  ),
                )
                .toList()
                .reversed,
          ],
        ),
      ),
    );
  }
}
