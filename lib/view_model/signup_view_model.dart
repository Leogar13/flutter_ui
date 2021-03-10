import 'package:acazia_training/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class SignUpViewModel{
  Future login() async {
    try{
      final FacebookLoginResult result = await FacebookLogin().logIn(
          ['email','public_profile']
      );
      final FacebookAccessToken accessToken = result.accessToken;
      await AuthService().linkUser(accessToken.token);
    }
    catch(e){
      debugPrint(e);
    }
  }
}