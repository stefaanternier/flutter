import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:youplay/ui/components/scan/game-scanner.container.dart';

import 'dart:math';

import '../../config/app_config.dart';

class GameQRnew extends StatelessWidget {
  const GameQRnew({Key? key}) : super(key: key);

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: GameQRScannerContainer()

    );
  }
}
