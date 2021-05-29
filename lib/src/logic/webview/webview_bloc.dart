import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'webview_event.dart';
part 'webview_state.dart';

class WebviewBloc extends Bloc<WebviewEvent, WebviewState> {
  WebviewBloc() : super(WebviewInitial());

  @override
  Stream<WebviewState> mapEventToState(
    WebviewEvent event,
  ) async* {
    if ( event is WebviewStart ) {
      yield WebviewInitial(url: event.url);
      if (event.progress < 1) {
        yield WebviewLoading(event.progress);
      } else {
        yield WebviewLoaded();
      }
    } else if ( event is WebviewErrorOccured ) {
      yield WebviewError();
    }
  }
}
