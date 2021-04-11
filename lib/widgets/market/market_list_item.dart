import 'package:flutter/material.dart';
import 'package:shelf/models/market_book.dart';
import 'package:shelf/widgets/market/book_photos.dart';
import 'package:shelf/widgets/market/market_user.dart';

class MarketListItem extends StatelessWidget {
  final MarketBook book;

  MarketListItem({required this.book});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: size.width,
            //height: 250,
            //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      book.thumbnail!,
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            book.title!,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          ...book.authors!
                              .take(2)
                              .map((e) =>
                                  Text(e, style: TextStyle(fontSize: 16)))
                              .toList(),
                          SizedBox(height: 5),
                          Text(book.publishDate!),
                          SizedBox(height: 5),
                          Text('Price: ${book.price} EGP')
                        ],
                      ),
                    ),
                  ],
                ),
                // user data

                // images view
                BookPhotos(photos: book.photos!),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Divider(),
                ),
                MarketUser(
                  id: book.userId!,
                  name: book.userName!,
                  photo: book.userPhoto!,
                  email: book.email!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
