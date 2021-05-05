import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShmrUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: true,
          child: Container(
            width: 40,
            height: 40,
            decoration:
                BoxDecoration(color: Colors.black, shape: BoxShape.circle),
          ),
        ),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.22,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
