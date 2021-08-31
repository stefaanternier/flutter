import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';

class MessagePage extends StatelessWidget {
  GeneralItem item;

  MessagePage({required  this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text('item is ${item.title}'),),
    );
  }
}
