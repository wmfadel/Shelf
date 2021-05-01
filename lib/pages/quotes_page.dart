import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/quotes/quotes_list_builder.dart';

class QuotesPagePage extends StatelessWidget {
  static final String routeName = 'QuotesPage_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'My Quotes',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: QuotesListBuilder(
        userID: Provider.of<AuthProvider>(context, listen: false).uid!,
      ),
    );
  }
}
