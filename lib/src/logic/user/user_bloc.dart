import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/user_repository.dart';
import '../../models/api_error_model.dart';
import '../../models/auth_user_model.dart';
import '../authentication/authentication_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthenticationBloc _authenticationBloc;
  final UserRepository _authenticationRepository;
  
  UserBloc({
    @required UserRepository authenticationRepository,
    @required AuthenticationBloc authenticationBloc
  }) : _authenticationRepository = authenticationRepository,
  _authenticationBloc = authenticationBloc, 
  super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if ( event is LoginByEmailAndPassword ) {
      try {
        yield UserLoading();
        
        final AuthUser authUser =  await _authenticationRepository.loginByEmailAndPassword(
          email: event.email, 
          password: event.password
        );

        yield UserLoaded(
          authUser: authUser
        );

        await _authenticationRepository.saveUserId(authUser.body.user['user_id'].toString());

        _authenticationBloc.add(
          Login(
            token: authUser.body.oauthToken
          )
        );

      } catch (e) {
        // inspect(e);
        if ( e is ApiError )
          yield UserError(
            error: e
          );
      }
    } else if ( event is CreateNewUser ) {
      try {
        yield UserLoading();
        
        final AuthUser authUser = await _authenticationRepository.createNewUser(
          email: event.email, 
          password: event.password, 
          rePassword: event.rePassword, 
          username: event.username,
          fullName: event.fullName,
          inviteCode: event.inviteCode, 
          timezone: event.timezone, 
          language: event.language
        );

        yield UserLoaded(
          authUser: authUser
        );

        await _authenticationRepository.saveUserId(authUser.body.user['user_id'].toString());

        _authenticationBloc.add(
          Login(
            token: authUser.body.oauthToken
          )
        );

      } catch (e) {
        
        yield UserError(
          error: e
        );
      }
    }
  }
}
