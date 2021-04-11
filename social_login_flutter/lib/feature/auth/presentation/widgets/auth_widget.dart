import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:social_login_flitter/feature/auth/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:social_login_flitter/feature/auth/presentation/pages/profile_page.dart';
import 'package:social_login_flitter/feature/auth/presentation/widgets/social_login_button.dart';
import '../../../../constants.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:social_login_flitter/constants.dart';

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
          titleTag: "welcome_text",
          logoTag: "welcome_logo",
          theme: LoginTheme(
              pageColorDark: kAppMainColor,
              pageColorLight: kAppMainLightColor,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Row(
              children: [
                social_login_button(
                  imageData: 'assets/images/facebook.png',
                  clickEvent: () {
                    BlocProvider.of<UserBloc>(context)
                        .add(FacebookSignInEvent());
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                social_login_button(
                  imageData: 'assets/images/google.png',
                  clickEvent: () {
                    BlocProvider.of<UserBloc>(context).add(SignInEvent());
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                social_login_button(
                  imageData: 'assets/images/linkedin.png',
                  clickEvent: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LinkedInUserWidget(
                          appBar: AppBar(
                            title: Text('LinkedIn login'),
                          ),
                          redirectUrl: redirectUrl,
                          clientId: clientId,
                          clientSecret: clientSecret,
                          onGetUserProfile:
                              (LinkedInUserModel linkedInUser) async {
                            var response = await http.get(
                                "https://api.linkedin.com/v2/me?projection=(profilePicture(displayImage~:playableStreams))",
                                headers: {
                                  HttpHeaders.authorizationHeader:
                                      "Bearer ${linkedInUser.token.accessToken}"
                                });
                            var profile = json.decode(response.body);
                            var profilePic = profile["profilePicture"]
                                    ["displayImage~"]["elements"][0]
                                ["identifiers"][0]["identifier"];

                            Map<String, String> postJson = {
                              "user_id": linkedInUser.userId,
                              "email": linkedInUser
                                  .email.elements[0].handleDeep.emailAddress,
                              "pic_url": profilePic,
                              "name": linkedInUser.firstName.localized.label +
                                  ' ' +
                                  linkedInUser.lastName.localized.label,
                              "token": linkedInUser.token.accessToken,
                              "expires_in":
                                  linkedInUser.token.expiresIn.toString(),
                              "from": 'linkedin'
                            };
                            print(
                                'Linked in response===>' + postJson.toString());
                            Navigator.of(context).pop();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HomeScreen(
                            //               json: postJson,
                            //             )));
                          },
                          catchError: (LinkedInErrorObject error) {
                            print(
                                'Error description: ${error.description} Error code: ${error.statusCode.toString()}');
                          },
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
