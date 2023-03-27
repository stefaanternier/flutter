import 'dart:async';

import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youplay/models/general_item/open_url.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/messages/chapter/chapter-widget.container.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class OpenUrlWidget extends StatefulWidget {
  final OpenUrl item;

  OpenUrlWidget({required this.item, Key? key}) : super(key: key);

  @override
  _OpenUrlWidgetState createState() => _OpenUrlWidgetState();
}

class _OpenUrlWidgetState extends State<OpenUrlWidget> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (UniversalPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: widget.item.title, elevation: true),
        body: WebWrapper(
            child: ChapterWidgetContainer(
                child: MessageBackgroundWidgetContainer(
          child: Stack(children: [
            WebView(
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
                  child: NextButtonContainer(item: widget.item),
                )),
          ]),
        ))));
  }
}
