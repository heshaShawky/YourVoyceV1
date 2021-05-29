import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _offset;

  // Future<bool> _loadingDelay;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 500),
    );

    _offset = Tween<Offset>(
      begin: Offset(0.0, 1.0), 
      end: Offset.zero,
    ).animate(_animationController);

    switch (_animationController.status) {
      case AnimationStatus.completed:
        _animationController.reverse();
        break;
      case AnimationStatus.dismissed:
        _animationController.forward();
        break;
      default:
    }

    // _loadingDelay = Future.delayed(Duration(seconds: 3), () => true).whenComplete(() {
    //   setState(() {
    //     _visible = false;
    //   });
    // });
    
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        brightness: Brightness.light,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 200,
            ),
            // Text(
            //   'Find what\'s happening on Social Media...',
            //   textAlign: TextAlign.center,
            //   style: Theme.of(context).textTheme.headline5,
            // ),
            // Text(
            //   'Begin your journey with YourVoyce today!',
            //   textAlign: TextAlign.center,
            //   style: Theme.of(context).textTheme.headline6.copyWith(
            //     // color: Theme.of(context).colorScheme.secondary
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            // AnimatedOpacity(
            //   opacity: _visible ? 1.0 : 0.0, 
            //   duration: Duration(seconds: 3),
            //   child: CircularProgressIndicator(),
            // ),
            // CircularProgressIndicator(),
            SlideTransition(
              position: _offset,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: OutlineButton(
                      color: Theme.of(context).accentColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 15
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('login');
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary
                        ),
                      ) 
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 15
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('signup');
                      },
                      child: Text(
                        'Signup',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary
                        ),
                      ) 
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),    
    );
  }
}