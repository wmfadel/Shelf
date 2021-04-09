import 'package:flutter/material.dart';
import 'package:shelf/models/market_book.dart';

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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...book.photos!
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(4),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Image.network(e),
                                                SizedBox(height: 10),
                                                ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text('Ok'))
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      e,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(book.userPhoto!),
                        radius: 25,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.userName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              book.email!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Buy'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
