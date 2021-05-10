import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
 

class WebViewLoad extends StatefulWidget {

  WebViewLoadUI createState() => WebViewLoadUI();

}

class WebViewLoadUI extends State<WebViewLoad>{

  @override
  Widget build(BuildContext context) {
  return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.red,
        title: Text('Covid In Nepal')),
    body: WebView(
      initialUrl: 'https://covid19.mohp.gov.np/',
      javascriptMode: JavascriptMode.unrestricted,

    )
  );
  }
}