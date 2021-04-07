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
              String? itemID = snapshot.data?.docs[index].id;
              return Dismissible(
                key: Key(itemID!),
                confirmDismiss: (DismissDirection direction) async {
                  bool confirm = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              'Are you sure you want to remove this book from market'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('market')
                                    .doc(snapshot.data?.docs[index].id)
                                    .delete();
                                Navigator.of(context).pop(true);
                              },
                              child: Text('Remove'),
                            ),
                          ],
                        );
                      });
                  return confirm;
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
                child: UserMarketGridItem(
                  item: snapshot.data?.docs[index].data(),
                ),
              );
            });
      },
    );
  }
}
