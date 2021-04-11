import 'package:flutter/material.dart';

class social_login_button extends StatelessWidget {
  Function clickEvent;
  String imageData;
  social_login_button({@required this.clickEvent, @required this.imageData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickEvent,
      child: CircleAvatar(
        child: Image.asset(
          imageData,
        ),
      ),
    );
  }
}
