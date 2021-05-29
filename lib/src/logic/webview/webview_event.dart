part of 'webview_bloc.dart';

abstract class WebviewEvent extends Equatable {
  const WebviewEvent();

  @override
  List<Object> get props => [];
}

class WebviewStart extends WebviewEvent {
  final double progress;
  final String url;

  const WebviewStart({@required this.progress, this.url});

  @override
  List<Object> get props => [ progress, url ];
}

class WebviewErrorOccured extends WebviewEvent {}