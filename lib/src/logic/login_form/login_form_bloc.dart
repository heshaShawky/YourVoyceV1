import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../user/user_bloc.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final UserBloc _userBloc;

  LoginFormBloc({
    @required UserBloc userBloc
  }) : _userBloc = userBloc, 
  super(LoginFormInitial());

  @override
  Future<void> close() async {
    await _userBloc?.close();
    return super.close();
  }

  @override
  Stream<LoginFormState> mapEventToState(
    LoginFormEvent event,
  ) async* {
    final currentState = state;

    if ( event is EmailChanged ) {
      if ( event.email == null || event.email.isEmpty || !event.email.contains('@') ) {
        yield currentState is LoginFormInitial 
          ? currentState.copyWith(
            isEmailValid: false
          ) 
          : LoginFormInitial(
            isEmailValid: false
          );

        return;
      }

      yield currentState is LoginFormInitial ? currentState.copyWith(
        email: event.email,
        isEmailValid: true
      ) : LoginFormInitial(
        email: event.email,
        isEmailValid: true
      );

    } else if ( event is PasswordChanged ) {
      if ( event.password == null || event.password.trim().isEmpty || event.password.length < 3 ) {
        yield currentState is LoginFormInitial 
          ? currentState.copyWith(
            isPasswordValid: false
          ) 
          : LoginFormInitial(
            isPasswordValid: false
          );

        return;
      }

      yield currentState is LoginFormInitial ? currentState.copyWith(
        password: event.password,
        isPasswordValid: true
      ) : LoginFormInitial(
        email: event.password,
        isPasswordValid: true
      );
    } else if ( event is SubmitLoginForm ) {
      if ( currentState is LoginFormInitial ) {
        if ( currentState.isFormValid ) {
          // here we login
          _userBloc.add(
            LoginByEmailAndPassword(
              email: currentState.email, 
              password: currentState.password
            )
          );
          return;
        }
        
        // yield LoginFormError(
        //   error: "The form is not valid, please check your email and password"
        // );
      }
    }


  }
}
