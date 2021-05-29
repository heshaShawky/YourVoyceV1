


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_error_model.dart';
import '../models/auth_user_model.dart';
import 'api_provider.dart';


abstract class UserRepository {
  Future<AuthUser> loginByEmailAndPassword({
    @required String email,
    @required String password, 
  });
  // Future<dynamic> getSignupFormFields();
  Future<AuthUser> createNewUser({
    @required String email,
    @required String password,
    @required String rePassword,
    @required String username,
    @required String fullName,
    @required String inviteCode,
    @required String timezone,
    @required String language
  });
  Future<bool> persistToken({@required String token});
  Future<String> getToken();
  // Future<bool> _deleteToken();
  Future<void> logout();
  Future<bool> hasToken();
}

class UserRepositoryImpl extends ApiProvider implements UserRepository {
  Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  

  @override
  Future<AuthUser> loginByEmailAndPassword({
    @required String email,
    @required String password, 
  }) async {
    try {
      
      final dynamic response = await this.post(
        path: 'api/rest/login',
        data: {
          "email": email,
          "password": password,
          "ip": "192.168.1.1"
        }
      );
      
      if ( response['error'] == true ) {
        throw ApiError.fromJson(response);
      }

      return AuthUser.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> persistToken({@required String token}) async {
    try {
      (await _sharedPreferences).setString('token', token);
      
      return true;
    } catch (e) {
      throw e['message'].toString();
    }
  }

  @override
  Future<bool> hasToken() async {
    
    final String token = (await _sharedPreferences).getString('token');

    return token != null ? true : false ;
  }

  @override
  Future<AuthUser> createNewUser({
    @required String email,
    @required String password,
    @required String rePassword,
    @required String username,
    @required String fullName,
    @required String inviteCode,
    @required String timezone,
    @required String language
  }) async {
    try {
      final dynamic response = await this.post(
        path: 'api/rest/signup',
        data: <dynamic, String>{
          "email": email,
          "password": password,
          "passconf": rePassword,
          "username": username,
          "timezone": timezone,
          "language": language,
          "code": inviteCode,
          "1_1_3_alias_first_name": fullName.split(' ')[0],
          "1_1_4_alias_last_name": fullName.split(' ').length > 1 ? fullName.split(' ')[1]: '',
          "ip": "192.168.1.1"
        }
      );

      if ( response['error'] == true ) {
        throw ApiError.fromJson(response);
      }

      return AuthUser.fromJson(response);  
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final String token = (await _sharedPreferences).getString('token');

      return token;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> _deleteToken() async {
    try {
      return (await _sharedPreferences).remove('token');
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      final String token = await getToken();

      await this.post(
        path: 'api/rest/logout',
        queryParameters: {
          "oauth_token": token
        }
      );

      await _deleteToken();

      // return await _deleteToken();
    } catch (e) {
      throw e;
    }
  }

  // @override
  // Future getSignupFormFields() async {
  //   try {
  //     final formFields  = await this.get(
  //       path: 'api/rest/signup',
  //     );

  //     return formFields;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}