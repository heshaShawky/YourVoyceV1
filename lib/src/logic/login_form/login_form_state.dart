part of 'login_form_bloc.dart';

abstract class LoginFormState extends Equatable {
  const LoginFormState();
  
  @override
  List<Object> get props => [];
}

class LoginFormInitial extends LoginFormState {
  final String email;
  final bool isEmailValid;

  final String password;
  final bool isPasswordValid;

  bool get isFormValid => isEmailValid && isPasswordValid;

  const LoginFormInitial({
    String email,
    String password,

    bool isEmailValid,
    bool isPasswordValid
  }): email = email,
  password = password,
  isEmailValid = isEmailValid ?? false,
  isPasswordValid = isPasswordValid ?? false;

  LoginFormInitial copyWith({
    String email,
    String password,

    bool isEmailValid,
    bool isPasswordValid
  }) {
    return LoginFormInitial(
      email: email ?? this.email,
      password: password ?? this.password,

      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid
    );
  }

  @override
  List<Object> get props => [
    email, 
    password,
    isEmailValid,
    isPasswordValid
  ];
}

// class LoginFormError extends LoginFormState {
//   final String error;

//   const LoginFormError({
//     @required this.error
//   });

//   @override
//   List<Object> get props => [error];
// }