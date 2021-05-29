part of 'tabs_bloc.dart';

abstract class TabsEvent extends Equatable {
  const TabsEvent();

  @override
  List<Object> get props => [];
}

class ChangeActiveTab extends TabsEvent {
  final int activeTabIndex;

  const ChangeActiveTab(this.activeTabIndex);

  @override
  List<Object> get props => [activeTabIndex];
}