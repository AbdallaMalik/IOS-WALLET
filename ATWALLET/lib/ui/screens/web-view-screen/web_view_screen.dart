import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wallet_cryptomask/constant.dart';
import 'package:wallet_cryptomask/ui/utils/ui_utils.dart';

class WebViewScreen extends StatefulWidget {
  static const router = "web_view_screen";
  final String url;
  final String title;

  const WebViewScreen({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            )),
        elevation: 1,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () => shareBlockViewerUrl(widget.url),
              icon: const Icon(
                Icons.share,
                color: kPrimaryColor,
              ))
        ],
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: kPrimaryColor, fontSize: 16),
          ),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
      ),
    );
  }
}
