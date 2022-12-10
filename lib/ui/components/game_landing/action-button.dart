

import 'package:flutter/material.dart';

class GameLandingActionButton extends StatelessWidget {
  final bool showLogin;
  final Function() login;
  final Function() open;

  const GameLandingActionButton({
    required this.showLogin,
    required this.login,
    required this.open,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('vm showlogin is ${showLogin}');

    if (showLogin) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(60, 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.0),
          ),
        ),
        onPressed: login,
        child: const Text('Inloggen'),
      );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(60, 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
      ),
      onPressed: open,
      child: const Text('OPEN'),
    );
  }
}


class GameActionOpenRuns extends StatelessWidget {
  final Function() open;

  const GameActionOpenRuns({required this.open, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(60, 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
      ),
      onPressed: open,
      child: const Text('Speel verder'),
    );
  }
}


class GameActionResumeRun extends StatelessWidget {
  final Function() open;

  const GameActionResumeRun({required this.open, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(60, 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26.0),
        ),
      ),
      onPressed: open,
      child: const Text('Speel verder'),
    );
  }
}
