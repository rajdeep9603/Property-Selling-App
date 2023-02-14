import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: WebView(
        initialUrl: "https://app.ffysell.com/login?fstart=1",
        // appBar: AppBar(
        //   title: Text("Forget password"),
        // ),
      ),
    );
  }
}
