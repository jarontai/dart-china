part of 'bugly_bloc.dart';

abstract class BuglyEvent extends Equatable {
  const BuglyEvent();

  @override
  List<Object> get props => [];
}

class BuglyInit extends BuglyEvent {
  final bool enableDebug;
  final String androidAppId;
  final String iosAppId;

  BuglyInit({
    this.enableDebug = false,
    this.androidAppId = '',
    this.iosAppId = '',
  });
}

class BuglyInitExtra extends BuglyEvent {}
