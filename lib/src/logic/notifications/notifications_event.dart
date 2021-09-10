part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class InitiateNotifications extends NotificationsEvent {}

// SetNotifcationsSetting

class SetNotifcationsSetting extends NotificationsEvent {
  final InAppWebViewController inAppWebViewController;

  SetNotifcationsSetting(this.inAppWebViewController);



}


// class InitiateGetUnreadNotificationsCount extends NotificationsEvent {}
// class GetUnreadNotificationsCount extends NotificationsEvent {}