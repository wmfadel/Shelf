import 'package:flutter/material.dart';
import 'package:shelf/widgets/feedback/feedback_list_builder.dart';
import 'package:shelf/widgets/feedback/send_feedback.dart';

class ContactMePage extends StatefulWidget {
  static final String routeName = 'ContactMe_page';

  @override
  _ContactMePageState createState() => _ContactMePageState();
}

class _ContactMePageState extends State<ContactMePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact / Feedback',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Topics',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Expanded(child: SendFeedBack()),
            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 10),
            Text(
              'My Feedback',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Expanded(child: FeedbackListBuilder()),
          ],
        ),
      ),
    );
  }
}
