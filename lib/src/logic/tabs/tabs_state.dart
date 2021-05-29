part of 'tabs_bloc.dart';

abstract class TabsState extends Equatable {
  const TabsState();
  
  @override
  List<Object> get props => [];
}

class TabsInitial extends TabsState {
  final int activeTabIndex;

  TabsInitial({@required this.activeTabIndex});

  @override
  List<Object> get props => [activeTabIndex];
}
