import 'package:flutter/material.dart';

class ShelfOverview extends StatelessWidget {
  final String shelfID;

  const ShelfOverview({
    Key? key,
    required this.shelfID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue,
      ),
    );
  }
}
