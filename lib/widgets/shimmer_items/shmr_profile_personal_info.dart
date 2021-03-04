import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShmrProfilePersonalInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
          width: MediaQuery.of(context).size.width,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: true,
          child: Container(
            width: 120,
            height: 120,
            decoration:
                BoxDecoration(color: Colors.black, shape: BoxShape.circle),
          ),
        ),
        SizedBox(height: 15),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: true,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: true,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
