import 'package:acazia_training/navigation/paths.dart';
import 'package:acazia_training/navigation/slide_left_route.dart';
import 'package:acazia_training/view/pages/complete_page.dart';
import 'package:acazia_training/view/pages/create_account_page_email_page.dart';
import 'package:acazia_training/view/pages/sign_up_page.dart';
import 'package:acazia_training/view/pages/login_page.dart';
import 'package:acazia_training/view/pages/create_account_page_phone_page.dart';
import 'package:acazia_training/view/pages/verification_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SIGN_UP:
      return SlideLeftRoute(widget: SignUpPage());
    case LOGIN:
      return SlideLeftRoute(widget: LoginPage());
    case CREATE_ACCOUNT_PHONE:
      return SlideLeftRoute(widget: CreateAccountPhonePage());
    case CREATE_ACCOUNT_EMAIL:
      final phoneNumber = settings.arguments as String;
      return SlideLeftRoute(widget: CreateAccountEmailPage(
        phoneNumber: phoneNumber,
      ));
    case VERIFICATION_CODE:
      final phoneNumber = settings.arguments as String;
      return SlideLeftRoute(
          widget: VerificationPage(phoneNumber: phoneNumber,)
      );
    case COMPLETE_PAGE:
      return SlideLeftRoute(widget: SucceedPage());
    default:
      return defaultNav(settings);
  }
}

MaterialPageRoute defaultNav(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Text('No path for ${settings.name}'),
      ),
    ),
  );
}
