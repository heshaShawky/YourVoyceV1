import 'package:flutter/material.dart';

import '../src/pages/home/home_page.dart';
import '../src/pages/intro/intro_page.dart';
import '../src/pages/login_form/login_form_page.dart';
import '../src/pages/singup_form/signup_form_page.dart';
import '../src/pages/splash/splash_page.dart';


class RouteGenerator {
  static final List _routes = [
    {
      "name": "intro",
      "screen": IntroPage()
    },
    {
      "name": "splash",
      "screen": SplashScreen()
    },
    {
      "name": "home",
      "screen": HomePage()
    },
    {
      "name": "login",
      "screen": LoginFormPage()
    },
    {
      "name": "signup",
      "screen": SignupFormPage()
    }
  ];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final arguments = settings.arguments;
    final List routes = RouteGenerator._routes;
    for (var i = 0; i < routes.length; i++) {
      if ( routes[i]['name'] == settings.name  ) {
        return MaterialPageRoute(
          builder: (context) => routes[i]['screen'],
          settings: RouteSettings(
            arguments: arguments,
            name: settings.name
          )
        );
      }
    }

    return MaterialPageRoute(
      builder: (context) => Container()
    );
  }
}