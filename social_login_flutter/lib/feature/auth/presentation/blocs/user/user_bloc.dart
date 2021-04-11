import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:social_login_flitter/core/usecases/usecase.dart';
import 'package:social_login_flitter/feature/auth/data/models/auth_user_model.dart';
import 'package:social_login_flitter/feature/auth/domain/entities/auth_user.dart';
import 'package:social_login_flitter/feature/auth/domain/usecases/get_current_user.dart';
import 'package:social_login_flitter/feature/auth/domain/usecases/sign_in.dart';
import 'package:social_login_flitter/feature/auth/domain/usecases/sign_out.dart';
import 'package:social_login_flitter/feature/auth/domain/usecases/update_user.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUser getCurrentUser;
  final SignIn signIn;
  final SignOut signOut;
  final UpdateUser updateUser;

  UserBloc(
      {@required this.getCurrentUser,
      @required this.signIn,
      @required this.signOut,
      @required this.updateUser})
      : super(UserNotLoggedState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is CheckLoggedEvent) {
      yield UserLoadingState();
      final userFailedOrSuccess = await getCurrentUser(NoParams());
      yield userFailedOrSuccess.fold(
        (l) => UserNotLoggedState(),
        (r) => UserLoggedState(user: r),
      );
    }

    if (event is SignInEvent) {
      yield UserLoadingState();
      final userSignInFailedOrSuccess = await signIn(NoParams());
      yield userSignInFailedOrSuccess.fold(
        (l) => UserNotLoggedState(),
        (r) => UserLoggedState(user: r),
      );
    }

    if (event is SignOutEvent) {
      yield UserLoadingState();
      final userSignInFailedOrSuccess = await signOut(NoParams());
      yield userSignInFailedOrSuccess.fold(
        (l) => UserNotLoggedState(),
        (r) => UserLoggedState(user: r),
      );
    }

    if (event is UpdateUserEvent) {
      yield UserLoadingState();
      final updateUserFailedOrSuccess =
          await updateUser(UpdateUserParams(authUser: event.authUserModel));
      yield updateUserFailedOrSuccess.fold(
        (l) => UserUpdateFailState(),
        (r) => UserUpdateSuccessState(),
      );
    }
  }

  @override
  void onTransition(Transition<UserEvent, UserState> transition) {
    print("UserBloc : $transition");
    super.onTransition(transition);
  }
}
