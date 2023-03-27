import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class ChapterWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final int chapter;
  final int maxChapters;

  const ChapterWidget(
      {required this.child, required this.color, required this.chapter, required this.maxChapters, Key? key})
      : super(key: key);

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
            left:10,
            right:10,
            top: 10,
            child: new DotsIndicator(
              dotsCount: maxChapters,
              position: chapter.toDouble() -1,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                shape: CircleBorder(
                    side: BorderSide(
                        width: 0.5,
                        color: Colors.black)
                ),
                color: Colors.white, //
                activeColor: color, //#D2DAE2
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
        )
      ],
    );


    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: [
    //     LinearProgressIndicator(
    //       value: chapter / maxChapters,
    //       minHeight: 5,
    //       color: color,
    //       backgroundColor: lighten(color, 0.3),
    //     ),
    //     Expanded(child: child),
    //   ],
    // );
  }
}
