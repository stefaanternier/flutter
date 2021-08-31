
import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  Function() onTap;
  CameraButton({
    required this.onTap,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.white, // button color
        child: InkWell(
          splashColor: Colors.black12, // inkwell color
          child: SizedBox(
            width: 94,
            height: 94,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(50),
                      border: Border.all(
                          width: 3, color: Colors.black)),
                  // inkwell colo
                  child: ClipOval(
                      child: GestureDetector(
                        onTap: onTap,
                        child: Material(
                          color: Colors.white,
                        ),
                      ))),
            ),
          ),
        ),
      ),
    );
  }
}

