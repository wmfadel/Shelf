import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/widgets/profile_widgets/follow_button.dart';
import 'package:shelf/widgets/profile_widgets/profile_people_view.dart';
import 'package:shelf/widgets/shimmer_items/shmr_profile_personal_info.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePersonalInfo extends StatelessWidget {
  final String uid;
  const ProfilePersonalInfo({required this.uid});

  openMap(String location) async {
    List<String> parts = location.split(',');
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${parts[0]},${parts[1]}';

    launch(googleUrl);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return ShmrProfilePersonalInfo();
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      snapshot.data?.get('photo'),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    snapshot.data?.get('name'),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    snapshot.data?.get('email'),
                  ),
                  ProfilePeopleView(uid),
                ],
              ),
              if (uid != Provider.of<AuthProvider>(context, listen: false).uid)
                Positioned(
                  top: 75,
                  right: MediaQuery.of(context).size.width * 0.25,
                  child: FollowButton(uid),
                ),
              // directions button
              if (uid != Provider.of<AuthProvider>(context, listen: false).uid)
                Positioned(
                  top: 40,
                  right: MediaQuery.of(context).size.width * 0.15,
                  child: IconButton(
                    onPressed: () {
                      openMap(snapshot.data?.get('location'));
                    },
                    icon: Icon(
                      Icons.directions,
                      size: 40,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          );
        });
  }
}
