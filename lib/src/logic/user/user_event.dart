part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoginByEmailAndPassword extends UserEvent {
  final String email;
  final String password;

  const LoginByEmailAndPassword({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LoginByEmailAndPassword { email: $email, password: $password }';
}

class CreateNewUser extends UserEvent {
  final String email;
  final String password;
  final String rePassword;
  final String inviteCode;
  final String username;
  final String fullName;
  final String timezone;
  final String language;

  const CreateNewUser({
    this.email,
    this.password,
    this.rePassword,
    this.inviteCode,
    this.username,
    this.fullName,
    this.language,
    this.timezone
  });

  @override
  List<Object> get props => [
    email,
    password,
    rePassword,
    inviteCode,
    username,
    fullName,
    language,
    timezone
  ];

  // @override
  // String toString() => """
  //   Signup form submitted:
  //     email: $email,
  //     password: $password,
  //     rePassword: $rePassword,
  //     inviteCode: $inviteCode,
  //     username: $username,
  //     fullName: $fullName,
  //     language: $language,
  //     timezone: $timezone
  // """;
} 