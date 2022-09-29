import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

jsonWidget(BuildContext context, String jsondynamic) {
  return FutureBuilder(
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        var widgetJson = json.decode(snapshot.data!.toString());
        var widget = JsonWidgetData.fromDynamic(widgetJson);
        return widget!.build(context: context);
      } else {
        return widgetJson(context, 'assets/json/exception.json');
      }
    },
    future: DefaultAssetBundle.of(context).loadString(jsondynamic),
  );
}

widgetJson(BuildContext context, String jsondynamic) {
  return FutureBuilder(
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.hasData) {
        var widgetJson = json.decode(snapshot.data!.toString());
        var widget = JsonWidgetData.fromDynamic(widgetJson);
        return widget!.build(context: context);
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
    future: DefaultAssetBundle.of(context).loadString(jsondynamic),
  );
}
