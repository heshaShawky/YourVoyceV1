import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourvoyce/src/logic/notifications/notifications_bloc.dart';

import 'src/app.dart';
import 'src/data/user_repository.dart';
import 'src/logic/authentication/authentication_bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    log(event.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }
  
  @override
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    super.onError(cubit, error, stacktrace);
    log('Error: $error');
  }
}




void main() {
  Bloc.observer = SimpleBlocDelegate();

  
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            userRepository: UserRepositoryImpl()
          )..add(
            GetAuthenticationStatusOnAppStarting()
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => NotificationsBloc(
            userRepository: UserRepositoryImpl()
          )..add(
            InitiateNotifications()
          )
        ),
      ],
      child: MyApp(),
    )
  );
}

