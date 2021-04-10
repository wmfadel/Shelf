import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/models/shelf.dart';
import 'package:shelf/pages/create_shelf_screen.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/shelf_grid/shelf_grid_item.dart';
import 'package:shelf/widgets/shimmer_items/shmr_shelf_overview.dart';

class ProfileShelfGridBuilder extends StatefulWidget {
  const ProfileShelfGridBuilder({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  _ProfileShelfGridBuilderState createState() =>
      _ProfileShelfGridBuilderState();
}

class _ProfileShelfGridBuilderState extends State<ProfileShelfGridBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('shelfs')
          .where('user', isEqualTo: widget.uid)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return GridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.1,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: List.generate(
                4,
                (_) => ShmrShelfOverview(),
              ));

        String currentUserID =
            Provider.of<AuthProvider>(context, listen: false).uid!;
        if (snapshot.data!.size < 1 && widget.uid == currentUserID)
          return TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(CreateShelfScreen.routeName)
                    .then((_) {
                  setState(() {});
                });
              },
              child: Text('Create your first shelf'));

        if (snapshot.data!.size < 1 && widget.uid != currentUserID)
          return Center(
            child: Text('No Shelfs created by this user'),
          );
        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
        List<Shelf> shelfs = [];
        documents.forEach((QueryDocumentSnapshot e) {
          shelfs.add(Shelf(
              id: e.id,
              name: e.get('name'),
              description: e.get('description'),
              user: e.get('user'),
              isPublic: e.get('isPublic') ?? true,
              time: e.get('time')));
        });
        print(shelfs.length.toString());
        return GridView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.2,
          ),
          children: [
            ...shelfs
                .where((Shelf element) {
                  String? uid =
                      Provider.of<AuthProvider>(context, listen: false).uid;
                  if (element.user == uid) return true;
                  if (element.isPublic) return true;
                  return false;
                })
                .map((Shelf shelf) => ShelfGridItem(shelf: shelf))
                .toList()
          ],
        );
      },
    );
  }
}
