import 'package:flutter/material.dart';

// preparations For adding online content page
// the plugin i need flutter_link_preview depends on an older version
// of http package so since i will be away for a month i'll wait
// maybe when i come back it will be updated
class OnlineContentPage extends StatelessWidget {
  static final String routeName = '/online-content';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OnlineContent',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      /*  body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('content')
              .doc('urls')
              .get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            List<dynamic> urls = snapshot.data?.get('youtube') as List<dynamic>;
            return UrlPreviewCard(
              url: urls[0].toString(),
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              descriptionStyle: TextStyle(color: Colors.white),
              siteNameStyle: TextStyle(color: Colors.white),
            );
          }),*/
    );
  }
}
