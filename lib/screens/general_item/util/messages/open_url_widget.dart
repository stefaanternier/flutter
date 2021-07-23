import 'dart:async';
import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item/open_url.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/screens/general_item/util/messages/components/next_button.dart';

import 'generic_message.dart';

class OpenUrlWidget extends StatefulWidget {
  OpenUrl item;
  GeneralItemViewModel giViewModel;

  OpenUrlWidget({required this.item, required this.giViewModel});

  @override
  _OpenUrlWidgetState createState() => new _OpenUrlWidgetState();
}

class _OpenUrlWidgetState extends State<OpenUrlWidget> {
  bool newLibrary = true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    bool showButton = widget.item.description != null && !widget.item.description.isEmpty;
    bool hide = !showButton && ((widget.item.richText == null) || widget.item.richText.isEmpty);
    bool showOnlyButton = false;
    if (((widget.item.richText == null) || widget.item.richText.isEmpty) && showButton) {
      showOnlyButton = true;
    }

    return GeneralItemWidget(
        item: this.widget.item,
        giViewModel: this.widget.giViewModel,
        body:Stack(
          children:[ WebView(
          initialUrl: widget.item.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            return NavigationDecision.navigate;
          }),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
          child: Visibility(
            visible: showButton,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
              child: NextButton(
                  buttonText: widget.item.description ,
                  overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
                  giViewModel: widget.giViewModel),
            ),
          )
        ),

      ]
        ));

  }
}
