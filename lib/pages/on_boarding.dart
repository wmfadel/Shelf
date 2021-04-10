import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/login_page.dart';
import 'package:shelf/providers/auth_provider.dart';

class OnBoardingPage extends StatelessWidget {
  static final String routeName = 'OnBoarding_page';
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> listPagesViewModel = [
      // page one
      PageViewModel(
        title: "Create Your own library on Shelf",
        decoration: PageDecoration(pageColor: Colors.white),
        bodyWidget: Text(
          'Search and add all books you own in your library and organize them in shelfs',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        image: Center(child: Image.asset('assets/pics/library.png')),
      ),
      // page two
      PageViewModel(
        title: "Build your profile",
        decoration: PageDecoration(pageColor: Colors.white),
        bodyWidget: Text(
          'Build your own profile and let people get to know you, and manage your shelfs and activities',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        image: Center(child: Image.asset('assets/pics/profile.png')),
      ),
      // page three
      PageViewModel(
        title: "Sell and buy book from the market",
        decoration: PageDecoration(pageColor: Colors.white),
        bodyWidget: Text(
          'Explore books offerd to sale on the market by other users, and sell the books you no longer need.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        image: Center(child: Image.asset('assets/pics/shop.png')),
      ),
      // page four
      PageViewModel(
        title: "Find people, Books and places",
        decoration: PageDecoration(pageColor: Colors.white),
        bodyWidget: Text(
          'Find other people near to you, local book stores and search for the nearest place you can find a book at.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        image: Center(child: Image.asset('assets/pics/map.png')),
      ),
      // page five
      PageViewModel(
        title: "Social media for book lovers",
        decoration: PageDecoration(pageColor: Colors.white),
        bodyWidget: Text(
          'Enjoy your time browsing and engaging with other users in our social media created for book lovers',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        image: Center(child: Image.asset('assets/pics/social.png')),
      ),
      // page six
      PageViewModel(
        title: "Share your ideas, thougth and opinions",
        decoration: PageDecoration(pageColor: Colors.white),
        bodyWidget: Text(
          'Share your ideas thougth and opinions of books and authors with people that follow you.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        image: Center(child: Image.asset('assets/pics/share.png')),
      ),
      // page seven
      PageViewModel(
        title: "Chat with other people",
        decoration: PageDecoration(pageColor: Colors.white),
        bodyWidget: Text(
          'Chat with other book enthusiasts, and make deals before buying or selling.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        image: Center(child: Image.asset('assets/pics/chat.png')),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IntroductionScreen(
        pages: listPagesViewModel,
        onDone: () {
          // When done button is press
          doneAction(context);
        },
        onSkip: () {
          doneAction(context);
        },
        showSkipButton: true,
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.navigate_next_rounded),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Theme.of(context).accentColor,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }

  doneAction(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).completedOnBoarding();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
}
