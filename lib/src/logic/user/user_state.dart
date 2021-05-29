part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final AuthUser authUser;

  const UserLoaded({
    @required this.authUser
  });

  @override
  List<Object> get props => [authUser];
}

class UserError extends UserState {
  final ApiError error;

  const UserError({
    @required this.error
  });

  @override
  List<Object> get props => [error];
}
