import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/market_provider.dart';
import 'package:shelf/widgets/market/market_map_list_item.dart';

class MapMarket extends StatelessWidget {
  late final MarketProvider marketProvider;
  MapMarket(BuildContext context) {
    marketProvider = Provider.of<MarketProvider>(context);
    if (marketProvider.marketBooks.length < 1)
      marketProvider
          .getMapMarket(Provider.of<AuthProvider>(context, listen: false).uid!);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: marketProvider.searchBooks.isEmpty
            ? marketProvider.marketBooks.length
            : marketProvider.searchBooks.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return MarketMapListItem(marketProvider.searchBooks.isEmpty
              ? marketProvider.marketBooks[index]
              : marketProvider.searchBooks[index]);
        },
      ),
    );
  }
}
