part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String token;
  final bool isELUABeenAccepted;

  const AuthenticationAuthenticated({
    @required this.token,
    bool isELUABeenAccepted,
  }): isELUABeenAccepted = isELUABeenAccepted ?? false;

  AuthenticationAuthenticated copyWith({
    String token,
    bool isELUABeenAccepted,
  }) {
    return AuthenticationAuthenticated(
      token: token ?? this.token,
      isELUABeenAccepted: isELUABeenAccepted ?? isELUABeenAccepted
    );
  }

  @override
  List<Object> get props => [token, isELUABeenAccepted];
}

class AuthenticationUnauthenticated extends AuthenticationState {}