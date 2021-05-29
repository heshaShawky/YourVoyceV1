import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcfcff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/YourVoyceSplashScreen1.gif',
              height: 250,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}