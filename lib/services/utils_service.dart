import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void fireToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static bool emailValidate(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static bool passwordValidate(String password) {
    return RegExp(r'(?=.*?[0-9]).{8,}$').hasMatch(password);
  }

  static Future<bool> commonDialog(context, title, content, yes, no, isSingle) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return Platform.isAndroid ?
        AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context, false);
              },
              child: Text(no, style: TextStyle(color: Colors.green, fontSize: 16),),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context, true);
              },
              child: Text(yes, style: TextStyle(color: Colors.red, fontSize: 16),),
            )
          ],
        ) :
        CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context, false);
              },
              child: Text(no, style: TextStyle(color: Colors.green, fontSize: 16),),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context, true);
              },
              child: Text(yes, style: TextStyle(color: Colors.red, fontSize: 16),),
            )
          ],
        );
      },
    );
  }

}





