import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:social_login_flitter/core/error/failure/failures.dart';
import 'package:social_login_flitter/core/usecases/usecase.dart';
import 'package:social_login_flitter/feature/auth/domain/entities/auth_user.dart';
import 'package:social_login_flitter/feature/auth/domain/repositories/user_repository.dart';

class UpdateUser implements UseCase<AuthUser, UpdateUserParams> {
  final UserRepository userRepository;

  UpdateUser({@required this.userRepository});

  @override
  Future<Either<Failure, AuthUser>> call(
      UpdateUserParams updateUserParams) async {
    return await userRepository.updateUser(updateUserParams.authUser);
  }
}

class UpdateUserParams extends Equatable {
  final AuthUser authUser;

  UpdateUserParams({@required this.authUser});

  @override
  List<Object> get props => [authUser];
}
