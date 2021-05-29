import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../user/user_bloc.dart';

part 'signup_form_event.dart';
part 'signup_form_state.dart';

class SignupFormBloc extends Bloc<SignupFormEvent, SignupFormState> {
  // final AuthenticationRepository _authenticationRepository;
  final UserBloc _userBloc;

  SignupFormBloc({
    @required UserBloc userBloc,
  }) : _userBloc = userBloc,
    super(SignupFormInitial());

  // @override
  // Future<void> close() async {
  //   await _userBloc?.close();
  //   return super.close();
  // }

  @override
  Stream<SignupFormState> mapEventToState(
    SignupFormEvent event,
  ) async* {

    final currentState = state;

    if ( event is EmailChanged ) {

      if ( event.email == null || event.email.isEmpty || !event.email.contains('@') ) {
        yield currentState is SignupFormInitial 
          ? currentState.copyWith(
            isEmailValid: false
          ) 
          : SignupFormInitial(
            isEmailValid: false
          );

        return;
      }

      yield currentState is SignupFormInitial ? currentState.copyWith(
        email: event.email,
        isEmailValid: true
      ) : SignupFormInitial(
        email: event.email,
        isEmailValid: true
      );

    } else if ( event is InviteCodeChanged ) {

      if ( event.inviteCode == null || event.inviteCode.trim().isEmpty || event.inviteCode.trim().length <= 2 ) {
        yield currentState is SignupFormInitial ? currentState.copyWith(
          isInviteCodeValid: false
        ) : SignupFormInitial(
          isInviteCodeValid: false
        );
        return;
      }

      yield currentState is SignupFormInitial ? currentState.copyWith(
        inviteCode: event.inviteCode,
        isInviteCodeValid: true
      ) : SignupFormInitial(
        inviteCode: event.inviteCode,
        isInviteCodeValid: true
      );
      
    } else if ( event is UsernameChanged ) {

      if ( event.username == null || event.username.trim().isEmpty || event.username.trim().length <= 2 ) {
        yield currentState is SignupFormInitial ? currentState.copyWith(
          isUsernameValid: false
        ) : SignupFormInitial(
          isUsernameValid: false
        );
        return;
      }

      yield currentState is SignupFormInitial ? currentState.copyWith(
        username: event.username,
        isUsernameValid: true
      ) : SignupFormInitial(
        username: event.username,
        isUsernameValid: true
      );

    } else if ( event is FullNameChanged ) {

      if ( event.fullName == null || event.fullName.trim().isEmpty || event.fullName.trim().length <= 2 ) {
        yield currentState is SignupFormInitial ? currentState.copyWith(
          isFullNameValid: false
        ) : SignupFormInitial(
          isFullNameValid: false
        );
        return;
      }

      yield currentState is SignupFormInitial ? currentState.copyWith(
        fullName: event.fullName,
        isFullNameValid: true
      ) : SignupFormInitial(
        fullName: event.fullName,
        isFullNameValid: true
      );

    } else if ( event is PasswordChanged ) {

      if ( event.password == null || event.password.trim().isEmpty || event.password.trim().length <= 2 ) {
        yield currentState is SignupFormInitial ? currentState.copyWith(
          isPasswordValid: false
        ) : SignupFormInitial(
          isUsernameValid: false
        );
        return;
      }

      yield currentState is SignupFormInitial ? currentState.copyWith(
        password: event.password,
        isPasswordValid: true
      ) : SignupFormInitial(
        username: event.password,
        isPasswordValid: true
      );

    } else if ( event is RePasswordChanged ) {

      if ( currentState is SignupFormInitial ) {

        if ( event.rePassword == null || event.rePassword != currentState.password ) {
          yield currentState.copyWith(
            isRePasswordValid: false
          );

          return;
        }

        yield currentState.copyWith(
          rePassword: event.rePassword,
          isRePasswordValid: true
        );
        return;
      }

      yield SignupFormInitial(
        isRePasswordValid: false
      );

    } else if ( event is TimezoneChanged ) {

      if ( event.timezone == null || event.timezone.trim().isEmpty ) {
        yield currentState is SignupFormInitial ? currentState.copyWith(
          isTimezoneValid: false
        ) : SignupFormInitial(
          isTimezoneValid: false
        );
        return;
      }

      yield currentState is SignupFormInitial ? currentState.copyWith(
        timezone: event.timezone,
        isTimezoneValid: true
      ) : SignupFormInitial(
        timezone: event.timezone,
        isTimezoneValid: true
      );

    } else if ( event is LanguageChanged) {
      if ( event.language == null || event.language.trim().isEmpty ) {
        yield currentState is SignupFormInitial ? currentState.copyWith(
          isLanguageValid: false
        ) : SignupFormInitial(
          isLanguageValid: false
        );
        return;
      }

      yield currentState is SignupFormInitial ? currentState.copyWith(
        language: event.language,
        isLanguageValid: true
      ) : SignupFormInitial(
        language: event.language,
        isLanguageValid: true
      );
    } else if ( event is SubmitSignupForm ) {
      if ( currentState is SignupFormInitial ) {
        // print(currentState.isEmailValid);
        // inspect(SignupFormInitial);
        if ( currentState.isFormValid() ) {
        _userBloc.add(
          CreateNewUser(
            email: currentState.email,
            username: currentState.username,
            fullName: currentState.fullName,
            inviteCode: currentState.inviteCode,
            password: currentState.password,
            rePassword: currentState.rePassword,
            language: currentState.language,
            timezone: currentState.timezone
          )
        );
          return;
        }

        yield currentState.copyWith(
          error: 'The form not valid, one or many of the field is missing'
        );
        return;
      }

      // yield SignupFormInitial(
      //   error: 'The form not valid, one or many of the field is missing'
      // );


    }


  }
}
