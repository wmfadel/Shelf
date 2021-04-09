import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shelf/models/market_book.dart';
import 'package:shelf/widgets/market/buyer_info.dart';

class UserMarketGridItem extends StatelessWidget {
  final MarketBook marketBook;
  final bool isOwner;

  UserMarketGridItem({required this.marketBook, required this.isOwner});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              marketBook.sold! ? 'Sold' : 'In Market',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: marketBook.sold!
                                  ? Colors.redAccent
                                  : Colors.blue,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                topLeft: Radius.circular(4),
                              )),
                        ),
                        SizedBox(height: 10),
                        Image.network(
                          marketBook.thumbnail!,
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(height: 10),
                        Text(
                          marketBook.title!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('${marketBook.publishDate!}'),
                        ...(marketBook.authors as List<dynamic>)
                            .map((s) => Text(
                                  s,
                                  style: TextStyle(fontSize: 18),
                                ))
                            .toList(),
                        SizedBox(height: 4),
                        Divider(),
                        SizedBox(height: 20),
                        Text('Price: ${marketBook.price!} EGP'),
                        SizedBox(height: 4),
                        if (marketBook.sold!)
                          Text(
                            'Sold To',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        if (marketBook.sold!)
                          BuyerInfo(
                            buyerID: marketBook.buyer!,
                          ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, bottom: 10),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              child: Text('OK'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },

        /*
         if (!isOwner)
                              ElevatedButton(
                                  onPressed: () {}, child: Text('Buy'))*/
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 200,
              child: Row(
                children: [
                  Image.network(
                    marketBook.thumbnail!,
                    height: 200,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          marketBook.title!,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...(marketBook.authors as List<dynamic>)
                            .map(
                              (author) => Text(
                                author,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            )
                            .toList(),
                        Text('Price: ${marketBook.price!} EGP'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 85,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: marketBook.sold!
                                    ? Colors.redAccent
                                    : Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                marketBook.sold! ? 'Sold' : 'In Market',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            if (!isOwner && !marketBook.sold!)
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, bottom: 5),
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text('Buy')),
                              ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
