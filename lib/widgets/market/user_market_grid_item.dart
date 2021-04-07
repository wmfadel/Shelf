import 'package:flutter/material.dart';

class UserMarketGridItem extends StatelessWidget {
  final Map<String, dynamic>? item;

  UserMarketGridItem({required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
