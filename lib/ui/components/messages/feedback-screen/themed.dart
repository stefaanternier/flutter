import 'package:flutter/material.dart';
import 'package:youplay/screens/util/extended_network_image.dart';

class Themed extends StatelessWidget {
  final String? backgroundPath;
  final Widget body;
  const Themed({
    this.backgroundPath,
    required this.body,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getBoxDecoration(backgroundPath),
      child: body,
    );
  }
}
