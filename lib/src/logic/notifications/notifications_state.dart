part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
  
  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final int unreadNotificationsCount;

  const NotificationsLoaded({
    @required this.unreadNotificationsCount
  });

  @override
  List<Object> get props => [unreadNotificationsCount];
}

class NotificationsError extends NotificationsState {
  final ApiError error;

  const NotificationsError({
    @required this.error
  });

  @override
  List<Object> get props => [error];
}


