import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/market_book.dart';
import 'package:shelf/providers/map_provider.dart';
import 'package:shelf/providers/market_provider.dart';

class MarketMapListItem extends StatelessWidget {
  final MarketBook book;
  MarketMapListItem(this.book);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MapProvider mapProvider =
            Provider.of<MapProvider>(context, listen: false);
        Provider.of<MarketProvider>(context, listen: false).setActiveBook(book);
        mapProvider.controller?.animateCamera(
            CameraUpdate.newLatLng(mapProvider.parseLatLang(book.location!)));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
        child: Material(
          elevation: 5,
          color: Colors.white,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 330,
            //  height: 100,
            //   margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(right: 5),
            child: Row(
              children: [
                Image.network(
                  book.thumbnail!,
                  height: 210,
                  width: 120,
                  fit: BoxFit.fitHeight,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              book.title!,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            ...book.authors!
                                .take(2)
                                .map((String s) => Text('$s ')),
                            SizedBox(height: 5),
                            if (book.price == 0)
                              Container(
                                width: 80,
                                height: 30,
                                child: Center(
                                  child: Text('Free',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                              ),
                            if (book.price != 0)
                              Text(
                                'Price: ${book.price} EGP',
                                style: TextStyle(fontSize: 16),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(book.userPhoto!),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  book.email!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ))
                          ],
                        )
                      ],
                    ),
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
