import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';

class SplashServices {


  Future<UserModel> getUserdata() => UserViewModel().getUser();

  void checkAuthentication(context) async {
    getUserdata().then((value) async {
      print(value.token.toString());
      if(value.token=='null'||value.token==''){
       await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      {
        if (kDebugMode) {
          print(error.toString());
        }
      }
    });
  }
}
