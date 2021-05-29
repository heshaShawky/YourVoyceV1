import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../models/api_error_model.dart';

class ApiProvider {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConfigration.baseUrl,
      queryParameters: {
        "oauth_consumer_key": AppConfigration.consumerKey,
        "oauth_consumer_secret": AppConfigration.consumerSecret
      }
    )
  );

   Future<dynamic> post({
    @required String path,
    dynamic data,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
  }) async {
    try {
      data ??= {};
      headers ??= {};
      queryParameters ??= {};

      final Response response = await dio.post(
        path,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioError catch (ex) {
      throw Exception(_handleError(ex));
    }
  }

  Future<dynamic> get({
    @required String path,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
  }) async {
    try {

      headers ??= {};
      queryParameters ??= {};

      final Response response = await dio.get(
        path,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioError catch (ex) {
      throw Exception(_handleError(ex));
    }
  }

  Future<dynamic> patch({
    @required String path,
    dynamic data,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
  }) async {

    try {

      data ??= {};
      headers ??= {};
      queryParameters ??= {};
      
      final Response response = await dio.patch(
        path,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParameters,
      );

      return jsonDecode(response.data);
    } on DioError catch (ex) {
      throw Exception(_handleError(ex));
    }
  }

  Future<dynamic> delete({
    @required String path,
    dynamic data,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
  }) async {
    try {
      data ??= {};
      headers ??= {};
      queryParameters ??= {};

      final Response response = await dio.delete(
        path,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioError catch (ex) {
      return _handleError(ex);
    }
  }

  ApiError _handleError( DioError error ) {
    if ( error.type == DioErrorType.RESPONSE ) {
      return error.response.data['message'];
    }

    return ApiError.fromJson(error.error);
  }
}