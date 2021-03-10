import 'package:acazia_training/models/user.dart';
import 'package:acazia_training/view/pages/complete_page.dart';
import 'package:acazia_training/view/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user!=null){
      return SucceedPage();
    }
    else{
      return SignUpPage();
    }
  }
}
