import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:yourvoyce/src/data/user_repository.dart';

import '../../models/api_error_model.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch(task) {
//       case Workmanager.iOSBackgroundTask:
//       case "GetUnreadNotificationsCount":
//         print('background task for fetching the notifications count every hour');

//         int randomNumber = Random().nextInt(10) + 1;
//         print(randomNumber);

//         print('support for app badger ${await FlutterAppBadger.isAppBadgeSupported()}');

//         final NotificationsNewUpdate notificationsNewUpdate = await NotificationsRepositoryImpl().getUnreadNotificationsCount();

//         // print(notificationsNewUpdate.body.notifications);
        
//         FlutterAppBadger.updateBadgeCount(notificationsNewUpdate.body.notifications);

//         // NotificationsBloc(notificationsRepository: NotificationsRepositoryImpl()).add(
//         //   GetUnreadNotificationsCount()
//         // );
//         break;
//     }

//     return Future.value(true);
//   });
// }

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // final InAppWebViewController _inAppWebViewController;
  final UserRepository _userRepository;
  
  NotificationsBloc({
    // @required InAppWebViewController inAppWebViewController,
    @required UserRepository userRepository
  })  : _userRepository = userRepository, super(NotificationsInitial());

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
// 
    if ( event is InitiateNotifications ) {
      await OneSignal.shared.init('9d9b7bbe-9828-42af-a412-e8744ebbc14e');

      OneSignal.shared.setInFocusDisplayType(
        OSNotificationDisplayType.notification
      );
    } else if ( event is SetNotifcationsSetting ) {


      OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
        // inspect(result.notification.payload.additionalData);

        final String actionUrl = result.notification.payload.additionalData['webURL'];
        // log('test');
        // log(actionUrl);
        // inspect(_inAppWebViewController);

        if ( actionUrl != null && actionUrl.isNotEmpty) {
          await event.inAppWebViewController.loadUrl(url: actionUrl);
        }

        
      });

      if ( await _userRepository.getUserId() != null  ) {
        print('set user id ' + await _userRepository.getUserId());
        OneSignal.shared.setExternalUserId(await _userRepository.getUserId()).then((value) => print(value.toString()));
      } 
    }


  //   if ( event is InitiateGetUnreadNotificationsCount ) {
  //     if ( Platform.isAndroid ) {
  //       print('support for app badger ${await FlutterAppBadger.isAppBadgeSupported()}');

  //       final NotificationsNewUpdate notificationsNewUpdate = await NotificationsRepositoryImpl().getUnreadNotificationsCount();
  //       FlutterAppBadger.updateBadgeCount(notificationsNewUpdate.body.notifications);

  //       await Workmanager().registerPeriodicTask(
  //         '1',
  //         'GetUnreadNotificationsCount',
  //         initialDelay: Duration(seconds: 10),
  //         frequency: Duration(hours: 1),
  //       );

  //       return; 
  //     }

  //     await Workmanager().initialize(
  //       callbackDispatcher,
  //       isInDebugMode: false,
  //     );

  //     final NotificationsNewUpdate notificationsNewUpdate = await NotificationsRepositoryImpl().getUnreadNotificationsCount();
      
  //     FlutterAppBadger.updateBadgeCount(notificationsNewUpdate.body.notifications);

  //   } else if ( event is GetUnreadNotificationsCount ) {
  //     try {
  //       yield NotificationsLoading();
  
  //       final NotificationsNewUpdate notificationsNewUpdate = await _notificationsRepository.getUnreadNotificationsCount();
  //       print( json.encode(notificationsNewUpdate) );
  //       int randomNumber = Random().nextInt(10) + 1;
  //       print(randomNumber);
  //       print(FlutterAppBadger.isAppBadgeSupported());
  //       FlutterAppBadger.updateBadgeCount(randomNumber);

  //       yield NotificationsLoaded(
  //         unreadNotificationsCount: randomNumber
  //       );
  //     } catch (e) {
  //       print(e.toString());
  //       // inspect(e);
  //       // yield NotificationsError(
  //       //   error: e
  //       // );
  //     }
  //   }
  }


}
