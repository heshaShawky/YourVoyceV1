import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

import '../../data/notifications_repository.dart';
import '../../models/api_error_model.dart';
import '../../models/notifications_new_update.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch(task) {
      case Workmanager.iOSBackgroundTask:
      case "GetUnreadNotificationsCount":
        print('background task for fetching the notifications count every hour');

        int randomNumber = Random().nextInt(10) + 1;
        print(randomNumber);

        print('support for app badger ${await FlutterAppBadger.isAppBadgeSupported()}');

        final NotificationsNewUpdate notificationsNewUpdate = await NotificationsRepositoryImpl().getUnreadNotificationsCount();

        print(notificationsNewUpdate.body.notifications);
        
        FlutterAppBadger.updateBadgeCount(notificationsNewUpdate.body.notifications);

        // NotificationsBloc(notificationsRepository: NotificationsRepositoryImpl()).add(
        //   GetUnreadNotificationsCount()
        // );
        break;
    }

    return Future.value(true);
  });
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository _notificationsRepository;
  
  NotificationsBloc({
    @required NotificationsRepository notificationsRepository
  }) : _notificationsRepository = notificationsRepository, super(NotificationsInitial());

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if ( event is InitiateGetUnreadNotificationsCount ) {
      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: false,
      );

      FlutterAppBadger.updateBadgeCount(6);

      if ( Platform.isAndroid ) {
        await Workmanager().registerPeriodicTask(
          '1',
          'GetUnreadNotificationsCount',
          initialDelay: Duration(seconds: 10),
          frequency: Duration(hours: 1)
        );
      }
      
      

    } else if ( event is GetUnreadNotificationsCount ) {
      try {
        yield NotificationsLoading();
  
        final NotificationsNewUpdate notificationsNewUpdate = await _notificationsRepository.getUnreadNotificationsCount();
        print( json.encode(notificationsNewUpdate) );
        int randomNumber = Random().nextInt(10) + 1;
        print(randomNumber);
        print(FlutterAppBadger.isAppBadgeSupported());
        FlutterAppBadger.updateBadgeCount(randomNumber);

        yield NotificationsLoaded(
          unreadNotificationsCount: randomNumber
        );
      } catch (e) {
        print(e.toString());
        // inspect(e);
        // yield NotificationsError(
        //   error: e
        // );
      }
    }
  }


}
