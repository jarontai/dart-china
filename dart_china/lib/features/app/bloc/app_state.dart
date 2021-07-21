part of 'app_bloc.dart';

class AppState extends Equatable {
  final bool userLogin;
  final User? user;
  final bool hasNotification;
  final Map<int, Category>? categoryMap;

  AppState({
    this.userLogin = false,
    this.user,
    this.hasNotification = false,
    this.categoryMap,
  });

  AppState copyWith({
    bool? userLogin,
    User? user,
    bool? hasNotification,
    Map<int, Category>? categoryMap,
  }) {
    return AppState(
      userLogin: userLogin ?? this.userLogin,
      hasNotification: hasNotification ?? this.hasNotification,
      user: user ?? this.user,
      categoryMap: categoryMap ?? this.categoryMap,
    );
  }

  @override
  List<Object?> get props => [userLogin, hasNotification, user];
}
