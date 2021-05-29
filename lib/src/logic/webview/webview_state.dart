part of 'webview_bloc.dart';

abstract class WebviewState {
  const WebviewState();
  
  // @override
  // List<Object> get props => [];
}

class WebviewInitial extends WebviewState {
  final String url;

  const WebviewInitial({this.url});
}

class WebviewLoading extends WebviewState {
  final double progress;

  const WebviewLoading(this.progress);

  // @override
  // List<Object> get props => [progress];
}

class WebviewLoaded extends WebviewState {}

class WebviewError extends WebviewState {}