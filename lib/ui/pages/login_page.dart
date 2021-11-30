import 'package:flutter/material.dart';
import 'package:youplay/ui/components/login/login_screen.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class LoginPage extends StatelessWidget {
  final Function() loginSuccessful;
  final Function() anonLoginSuccessful;
  final bool anonLogin;

  const LoginPage({
    required this.loginSuccessful,
    required this.anonLoginSuccessful,
    this.anonLogin = true,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        drawer: ARLearnNavigationDrawerContainer(),
        body: WebWrapper(child:LoginScreenContainer(
          anonLogin: anonLogin,
          loginSuccessful: loginSuccessful,
          anonLoginSuccessful: anonLoginSuccessful,
        )));
  }
}
