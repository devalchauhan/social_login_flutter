import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_login_flitter/feature/auth/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:social_login_flitter/feature/auth/presentation/pages/profile_page.dart';
import 'package:social_login_flitter/feature/auth/presentation/widgets/social_login_button.dart';
import '../../../../constants.dart';

class auth_widget extends StatelessWidget {
  String uid;
  String email;

  Future<String> _authUser(LoginData data) async {
    String message;
    final mAuth = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: data.name, password: data.password)
        .catchError((error) {
      String errorMessage = error.message;
      message = errorMessage;
    });
    if (mAuth != null) {
      uid = mAuth.user.uid;
      email = mAuth.user.email;
    }
    return message;
  }

  Future<String> _signUp(LoginData data) async {
    String message;
    final mAuth = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: data.name, password: data.password)
        .catchError((error) {
      String errorMessage = error.message;

      message = errorMessage;
    });
    if (mAuth != null) {
      uid = mAuth.user.uid;
      email = mAuth.user.email;
    }

    return message;
  }

  Future<String> _recoverPassword(String name) async {
    String message;
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: name)
        .catchError((error) {
      String errorMessage = error.message;
      message = errorMessage;
    }).whenComplete(() => null);
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterLogin(
          title: 'Mentor',
          logo: 'images/white_icon.png',
          titleTag: "welcome_text",
          logoTag: "welcome_logo",
          theme: LoginTheme(
              pageColorDark: kAppMainColor,
              pageColorLight: kAppMainColor,
              afterHeroFontSize: 15),
          onLogin: _authUser,
          onSignup: _signUp,
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ));
          },
          onRecoverPassword: _recoverPassword,
        ),
        Positioned(
          bottom: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              social_login_button(
                imageData: 'assets/images/facebook.png',
                clickEvent: () {
                  BlocProvider.of<UserBloc>(context).add(SignInEvent());
                },
              ),
              social_login_button(
                imageData: 'assets/images/google.png',
                clickEvent: () {
                  BlocProvider.of<UserBloc>(context).add(SignInEvent());
                },
              ),
              social_login_button(
                imageData: 'assets/images/linkedin.png',
                clickEvent: () {
                  BlocProvider.of<UserBloc>(context).add(SignInEvent());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
