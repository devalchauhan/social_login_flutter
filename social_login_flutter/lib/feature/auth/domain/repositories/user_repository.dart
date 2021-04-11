import 'package:dartz/dartz.dart';
import 'package:social_login_flitter/core/error/failure/failures.dart';
import 'package:social_login_flitter/feature/auth/domain/entities/auth_user.dart';

abstract class UserRepository {
  Future<Either<Failure, AuthUser>> getCurrentUser();
  Future<Either<Failure, AuthUser>> signIn();
  Future<Either<Failure, AuthUser>> signOut();
  Future<Either<Failure, AuthUser>> updateUser(AuthUser authUser);
  Future<Either<Failure, AuthUser>> fblogin();
  Future<Either<Failure, AuthUser>> linkedInLogin();
}
