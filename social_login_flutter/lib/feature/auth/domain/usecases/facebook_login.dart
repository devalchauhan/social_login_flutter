import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:social_login_flitter/core/error/failure/failures.dart';
import 'package:social_login_flitter/core/usecases/usecase.dart';
import 'package:social_login_flitter/feature/auth/domain/entities/auth_user.dart';
import 'package:social_login_flitter/feature/auth/domain/repositories/user_repository.dart';

class FaceBookLogin implements UseCase<AuthUser, NoParams> {
  final UserRepository userRepository;

  FaceBookLogin({@required this.userRepository});

  @override
  Future<Either<Failure, AuthUser>> call(NoParams noParams) async {
    return await userRepository.getCurrentUser();
  }
}
