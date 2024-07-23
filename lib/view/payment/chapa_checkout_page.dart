import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ChapaCheckoutPage extends StatefulWidget {
  final String checkoutUrl;

  ChapaCheckoutPage({required this.checkoutUrl});

  @override
  _ChapaCheckoutPageState createState() => _ChapaCheckoutPageState();
}

class _ChapaCheckoutPageState extends State<ChapaCheckoutPage> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapa Checkout'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.checkoutUrl)),
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          final uri = navigationAction.request.url;
          if (uri != null &&
              (uri.toString().startsWith('https://example.com/success') ||
                  uri.toString().startsWith('https://example.com/failure'))) {
// Handle navigation events here, such as successful payment completion
            if (uri.toString().startsWith('https://example.com/success')) {
// Payment successful, navigate to a success page
              Navigator.pushNamed(context, '/success');
            } else if (uri
                .toString()
                .startsWith('https://example.com/failure')) {
// Payment failed, navigate to a failure page
              Navigator.pushNamed(context, '/failure');
            }
            return NavigationActionPolicy.CANCEL;
          }
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}
