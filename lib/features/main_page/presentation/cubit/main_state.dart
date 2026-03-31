part of 'main_cubit.dart';

class MainState extends Equatable {
  final int selectedTab;
  const MainState({this.selectedTab = 0});
  @override
  List<Object> get props => [selectedTab];
}

class MainInitial extends MainState {
  const MainInitial({required super.selectedTab});
}
