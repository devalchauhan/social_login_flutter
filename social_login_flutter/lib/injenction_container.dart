import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:social_login_flitter/feature/auth/domain/usecases/sign_in.dart';
import 'package:social_login_flitter/feature/auth/domain/usecases/sign_out.dart';
import 'package:social_login_flitter/feature/auth/presentation/blocs/user/user_bloc.dart';
import 'package:social_login_flitter/feature/auth/domain/usecases/get_current_user.dart';

import 'feature/auth/data/datasources/user_remote_data_source.dart';
import 'feature/auth/data/repositories/user_repository_impl.dart';
import 'feature/auth/domain/repositories/user_repository.dart';
import 'feature/auth/domain/usecases/update_user.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => UserBloc(
        getCurrentUser: sl(), signIn: sl(), signOut: sl(), updateUser: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCurrentUser(userRepository: sl()));
  sl.registerLazySingleton(() => SignIn(userRepository: sl()));
  sl.registerLazySingleton(() => SignOut(userRepository: sl()));
  sl.registerLazySingleton(() => UpdateUser(userRepository: sl()));

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSource: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
        firebaseAuth: sl(), googleSignIn: sl(), firebaseFirestore: sl()),
  );

  //! External Service

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
