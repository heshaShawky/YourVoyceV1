part of 'signup_form_bloc.dart';

abstract class SignupFormEvent extends Equatable {
  const SignupFormEvent();

  @override
  List<Object> get props => [];
}

// class FetchFormFields extends SignupFormEvent {}

class EmailChanged extends SignupFormEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class InviteCodeChanged extends SignupFormEvent {
  final String inviteCode;

  const InviteCodeChanged(this.inviteCode);

  @override
  List<Object> get props => [inviteCode];
}


class PasswordChanged extends SignupFormEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class RePasswordChanged extends SignupFormEvent {
  final String rePassword;

  const RePasswordChanged(this.rePassword);

  @override
  List<Object> get props => [rePassword];
}

class UsernameChanged extends SignupFormEvent {
  final String username;

  const UsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class FullNameChanged extends SignupFormEvent {
  final String fullName;

  const FullNameChanged(this.fullName);

  @override
  List<Object> get props => [fullName];
}

class TimezoneChanged extends SignupFormEvent {
  final String timezone;

  const TimezoneChanged(this.timezone);

  @override
  List<Object> get props => [timezone];
}

class LanguageChanged extends SignupFormEvent {
  final String language;

  const LanguageChanged(this.language);

  @override
  List<Object> get props => [language];
}

class SubmitSignupForm extends SignupFormEvent {}
