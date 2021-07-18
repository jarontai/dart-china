part of 'about_bloc.dart';

class AboutState extends Equatable {
  const AboutState({
    this.appVersion = '',
    this.buildNumber = '',
  });

  final String appVersion;
  final String buildNumber;

  @override
  List<Object> get props => [appVersion, buildNumber];

  AboutState copyWith({
    String? appVersion,
    String? buildNumber,
  }) {
    return AboutState(
      appVersion: appVersion ?? this.appVersion,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }
}
