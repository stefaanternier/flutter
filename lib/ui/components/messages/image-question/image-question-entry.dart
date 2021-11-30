import 'package:flutter/material.dart';
import 'package:youplay/screens/util/extended_network_image.dart';

class ImageQuestionEntry extends StatelessWidget {
  final Color color;
  final double scale;
  final Function(String, int?) buttonClick;
  final int index;
  final String answerId;
  final String? imagePath;
  final bool isSelected;

  const ImageQuestionEntry({
    required this.color,
    required this.scale,
    required this.buttonClick,
    required this.index,
    required this.answerId,
    this.imagePath,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AspectRatio(
          aspectRatio: scale,
          child: Padding(
              padding: EdgeInsets.all(4),
              child: GestureDetector(
                  onTap: () {
                    buttonClick(answerId, index);
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: getBoxDecoration(imagePath),
                      ),
                      Visibility(
                        visible: isSelected,
                        child: Positioned(
                          top: 5,
                          right: 5,
                          child: Icon(
                            Icons.check_circle,
                            color: color,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        bottom: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2.0),
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Stack(
                              alignment: const Alignment(0, 0),
                              children: [
                                Container(
                                  color: color,
                                ),
                                Center(
                                  child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ))),
        ));
  }
}
