import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

import 'modules/coffeelist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    requestPermissions();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoffeeList(),
    );
  }
}

class Jitsi extends StatelessWidget {
  const Jitsi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.redAccent,
            ),
            width: double.infinity,
            child: MaterialButton(
              onPressed: () async {
                requestPermissions();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Meeting(title: 'Meeting')),
                );
              },
              child: const Text(
                'Start Meeting',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Meeting extends StatefulWidget {
  const Meeting({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Meeting> createState() => _Meeting();
}

class _Meeting extends State<Meeting> {
  late InAppWebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse("https://8x8.vc/vpaas-magic-cookie-7efb1cdc601c4859a7af86e4147b8607/SampleAppEnvironmentalCompaniesTearGently"),
        ),
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },

        onWebViewCreated: (controller) {
          this.controller = controller;
          _getController();
        },
      ),
    );
  }

  Future<void> _getController() async {
    await controller.setOptions(
      options: InAppWebViewGroupOptions(
        ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
            allowsAirPlayForMediaPlayback: true
        ),
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
        ),
      ),
    );
    await controller.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse("https://8x8.vc/vpaas-magic-cookie-7efb1cdc601c4859a7af86e4147b8607/SampleAppEnvironmentalCompaniesTearGently"),
      ),
    );
  }
}

void requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
  ].request();
}