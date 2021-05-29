import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  TabsBloc() : super(TabsInitial(
    activeTabIndex: 0
  ));

  @override
  Stream<TabsState> mapEventToState(
    TabsEvent event,
  ) async* {
    if ( event is ChangeActiveTab ) {
      yield TabsInitial(activeTabIndex: event.activeTabIndex);
    }
  }
}
