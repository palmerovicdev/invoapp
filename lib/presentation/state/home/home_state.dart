part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.theme,
  });

  final Theme theme;

  @override
  List<Object?> get props => [theme];

  HomeState copyWith({
    Theme? theme,
  }) {
    return HomeState(
      theme: theme ?? this.theme,
    );
  }
}
