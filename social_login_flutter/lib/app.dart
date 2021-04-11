import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_login_flitter/feature/auth/presentation/pages/auth_page.dart';
import 'package:social_login_flitter/feature/auth/presentation/pages/profile_page.dart';
import 'helper/appMainColor.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppMainMaterialColor().colorCustom,
      ),
      initialRoute: AuthPage.id,
      routes: {
        AuthPage.id: (context) => AuthPage(),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }
}
