import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/market_book.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/map_provider.dart';
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
          return GestureDetector(
            onTap: () {
              MapProvider mapProvider =
                  Provider.of<MapProvider>(context, listen: false);
              mapProvider.controller?.moveCamera(CameraUpdate.newLatLng(
                  mapProvider.parseLatLang(
                      marketProvider.marketBooks[index].location!)));
            },
            child: Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
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
                                      .take(2)
                                      .map((String s) => Text('$s ')),
                                  SizedBox(height: 5),
                                  Text(
                                    'Price: ${marketProvider.marketBooks[index].price} EGP',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              /* ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(marketProvider
                                      .marketBooks[index].userPhoto!),
                                ),
                                title: Text(
                                    marketProvider.marketBooks[index].userName!),
                                subtitle: Text(
                                    marketProvider.marketBooks[index].email!),
                              )*/
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(marketProvider
                                        .marketBooks[index].userPhoto!),
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        marketProvider
                                            .marketBooks[index].userName!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        marketProvider
                                            .marketBooks[index].email!,
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
        },
      ),
    );
  }
}
