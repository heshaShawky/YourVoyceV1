import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourvoyce/src/pages/splash/splash_page.dart';

import '../config/routes.dart';
import 'data/notifications_repository.dart';
import 'logic/authentication/authentication_bloc.dart';
import 'logic/notifications/notifications_bloc.dart';
import 'pages/home/home_page.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<bool> _loadingSplash;

  @override
  void initState() {
    _loadingSplash = Future.delayed(Duration(seconds: 8), () => true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'YourVoyce',
      theme: ThemeData(
        fontFamily: "Roboto",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white
      ),
      // initialRoute: 'home',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) async {
          if ( state is AuthenticationUnauthenticated ) {
            if ( await _loadingSplash ) {
              Navigator.pushReplacementNamed(context, 'intro');
            }
          } else if ( state is AuthenticationAuthenticated ) {
            // BlocProvider.of<NotificationsBloc>(context).add(InitiateGetUnreadNotificationsCount());
            // inspect(state);
            // if ( state.isELUABeenAccepted == false ) {
            //   inspect(state);

            //   Navigator.of(context).pushNamed('elua');
            // }
          }
        },
        builder: (context, state) {
          if ( state is AuthenticationUnauthenticated ) {
            return SplashScreen();
          } 
          // else if ( state is AuthenticationAuthenticated && !state.isELUABeenAccepted ) {
          //   inspect(state);
          //   return EluaPage();
          // }
          
          return HomePage();
        },
      ),
    );
  }
}
