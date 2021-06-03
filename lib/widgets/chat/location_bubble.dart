import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shelf/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationBubble extends StatelessWidget {
  final GeoPoint location;
  final bool isFromThisUser;
  const LocationBubble(
      {Key? key, required this.location, required this.isFromThisUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          launch(
              'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}');
        },
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: isFromThisUser ? Colors.white : Colors.blue,
              ),
              SizedBox(width: 4),
              Text(
                'This is my current location',
                style: TextStyle(
                    color: isFromThisUser ? Colors.white : Colors.black,
                    decoration: TextDecoration.underline),
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
      ),
    );
  }
}

/**
 *  
 */