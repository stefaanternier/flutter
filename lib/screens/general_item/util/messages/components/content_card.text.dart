import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/config/app_config.dart';

class ContentCardText extends StatefulWidget {

  Widget? button;
  String? title;
  String? text;

  ContentCardText({
      this.button,
      this.text,
      this.title,

  });

  @override
  State<ContentCardText> createState() => _ContentCardTextState();
}

class _ContentCardTextState extends State<ContentCardText> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    // if (this.button == null) return Container();
    List<Widget> widgets = [];
    bool hasTitle = widget.title != null && widget.title!.trim().isNotEmpty;
    bool hasText = widget.text != null && widget.text!.trim().isNotEmpty;
    if (hasTitle) widgets.add(buildTitle());
    if (hasText && !UniversalPlatform.isWeb) widgets.add(buildContent(context));
    if (hasText && UniversalPlatform.isWeb)
      widgets.add(buildContentWeb(context));
    if (widget.button != null) widgets.add(buildButton());
    if (widgets.isEmpty) {
      return Container();
    }
    if (!hasTitle && !hasText) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
        child: widget.button,
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 30, 28, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: widgets,
        ),
      ),
    );
  }

  buildTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 26),
      child: Text('${this.widget.title?.toUpperCase()}',
          style: AppConfig.isTablet()
              ? AppConfig().customTheme!.cardTitleStyleTablet
              : AppConfig().customTheme!.cardTitleStyle),
    );
  }

  buildContent(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.width / 3 * 2),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Stack(
          children: [

             Container(
               child: Scrollbar(
                 controller: _scrollController,
                 isAlwaysShown: true,
                 child: new SingleChildScrollView(
                   controller: _scrollController,
                    scrollDirection: Axis.vertical, //.horizontal(
                    child: Text('${this.widget.text} \n\n',
                        style: AppConfig().customTheme!.cardContentStyle),
                  ),
               ),
             ),

            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.transparent, Colors.white],
                    ).createShader(bounds);
                  },
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical, //.horizontal(

                    child: Container(
                      height: 50,
                      color: Colors.white,
                    ),
                  ),
                  blendMode: BlendMode.dstATop,
                ))
          ],
        ),
      ),
    );
  }

  buildContentWeb(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.width / 3 * 2),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: new SingleChildScrollView(
            scrollDirection: Axis.vertical, //.horizontal(
            child: Text('${this.widget.text} \n\n',
                style: AppConfig().customTheme!.cardContentStyle),
          )),
    );
  }

  buildButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 26),
      child: widget.button,
    );
  }
}
