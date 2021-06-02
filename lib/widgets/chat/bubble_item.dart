import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

class BubbleItem extends StatelessWidget {
  final String text;
  final bool isFromThisUser;
  final bool isLocation;
  const BubbleItem({
    Key? key,
    required this.text,
    required this.isFromThisUser,
    this.isLocation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocation
          ? () {
              GeoPoint g = LocationService.parseLatLang(text);
              launch(
                  'https://www.google.com/maps/search/?api=1&query=${g.latitude},${g.longitude}');
            }
          : null,
      child: Container(
        child: Row(
          children: [
            if (isLocation)
              Icon(
                Icons.location_on_outlined,
                color: isFromThisUser ? Colors.white : Colors.blue,
              ),
            if (isLocation) SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                color: isFromThisUser ? Colors.white : Colors.black,
                decoration:
                    isLocation ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(
          left: isFromThisUser ? 80 : 5,
          right: isFromThisUser ? 5 : 80,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isFromThisUser
              ? Theme.of(context).primaryColor.withOpacity(0.75)
              : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: isFromThisUser ? Radius.circular(8) : Radius.zero,
            topRight: isFromThisUser ? Radius.zero : Radius.circular(8),
            bottomLeft: isFromThisUser ? Radius.circular(8) : Radius.zero,
            bottomRight: isFromThisUser ? Radius.zero : Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
