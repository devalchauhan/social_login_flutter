library cool_alert;

import 'package:flutter/material.dart';
import 'src/models/cool_alert_options.dart';
import 'src/utils/animate.dart';
import 'src/widgets/cool_alert_container.dart';

enum CoolAlertType { success, error, warning, confirm, info, loading }
enum CoolAlertAnimType {
  scale,
  rotate,
  slideInDown,
  slideInUp,
  slideInLeft,
  slideInRight,
}

/// CoolAlert.
class CoolAlert {
  static Future show({
    @required BuildContext context,
    String title,
    String text,
    @required CoolAlertType type,
    CoolAlertAnimType animType = CoolAlertAnimType.scale,
    bool barrierDismissible = true,
    VoidCallback onConfirmBtnTap,
    VoidCallback onCancelBtnTap,
    String confirmBtnText = "OK",
    String cancelBtnText = "NO",
    Color confirmBtnColor = const Color(0xFF3085D6),
    bool showCancelBtn = false,
    double borderRadius = 10.0,
  }) {
    CoolAlertOptions options = new CoolAlertOptions(
      title: title,
      text: text,
      type: type,
      animType: animType,
      barrierDismissible: barrierDismissible,
      onConfirmBtnTap: onConfirmBtnTap,
      onCancelBtnTap: onCancelBtnTap,
      confirmBtnText: confirmBtnText,
      cancelBtnText: cancelBtnText,
      confirmBtnColor: confirmBtnColor,
      showCancelBtn: showCancelBtn,
      borderRadius: borderRadius,
    );

    Widget child = AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      content: CoolAlertContainer(
        options: options,
      ),
    );
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, anim1, anim2, widget) {
        switch (animType) {
          case CoolAlertAnimType.scale:
            return Animate.scale(child: child, animation: anim1);
            break;
          case CoolAlertAnimType.rotate:
            return Animate.rotate(child: child, animation: anim1);
            break;
          case CoolAlertAnimType.slideInDown:
            return Animate.slideInDown(child: child, animation: anim1);
            break;
          case CoolAlertAnimType.slideInUp:
            return Animate.slideInUp(child: child, animation: anim1);
            break;
          case CoolAlertAnimType.slideInLeft:
            return Animate.slideInLeft(child: child, animation: anim1);
            break;
          case CoolAlertAnimType.slideInRight:
            return Animate.slideInRight(child: child, animation: anim1);
            break;
          default:
            return child;
        }
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, anim1, anim2) => null,
    );
  }
}
