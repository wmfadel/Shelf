import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/market_provider.dart';

class SearchPage extends StatefulWidget {
  static final String routeName = 'Search_page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  late MarketProvider marketProvider;
  late AuthProvider authProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    marketProvider = Provider.of<MarketProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                maxLines: 2,
                minLines: 1,
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: 'search for a book or user',
                  hintText: 'search for a book',
                ),
              ),
              SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  marketProvider.searchForBookByTitle(
                      searchController.text.trim().toLowerCase());
                  print(
                      'search term ${searchController.text.trim().toLowerCase()}');
                  if (marketProvider.searchBooks.isNotEmpty) {
                    searchController.clear();
                    Navigator.of(context).pop();
                  }
                },
                minWidth: 250,
                color: Theme.of(context).primaryColor,
                disabledColor: Colors.grey.shade400,
                disabledTextColor: Colors.white,
                textColor: Colors.white,
                height: 45,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
