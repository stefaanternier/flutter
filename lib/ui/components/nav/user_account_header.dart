import 'package:flutter/material.dart';

class UserAccountHeader extends StatelessWidget {
  String email;
  String name;
  String accountPicture;

  UserAccountHeader({
    required this.email,
    required this.name,
    required this.accountPicture,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountEmail: Text(email),
      accountName: Text(name),
      currentAccountPicture: (accountPicture == null)
          ? null
          : CircleAvatar(
          backgroundColor: Theme
              .of(context)
              .cardColor,
          backgroundImage: NetworkImage(accountPicture)),
    );
  }
}
