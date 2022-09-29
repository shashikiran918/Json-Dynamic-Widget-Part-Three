// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_dynamic_widget_one/NotificationWebview.dart';
import 'package:json_dynamic_widget_one/utils.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigatorKey = GlobalKey<NavigatorState>();

    var registry = JsonWidgetRegistry.instance;
    registry.navigatorKey = navigatorKey;

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorKey,
        routes: {
          '/NotificationWebview': (context) => const NotificationWebview(),
        },
        home: const JsonDynamic());
  }
}

class JsonDynamic extends StatefulWidget {
  const JsonDynamic({Key? key}) : super(key: key);

  @override
  State<JsonDynamic> createState() => _JsonDynamicState();
}

class _JsonDynamicState extends State<JsonDynamic> {
  late CarouselSliderController _sliderController;
  final List<String> images = [
    "https://www.yourpedia.in/UploadData/8cbe5f30-5f98-499b-8e69-10d9c52b7f13Slide-Upd.jpg",
    "https://www.yourpedia.in/UploadData/e02f8e27-23f5-48d0-afb2-60bf5fd1421a1-New.jpg",
    "https://www.yourpedia.in/UploadData/bf5e2daa-282d-4d12-a656-d6eb6d6e2a13mock.jpg",
    "https://www.yourpedia.in/UploadData/9d129f08-1ee1-4c7d-a5bb-2d3bf161daaaslide-3.jpeg",
    "https://www.yourpedia.in/UploadData/6edcecb0-bcf2-4ad0-88ff-5b34124298e2Foreign-Admission.jpg",
    "https://www.yourpedia.in/UploadData/cb5f64be-b499-4838-adde-0450c81fce2fESE-PRELIMS-COURSE.jpg",
    "https://www.yourpedia.in/UploadData/1771c81b-fef5-4c80-8847-5d0fffef4e93slide-2.jpeg",
    "https://www.yourpedia.in/UploadData/7885f084-1739-4a36-a523-8f69105287b4Slide-1A.jpeg",
  ];
  var newsUrls = [
    "https://www.yourpedia.in/courses/post-gate-counseling",
    "",
    "https://www.yourpedia.in/courses/psu-preparation",
    "",
    "https://www.yourpedia.in/courses/foreign-consultancy",
    "https://www.yourpedia.in/courses/ese-prelims-paper-1",
    "",
    "",
  ];

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.color,
          title: Text('Json Dynamic Widget',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 18,
                  )),
          centerTitle: true),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: CarouselSlider.builder(
              unlimitedMode: true,
              controller: _sliderController,
              slideBuilder: (index) {
                return GestureDetector(
                  onTap: () async {
                    final Uri _url = Uri.parse(newsUrls[index]);
                    if (!await launchUrl(_url)) {
                      throw 'Could not launch OTS Portal';
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Image.network(
                      images[index],
                      fit: BoxFit.fill,
                      height: 200,
                    ),
                  ),
                );
              },
              slideTransform: const DepthTransform(),
              slideIndicator: CircularSlideIndicator(
                padding: const EdgeInsets.only(top: 30),
                indicatorBorderColor: Colors.red,
                currentIndicatorColor: Colors.red,
                indicatorBackgroundColor: Colors.white,
                itemSpacing: 25,
                indicatorRadius: 5,
              ),
              itemCount: images.length,
              initialPage: 0,
              enableAutoSlider: true,
            ),
          ),
          const SizedBox(height: 15),
          const Center(
              child: Text(
                "COURSES",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                  fontFamily: 'Montserrat',
                ),
              )),
          const SizedBox(height: 15),
          jsonWidget(context, 'assets/json/listview.json'),
          const SizedBox(height: 15),
          const Center(
              child: Text(
                "EXAMS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                  fontFamily: 'Montserrat',
                ),
              )),
          jsonWidget(context, 'assets/json/whitecard.json'),
          const SizedBox(height: 15),
          const Center(
              child: Text(
            "SELECTIONS IN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.red,
              fontFamily: 'Montserrat',
            ),
          )),
          jsonWidget(context, 'assets/json/gridview.json'),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
