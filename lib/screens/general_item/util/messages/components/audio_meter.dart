
import 'dart:collection';

import 'package:flutter/material.dart';


class ItemEntry<number> extends LinkedListEntry<ItemEntry> {
  number value;

  ItemEntry(this.value);

  String toString() => "${super.toString()} : value.toString()";
}

class AudioMeter extends CustomPainter {
  LinkedList<LinkedListEntry> meteringList;
  AudioMeter({required this.meteringList});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final left = 0.0;
    final top = 0.0;
    final right = size.width;
    final bottom = 300.0;
    final middle = (bottom - top)/2;
    final rect = Rect.fromLTRB(left, top, right, bottom);
//    final paint = Paint()
//      ..color = Colors.white
//      ..style = PaintingStyle.stroke
//      ..strokeWidth = 4;
//    canvas.drawRect(rect, paint);

    double lineX = right - 10;
    ItemEntry? entry = this.meteringList.first as ItemEntry;
    while (lineX > 0 && entry != null) {
      final value = (60 + entry.value );
//      print ("value is ${entry.value}");
      final leftM = lineX-0;
      final topM = middle - value;
      final rightM = lineX;
      final bottomM = middle + value;
      final rect = Rect.fromLTRB(leftM, topM, rightM, bottomM);
      final paint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawRect(rect, paint);
      lineX -= 5;
      entry = entry.next;
    }
    if (lineX >0) {
      final leftBase = 0.0;
      final topBase = middle ;
      final rightBase = lineX;
      final bottomBase = middle ;
      final rect = Rect.fromLTRB(leftBase, topBase, rightBase, bottomBase);
      final paint = Paint()
        ..color = Colors.white.withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawRect(rect, paint);
    } else {
      if (entry != null) {
        meteringList.remove(entry);
      }

    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
