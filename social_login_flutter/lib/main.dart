import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'feature/auth/presentation/blocs/user/user_bloc.dart';
import 'package:social_login_flitter/injenction_container.dart';
import 'injenction_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
            create: (context) => sl<UserBloc>()..add(CheckLoggedEvent())),
      ],
      child: App(),
    ),
  );
}
