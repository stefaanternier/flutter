import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

import '../../../localizations.dart';

class CollectionSearchField extends StatefulWidget {
  Function(String) submitQuery;

  CollectionSearchField({
    required this.submitQuery, Key? key}) : super(key: key);

  @override
  _CollectionSearchFieldState createState() => _CollectionSearchFieldState();
}

class _CollectionSearchFieldState extends State<CollectionSearchField> {
  TextEditingController searchQuery = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: searchQuery,
      onChanged: widget.submitQuery,
      style: new TextStyle(
        color: AppConfig().themeData!.primaryColor,
      ),
      decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search, color: AppConfig().themeData!.primaryColor),
          hintText: AppLocalizations.of(context).translate('games.search'),
          hintStyle: new TextStyle(color: Colors.grey)),
    );
  }
}
