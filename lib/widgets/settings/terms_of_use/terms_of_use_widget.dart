import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';


class TermsOfUseWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // return WebviewScaffold(
    //   appBar: AppBar(
    //     iconTheme: IconThemeData(color: ColorPalette.orange),
    //     title: Text("CGU"),
    //     backgroundColor: Colors.white,
    //     centerTitle: true,
    //     elevation: 1,
    //   ),
    //   url: "https://srv-file1.gofile.io/download/yxrH1b/condition-general.pdf",
    //   withZoom: true
    // );
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.orange),
        title: Text("CGU"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
      body: WebView(
        initialUrl: "https://drive.google.com/file/d/1f_KrL3bRhlIQ7kL2JrcZ2ZhmZyCxxVkL/view",
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }

}