import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_login_flitter/core/presentation/pages/some_thing_went_wrong_page.dart';
import 'package:social_login_flitter/feature/auth/presentation/blocs/user/user_bloc.dart';
import 'package:social_login_flitter/feature/auth/presentation/pages/profile_page.dart';
import 'package:social_login_flitter/feature/auth/presentation/widgets/auth_widget.dart';

class AuthPage extends StatefulWidget {
  static String id = 'Auth_page';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, UserState userState) {
          if (userState is UserNotLoggedState) {
            print("UserNotLoggedState : ");
            return auth_widget();
          } else if (userState is UserLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (userState is UserLoggedState) {
            return ProfilePage();
          }
          return SomeThingWentWrongPage();
        },
      ),
    );
  }
}
