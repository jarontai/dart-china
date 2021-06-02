import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? inAppWebViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(),
    ios: IOSInAppWebViewOptions(),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Login'),
      ),
      body: SafeArea(
        child: Container(
          child: InAppWebView(
            key: webViewKey,
            initialUrlRequest:
                URLRequest(url: Uri.parse("https://inappwebview.dev/")),
            initialOptions: options,
            onWebViewCreated: (controller) =>
                inAppWebViewController = controller,
          ),
        ),
      ),
    );
  }
}
