import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:youplay/models/response.dart';

import '../../../../config/app_config.dart';

class AnswerPictureIcon extends StatefulWidget {
  final Response response;
  const AnswerPictureIcon({required this.response, Key? key}) : super(key: key);

  @override
  State<AnswerPictureIcon> createState() => _AnswerPictureIconState();
}

class _AnswerPictureIconState extends State<AnswerPictureIcon> {
  int failed = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 79,
        height: 79,
        child: ExtendedImage.network(
            '${AppConfig().storageUrl}/${widget.response.value}',
          width: 79,
          height: 79,
          fit: BoxFit.fill,
          cache: failed == 1,
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                // _controller.reset();
                return Image.asset(
                  'graphics/loading.gif',
                  fit: BoxFit.fill,
                );

              case LoadState.completed:
                return ExtendedRawImage(
                    image: state.extendedImageInfo?.image,
                    width: 79,
                    height: 79,

                );
                break;
              case LoadState.failed:
                print('failed');
                new Future.delayed(const Duration(seconds: 2)).then((value) {
                 setState(() {
                   failed = failed * 2;
                 });
                });
                return Image.asset( //new AssetImage('graphics/loading.gif')
                  'graphics/loading.gif',
                  fit: BoxFit.fill,
                );
                break;
            }
          },
        )
        // Container(
        //   decoration: getBoxDecoration('/${response.value}'),
        // )
    );
  }
}

