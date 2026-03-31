import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'main_state.dart';

@lazySingleton
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());

  void changeTab(int index) {
    emit(MainState(selectedTab: index));
  }
}
