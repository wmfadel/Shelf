import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/analytics_provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/market_provider.dart';
import 'package:shelf/widgets/market/market_list_item.dart';

class MarketPage extends StatelessWidget {
  static final String routeName = 'Market_page';
  @override
  Widget build(BuildContext context) {
    context.read<AnalyticsProvider>().setCurrentScreen(MarketPage.routeName);

    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    marketProvider
        .getMapMarket(Provider.of<AuthProvider>(context, listen: false).uid!);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Market',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: marketProvider.marketBooks.length,
        itemBuilder: (BuildContext context, int index) {
          return MarketListItem(
            book: marketProvider.marketBooks[index],
          );
        },
      ),
    );
  }
}
