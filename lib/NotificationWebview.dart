// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, deprecated_member_use, missing_return, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotificationWebview extends StatefulWidget {
  const NotificationWebview({Key? key}) : super(key: key);

  @override
  _NotificationWebviewState createState() => _NotificationWebviewState();
}

class _NotificationWebviewState extends State<NotificationWebview> {
  double progress = 0;
  late WebViewController controller;
  var urlIndex;
  bool isLoading = true;
  var navUrls = [
    "https://www.yourpedia.in/courses/hpcl-exam-preparation",
    "https://www.yourpedia.in/courses/post-gate-counseling",
    "https://www.yourpedia.in/courses/foreign-consultancy",
    "https://www.yourpedia.in/courses/gate",
    "https://www.yourpedia.in/courses/ese-prelims-paper-1",
    "https://www.yourpedia.in/courses/aai-atc-exam",
    "https://www.yourpedia.in/courses/interview-and-gd-preparation",
    "https://www.yourpedia.in/exams/ese",
    "https://www.yourpedia.in/exams/gate",
    "https://www.yourpedia.in/exams/psu",
    "https://www.yourpedia.in/exams/ssc-jen",
    "https://www.yourpedia.in/exams/state-ae-je-exams",
    "https://www.yourpedia.in/selections/post-gate-counselling-2022-selections",
    "https://www.yourpedia.in/selections/psu-selections",
    "https://www.yourpedia.in/selections/hpcl-2021-selections",
    "https://www.yourpedia.in/selections/foreign-selections",
    "https://www.yourpedia.in/selections/uppsc-polytechnic-lecturer-selections"
  ];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    urlIndex = ModalRoute.of(context)!.settings.arguments;
    // print(urlIndex);
    // print(navUrls[int.parse(urlIndex)]);
    return Scaffold(
      appBar: AppBar(
        title: Text('YourPedia',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontSize: 18, color: Colors.white)),
        titleSpacing: 10,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            controller.clearCache();
            CookieManager().clearCookies();
          },
          icon: const Icon(Icons.cached),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                }
              },
              icon: const Icon(Icons.arrow_back_ios)),
          IconButton(
              onPressed: () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                }
              },
              icon: const Icon(Icons.arrow_forward_ios)),
          IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          isLoading
              ? LinearProgressIndicator(
                  value: progress,
                  color: Colors.red,
                )
              : const SizedBox(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: WebView(
                initialUrl: navUrls[int.parse(urlIndex)],
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                onProgress: (progress) => setState(() {
                  this.progress = progress / 100;
                }),
                onPageFinished: (string) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
