part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppOpen extends AppEvent {}

class AppHome extends AppEvent {}

class AppExit extends AppEvent {}
