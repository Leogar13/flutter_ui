import 'package:flutter/material.dart';

class Navigation {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final Navigation _instance = Navigation._internal();

  factory Navigation() => _instance;

  Navigation._internal();

  static Navigation get instance => _instance;
  
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  // ignore: always_declare_return_types, type_annotate_public_apis
  goBack({dynamic result}) {
    return navigatorKey.currentState.pop(result);
  }
}
