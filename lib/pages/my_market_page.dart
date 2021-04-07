import 'package:flutter/material.dart';
import 'package:shelf/widgets/market/on_market.dart';

class MyMarkeyPage extends StatelessWidget {
  static final String routeName = 'MyMarkey_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My market'),
      ),
      body: OnMarket(),
    );
  }
}
