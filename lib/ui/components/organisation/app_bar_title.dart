import 'package:flutter/material.dart';

class OrganisationAppBarTitle extends StatelessWidget {
  final String organisationName;
  const OrganisationAppBarTitle({required this.organisationName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(organisationName);
  }
}
