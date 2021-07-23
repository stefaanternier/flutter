import 'package:flutter/material.dart';

class CombinationLockEntry extends StatefulWidget {
  bool isNumeric;
  Function valueChanged;
  int index;

  CombinationLockEntry({required this.isNumeric, required this.valueChanged, required this.index});

  @override
  _CombinationLockEntryState createState() => _CombinationLockEntryState();
}

class _CombinationLockEntryState extends State<CombinationLockEntry> {
  int _numericValue = 0;
  String alphabeth = "abcdefghijklmnopqrstuvwxyz";


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(26)),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.white,
            width: 1,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("tap up");
              up();
            },
            child: Icon(Icons.expand_less, color: Colors.white, size: 35),
          ),
          Text(
            widget.isNumeric ? "$_numericValue" : "${alphabeth[_numericValue]}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          GestureDetector(
            onTap: () {
              print("tap down");
              down();
            },
            child: Icon(Icons.expand_more, color: Colors.white, size: 35),
          ),
        ],
      ),
    );
  }

  up() {
    setState(() {
      if (widget.isNumeric) {
        _numericValue = (_numericValue + 1) % 10;
        widget.valueChanged('$_numericValue', this.widget.index);

      } else {
        _numericValue = (_numericValue + 1) % 26;
        widget.valueChanged(alphabeth[_numericValue], this.widget.index);
      }
      print('value changed $_numericValue');
    });
  }

  down() {
    setState(() {
      if (widget.isNumeric) {
        _numericValue = (_numericValue - 1) % 10;
        widget.valueChanged('$_numericValue', this.widget.index);
      } else {
        _numericValue = (_numericValue - 1) % 26;
        widget.valueChanged(alphabeth[_numericValue], this.widget.index);
      }
      print('value changed $_numericValue');
    });
  }
}
