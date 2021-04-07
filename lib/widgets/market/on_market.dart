import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/market/user_market_grid_item.dart';

class OnMarket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('market')
          .where('user-id', isEqualTo: authProvider.uid)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        if (snapshot.hasError || (snapshot.data?.docs.length ?? 0) < 1) {
          return Center(child: Text('You have no Books on the Market'));
        }
        return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return UserMarketGridItem(
                  item: snapshot.data?.docs[index].data());
            });
      },
    );
  }
}
