import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoapp/core/theme/theme.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(theme: Theme.themes[Theme.currentThemeIndex])) {
    on<HomeEvent>((event, emit) {});
  }
}
