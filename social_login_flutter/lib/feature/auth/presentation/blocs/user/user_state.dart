part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserNotLoggedState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoggedState extends UserState {
  final AuthUser user;

  UserLoggedState({this.user});

  @override
  List<Object> get props => [user];
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserUpdateSuccessState extends UserState {
  @override
  List<Object> get props => [];
}

class UserUpdateFailState extends UserState {
  @override
  List<Object> get props => [];
}
