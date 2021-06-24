part of 'app_cubit.dart';

class AppState {
  final bool userLogin;
  final bool hasNotification;
  final User? user;
  final Map<int, Category>? categoryMap;

  AppState({
    this.userLogin = false,
    this.hasNotification = false,
    this.user,
    this.categoryMap,
  });

  AppState copyWith({
    bool? userLogin,
    bool? hasNotification,
    User? user,
    Map<int, Category>? categoryMap,
  }) {
    return AppState(
      userLogin: userLogin ?? this.userLogin,
      hasNotification: hasNotification ?? this.hasNotification,
      user: user ?? this.user,
      categoryMap: categoryMap ?? this.categoryMap,
    );
  }
}
