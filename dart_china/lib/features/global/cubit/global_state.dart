part of 'global_cubit.dart';

class GlobalState {
  final bool userLogin;
  final bool hasNotification;
  final User? user;
  final Map<int, Category>? categoryMap;

  GlobalState({
    this.userLogin = false,
    this.hasNotification = false,
    this.user,
    this.categoryMap,
  });

  GlobalState copyWith({
    bool? userLogin,
    bool? hasNotification,
    User? user,
    Map<int, Category>? categoryMap,
  }) {
    return GlobalState(
      userLogin: userLogin ?? this.userLogin,
      hasNotification: hasNotification ?? this.hasNotification,
      user: user ?? this.user,
      categoryMap: categoryMap ?? this.categoryMap,
    );
  }
}
