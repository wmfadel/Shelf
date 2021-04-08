import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shelf/widgets/market/buyer_info.dart';

class UserMarketGridItem extends StatelessWidget {
  final Map<String, dynamic>? item;
  final bool isOwner;

  UserMarketGridItem({required this.item, required this.isOwner});
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
                              item?['sold'] ? 'Sold' : 'In Market',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: item?['sold']
                                  ? Colors.redAccent
                                  : Colors.blue,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                topLeft: Radius.circular(4),
                              )),
                        ),
                        SizedBox(height: 10),
                        Image.network(
                          item?['thumbnail'],
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(height: 10),
                        Text(
                          item?['title'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('${item?['publish-date'] ?? ''}'),
                        ...(item?['authors'] as List<dynamic>)
                            .map((s) => Text(
                                  s,
                                  style: TextStyle(fontSize: 18),
                                ))
                            .toList(),
                        SizedBox(height: 4),
                        Divider(),
                        SizedBox(height: 20),
                        Text('Price: ${item?['price']} EGP'),
                        SizedBox(height: 4),
                        if (item?['sold'])
                          Text(
                            'Sold To',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        if (item?['sold'])
                          BuyerInfo(
                            buyerID: item?['buyer'],
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
                    item?['thumbnail'],
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
                          item?['title'],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...(item?['authors'] as List<dynamic>)
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
                        Text('Price: ${item?['price']} EGP'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 85,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: item?['sold']
                                    ? Colors.redAccent
                                    : Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                item?['sold'] ? 'Sold' : 'In Market',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            if (!isOwner && !item?['sold'])
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
