import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/general_rating.dart';
import 'package:shelf/widgets/rate_widget.dart';

class RatingPage extends StatefulWidget {
  static final String routeName = 'rating_page';

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  late String userID;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userID = Provider.of<AuthProvider>(context, listen: false).uid!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Rating Page',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity, height: 64),
          Text(
            'General App Rating',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          GeneralRating(),
          SizedBox(height: 100),
          Text(
            'My Rating',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          SizedBox(height: 50),
          RateWidget(
            userID: userID,
            isUp: true,
          ),
          SizedBox(height: 30),
          RateWidget(
            userID: userID,
            isUp: false,
          ),
        ],
      ),
    );
  }
}
