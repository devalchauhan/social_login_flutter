import 'package:dartz/dartz.dart';
import 'package:social_login_flitter/core/error/exceptions/exceptions.dart';
import 'package:social_login_flitter/core/error/failure/failures.dart';
import 'package:social_login_flitter/feature/auth/data/datasources/user_remote_data_source.dart';
import 'package:social_login_flitter/feature/auth/data/models/auth_user_model.dart';
import 'package:social_login_flitter/feature/auth/domain/entities/auth_user.dart';
import 'package:social_login_flitter/feature/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({this.userRemoteDataSource});

  @override
  Future<Either<Failure, AuthUser>> getCurrentUser() async {
    try {
      final AuthUserModel _currentUser =
          await userRemoteDataSource.getCurrentUser();
      return Right(_currentUser);
    } on AuthException {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signIn() async {
    try {
      final AuthUserModel _currentUser = await userRemoteDataSource.signIn();
      return Right(_currentUser);
    } on AuthException {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signOut() async {
    try {
      final AuthUserModel _currentUser = await userRemoteDataSource.signOut();
      return Right(_currentUser);
    } on AuthException {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, AuthUser>> updateUser(AuthUser authUser) async {
    try {
      final AuthUserModel _currentUser =
          await userRemoteDataSource.updateUser(authUser);
      return Right(_currentUser);
    } on AuthException {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, AuthUser>> fblogin() async {
    try {
      final AuthUserModel _currentUser = await userRemoteDataSource.fblogin();
      return Right(_currentUser);
    } on AuthException {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, AuthUser>> linkedInLogin() async {
    try {
      final AuthUserModel _currentUser =
          await userRemoteDataSource.linkedinLogin();
      return Right(_currentUser);
    } on AuthException {
      return Left(AuthFailure());
    }
  }
}
