part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class CheckLoggedEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class SignInEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class SignOutEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends UserEvent {
  final AuthUserModel authUserModel;

  UpdateUserEvent({@required this.authUserModel});

  @override
  List<Object> get props => [authUserModel];
}

class AuthSignInEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class FacebookSignInEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class LinkedInSignInEvent extends UserEvent {
  @override
  List<Object> get props => [];
}
