part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppInit extends AppEvent {}

class AppAuthChange extends AppEvent {
  final bool login;
  final User? user;

  AppAuthChange({
    required this.login,
    this.user,
  });
}

class AppCheckNotification extends AppEvent {}

class AppExit extends AppEvent {}

class AppShare extends AppEvent {
  final String url;
  final String? title;

  AppShare({
    required this.url,
    this.title,
  });
}
