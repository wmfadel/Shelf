import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/models/shelf.dart';
import 'package:shelf/widgets/shelf_grid/shelf_grid_item.dart';
import 'package:shelf/widgets/shimmer_items/shmr_shelf_overview.dart';

class ProfileShelfGridBuilder extends StatelessWidget {
  const ProfileShelfGridBuilder({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('shelfs')
          .where('user', isEqualTo: uid)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data!.size < 1)
          return GridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.2,
              children: List.generate(
                4,
                (_) => ShmrShelfOverview(),
              ));

        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
        List<Shelf> shelfs = [];
        documents.forEach((QueryDocumentSnapshot e) {
          shelfs.add(Shelf(
              id: e.id,
              name: e.get('name'),
              description: e.get('description'),
              user: e.get('user'),
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
            ...shelfs.map((Shelf shelf) => ShelfGridItem(shelf: shelf)).toList()
          ],
        );
      },
    );
  }
}
