import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/market_provider.dart';

class MapMarket extends StatelessWidget {
  late final MarketProvider marketProvider;
  MapMarket(BuildContext context) {
    marketProvider = Provider.of<MarketProvider>(context);
    marketProvider
        .getMapMarket(Provider.of<AuthProvider>(context, listen: false).uid!);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: marketProvider.marketBooks.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
            child: Material(
              elevation: 5,
              color: Colors.white,
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 300,
                //  height: 100,
                //   margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(right: 5),
                child: Row(
                  children: [
                    Image.network(
                      marketProvider.marketBooks[index].thumbnail!,
                      height: 210,
                      width: 120,
                      fit: BoxFit.fitHeight,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              marketProvider.marketBooks[index].title!,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            ...marketProvider.marketBooks[index].authors!
                                .map((String s) => Text('$s ')),
                            SizedBox(height: 5),
                            Text(
                              'Price: ${marketProvider.marketBooks[index].price} EGP',
                              style: TextStyle(fontSize: 16),
                            ),
                            /*  ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(url),
                              ),
                            )*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
