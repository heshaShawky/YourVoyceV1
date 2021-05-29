import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  
  AuthenticationBloc({
    @required UserRepository userRepository
  }) : _userRepository = userRepository, super(AuthenticationUnauthenticated());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if ( event is GetAuthenticationStatusOnAppStarting ) {
      final bool isUserAuthenticated = await _userRepository.hasToken();

      if ( isUserAuthenticated ) {
        final String token = await _userRepository.getToken();

        yield AuthenticationAuthenticated(
          token: token
        );
        return;
      }

      yield AuthenticationUnauthenticated();
    } else if ( event is Login ) {
      try {
        await _userRepository.persistToken(token: event.token);
        yield AuthenticationAuthenticated(
          token: event.token
        );
      } catch (e) {
        print(e.toString());
      }
    } else if ( event is Logout ) {
      try {
        yield AuthenticationUnauthenticated();    
        
        await _userRepository.logout();
       
      } catch (e) {
        print(e);
      }
    }
  }
}
