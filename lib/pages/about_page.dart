import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  static final String routeName = 'About_page';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/pics/me.jpg',
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.deepPurple.withOpacity(0.3),
                  Colors.deepPurple.withOpacity(0.5),
                  Colors.deepPurple.withOpacity(0.75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Mohamed ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 40)),
                      TextSpan(
                        text: 'Fadel',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                            fontFamily: 'Pacifico',
                            fontSize: 40),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'If it\s a ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24)),
                      TextSpan(
                        text: 'Mobile Application\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                            fontFamily: 'Pacifico',
                            fontSize: 24),
                      ),
                      TextSpan(
                          text: 'I can build it.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24)),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launch('https://github.com/wmfadel');
                        },
                        child: Image.asset('assets/pics/github.png',
                            width: 70, height: 70),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('https://www.linkedin.com/in/wmfadel/');
                        },
                        child: Image.asset('assets/pics/linkedin.png',
                            width: 70, height: 70),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('https://twitter.com/wmfadel');
                        },
                        child: Image.asset('assets/pics/twitter.png',
                            width: 70, height: 70),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'wmfadel',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontFamily: 'Pacifico'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 40,
              left: 15,
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 35,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
