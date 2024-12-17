import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Utils {

  static void fieldFocusChange(BuildContext context,
      FocusNode current,
      FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.red, textColor: Colors.white);
  }

  static void flashBarErrorMessage(String message, context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          titleColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
          reverseAnimationCurve: Curves.easeOut,
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          icon: Icon(Icons.error, size: 20, color: Colors.white,),
          message: message,
          title: "Warnings",
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        )
          ..show(context));
  }

  static snakBar(String message, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(message))
    );
  }
}
