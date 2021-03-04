import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shelf/pages/add_book_page.dart';
import 'package:shelf/pages/profile_page.dart';
import 'package:shelf/widgets/custom_avatar.dart';
import 'package:shelf/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Drawer(),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(30.0494817, 31.236408),
                zoom: 17,
              ),
              onMapCreated: (_) {
                // setting state to allow map to apply padding correctly
                setState(() {});
              },
              padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height - 160),
              ),
              myLocationEnabled: true,
              indoorViewEnabled: true,
              buildingsEnabled: true,
              compassEnabled: true,
              mapToolbarEnabled: true,
              myLocationButtonEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
            ),
            Positioned(
              top: 45,
              left: 20,
              child: CustomButton(
                iconData: Icons.menu,
                onPressed: () => scaffoldKey.currentState.openDrawer(),
              ),
            ),
            Positioned(
              top: 45,
              right: 20,
              child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(ProfilePage.routeName),
                  child: CustomAvatar()),
            ),
            Positioned(
              top: 45,
              right: 80,
              child: CustomButton(
                iconData: Icons.library_books,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AddBookPage.routeName),
              ),
            ),
            Positioned(
              top: 45,
              right: 135,
              child: CustomButton(
                iconData: Icons.search,
                onPressed: () {},
              ),
            ),
          ],
        ));
  }
}
