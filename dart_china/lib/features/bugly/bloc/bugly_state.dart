part of 'bugly_bloc.dart';

class BuglyState extends Equatable {
  const BuglyState({
    this.platformVersion = '',
    this.connected = false,
  });

  final String platformVersion;
  final bool connected;

  @override
  List<Object> get props => [connected];

  BuglyState copyWith({
    String? platformVersion,
    bool? connected,
  }) {
    return BuglyState(
      platformVersion: platformVersion ?? this.platformVersion,
      connected: connected ?? this.connected,
    );
  }
}
