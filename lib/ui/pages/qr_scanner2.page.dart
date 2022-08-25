import 'package:flutter/material.dart';
import 'package:youplay/ui/components/scan/game-scanner.container.dart';

class GameQRnew extends StatelessWidget {
  const GameQRnew({Key? key}) : super(key: key);

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: GameQRScannerContainer()

    );
  }
}
