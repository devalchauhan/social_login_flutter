import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'helper/appMainColor.dart';
import 'screens/home.dart';
import 'screens/login.dart';

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
      initialRoute: Login.id,
      routes: {
        Login.id: (context) => Login(),
        Home.id: (context) => Home(),
      },
    );
  }
}
