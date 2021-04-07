import 'package:flutter/material.dart';
import 'package:social_login_flitter/constants.dart';
import 'package:social_login_flitter/helper/checkInternet.dart';

class Login extends StatefulWidget {
  static String id = 'Login_Screen';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    checkInternet().checkConnection(context);
    return Container(
      color: kAppMainColor,
    );
  }
}
