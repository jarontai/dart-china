part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppInit extends AppEvent {}

class AppHome extends AppEvent {}

class AppExit extends AppEvent {}

class AppShare extends AppEvent {
  final String url;
  final String? title;

  AppShare({
    required this.url,
    this.title,
  });
}
