import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String url;

  WebViewPage({Key key, this.url}) : super(key: key);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[100],
          title: Text(
            "Aatmanirbhar",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 22,
                foreground: Paint()
                  ..shader = ui.Gradient.linear(
                    const Offset(60, 100),
                    const Offset(50, 35),
                    <Color>[
                      Colors.orange,
                      Colors.green,
                    ],
                  )),
          ),
        ),
        body: WebView(
          initialUrl: url,
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        ));
  }
}
