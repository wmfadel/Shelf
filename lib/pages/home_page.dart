import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/add_book_page.dart';
import 'package:shelf/pages/profile_page.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/market_provider.dart';
import 'package:shelf/widgets/custom_avatar.dart';
import 'package:shelf/widgets/custom_button.dart';
import 'package:shelf/widgets/drawer_list.dart';
import 'package:shelf/widgets/home_map.dart';

class HomePage extends StatelessWidget {
  static final String routeName = '/home';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerList(),
      body: Stack(
        children: [
          HomeMap(),
          Positioned(
            top: 45,
            left: 20,
            child: CustomButton(
              iconData: Icons.menu,
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
            ),
          ),
          Positioned(
            top: 45,
            right: 20,
            child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                    ProfilePage.routeName,
                    arguments:
                        Provider.of<AuthProvider>(context, listen: false).uid),
                child: CustomAvatar()),
          ),
          Positioned(
            top: 45,
            right: 80,
            child: CustomButton(
              iconData: Icons.library_books,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddBookPage.routeName),
            ),
          ),
          Positioned(
            top: 45,
            right: 135,
            child: CustomButton(
              iconData: Icons.search,
              onPressed: () {},
            ),
          ),
          Positioned(bottom: 5, child: MapMarket(context))
        ],
      ),
    );
  }
}

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
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: marketProvider.marketBooks.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 250,
            height: 100,
            color: Colors.red,
            margin: EdgeInsets.all(10),
            child: Center(
              child: Text(marketProvider.marketBooks[index].title!),
            ),
          );
        },
      ),
    );
  }
}
