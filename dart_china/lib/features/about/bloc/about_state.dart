part of 'about_bloc.dart';

class AboutState extends Equatable {
  const AboutState({
    this.appVersion = '',
  });

  final String appVersion;

  @override
  List<Object> get props => [appVersion];

  AboutState copyWith({
    String? appVersion,
  }) {
    return AboutState(
      appVersion: appVersion ?? this.appVersion,
    );
  }
}
