part of 'global_cubit.dart';

class GlobalState {
  final bool userLogin;
  final User? user;
  final Map<int, Category>? categoryMap;

  GlobalState({
    this.userLogin = false,
    this.user,
    this.categoryMap,
  });

  GlobalState copyWith({
    bool? userLogin,
    User? user,
    Map<int, Category>? categoryMap,
  }) {
    return GlobalState(
      userLogin: userLogin ?? this.userLogin,
      user: user ?? this.user,
      categoryMap: categoryMap ?? this.categoryMap,
    );
  }
}
