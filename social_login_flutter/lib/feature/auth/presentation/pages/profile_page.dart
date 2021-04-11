import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_login_flitter/core/presentation/pages/some_thing_went_wrong_page.dart';
import 'package:social_login_flitter/feature/auth/presentation/blocs/user/user_bloc.dart';

class ProfilePage extends StatefulWidget {
  static String id = 'Profile_page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (BuildContext context, UserState userState) {
        if (userState is UserNotLoggedState) {
          Navigator.pop(context);
        }
        if (userState is UserUpdateSuccessState ||
            userState is UserUpdateFailState) {
          context.read<UserBloc>().add(CheckLoggedEvent());
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, UserState userState) {
          if (userState is UserLoadingState) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (userState is UserLoggedState) {
            var user = userState.user;
            return Scaffold(
              appBar: AppBar(
                title: Text("Account"),
                actions: [
                  IconButton(
                    icon: Icon(Icons.exit_to_app_sharp),
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).add(SignOutEvent());
                    },
                  ),
                ],
              ),
              body: Container(
                child: SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.badge),
                            labelText: 'Name',
                          ),
                          initialValue: user.displayName,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.mail),
                            labelText: 'Email',
                          ),
                          initialValue: user.email,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return SomeThingWentWrongPage();
        },
      ),
    );
  }
}
