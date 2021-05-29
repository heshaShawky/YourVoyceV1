part of 'signup_form_bloc.dart';

abstract class SignupFormState extends Equatable {
  const SignupFormState();
  
  @override
  List<Object> get props => [];
}

class SignupFormInitial extends SignupFormState {
  final String email;
  final bool isEmailValid;

  final String username;
  final bool isUsernameValid;

  final String fullName;
  final bool isFullNameValid;

  final String inviteCode;
  final bool isInviteCodeValid;

  final String password;
  final bool isPasswordValid;

  final String rePassword;
  final bool isRePasswordValid;

  final String timezone;
  final bool isTimezoneValid;

  final String language;
  final bool isLanguageValid;

  final String error;

  bool isFormValid() {
    return ![
      this.isEmailValid,
      this.isInviteCodeValid,
      this.isUsernameValid,
      this.isPasswordValid,
      this.isFullNameValid,
      this.isRePasswordValid,
      this.isLanguageValid,
      this.isTimezoneValid,
    ].contains(false);
  }


  const SignupFormInitial({
    String email,
    bool isEmailValid,
    String username,
    bool isUsernameValid,
    String fullName,
    bool isFullNameValid,
    String inviteCode,
    bool isInviteCodeValid,
    String password,
    bool isPasswordValid,
    String rePassword,
    bool isRePasswordValid,
    String timezone,
    bool isTimezoneValid,
    String language,
    bool isLanguageValid,
    String error
  }): email = email,
    isEmailValid = isEmailValid ?? false,
    username = username,
    isUsernameValid = isUsernameValid ?? false,
    fullName = fullName,
    isFullNameValid = isFullNameValid ?? false,
    inviteCode = inviteCode,
    isInviteCodeValid = isInviteCodeValid ?? false,
    password = password,
    isPasswordValid  = isPasswordValid ?? false,
    rePassword = rePassword,
    isRePasswordValid = isRePasswordValid ?? false,
    timezone = timezone,
    isTimezoneValid = isTimezoneValid ?? false,
    language = language ?? 'en',
    isLanguageValid = isLanguageValid ?? true,
    error = error;

  SignupFormInitial copyWith({
    String email,
    bool isEmailValid,
    String username,
    bool isUsernameValid,
    String fullName,
    bool isFullNameValid,
    String inviteCode,
    bool isInviteCodeValid,
    String password,
    bool isPasswordValid,
    String rePassword,
    bool isRePasswordValid,
    String timezone,
    bool isTimezoneValid,
    String language,
    bool isLanguageValid,
    String error
  }) {
    return SignupFormInitial(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      username: username ?? this.username,
      isUsernameValid:  isUsernameValid ?? this.isUsernameValid,
      fullName: fullName ?? this.fullName,
      isFullNameValid: isFullNameValid ?? this.isFullNameValid,
      inviteCode: inviteCode ?? this.inviteCode,
      isInviteCodeValid: isInviteCodeValid ?? this.isInviteCodeValid,
      password: password ?? this.password,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      rePassword:  rePassword ?? this.rePassword,
      isRePasswordValid: isRePasswordValid ?? this.isRePasswordValid,
      timezone: timezone ?? this.timezone,
      isTimezoneValid: isTimezoneValid ?? this.isTimezoneValid,
      language: language ?? this.language,
      isLanguageValid: isLanguageValid ?? this.isLanguageValid,
      error: error ?? this.error
    );
  }

  @override
  List<Object> get props => [
    email,
    isEmailValid,
    username,
    isUsernameValid,
    fullName,
    isFullNameValid,
    inviteCode,
    isInviteCodeValid,
    password,
    isPasswordValid,
    rePassword,
    isRePasswordValid,
    timezone,
    isTimezoneValid,
    language,
    isLanguageValid,
    error
  ];

}

// class SignupFormLoading extends SignupFormState {}

// class SignupFormLoaded extends SignupFormState {
//   final dynamic formFields;

//   const SignupFormLoaded({
//     @required this.formFields
//   });

//   @override
//   List<Object> get props => [formFields];
// }

// class SignupFormError extends SignupFormState {
//   final String error;

//   const SignupFormError({
//     @required this.error
//   });

//   @override
//   List<Object> get props => [error];

//   @override
//   String toString() => 'error message: $error';
// }

