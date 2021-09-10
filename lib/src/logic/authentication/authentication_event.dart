part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class GetAuthenticationStatusOnAppStarting extends AuthenticationEvent {}

class Login extends AuthenticationEvent {
  final String token;

  const Login({
    @required this.token,
  });
  
  @override
  List<Object> get props => [token];
}

class AcceptELUA extends AuthenticationEvent {}

class Logout extends AuthenticationEvent {}