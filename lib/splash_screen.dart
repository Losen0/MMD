import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/home_page.dart';
import 'package:todo_app/resources/color_resources.dart';
import 'package:todo_app/resources/image_assets.dart';
import 'package:todo_app/resources/text_resource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 5), _goNext);
  }

  _goNext() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startDelay();
  }

  static const SizedBox _space = SizedBox(
    height: 5,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.splashBackground,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Flexible(
              flex: 1,
              child: Center(
                child: Text(
                  AppStrings.title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
            _space,
            const Flexible(
              flex: 1,
              child: Center(
                child: Text(
                  AppStrings.titleArabic,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
            _space,
            _space,
            Expanded(
                flex: 6,
                child: Center(
                    child: ImageContainer(img: ImageAssets.splashImage1))),
            _space,
            _space,
            _space,
            Expanded(
                flex: 3,
                child: Center(
                    child: ImageContainer(img: ImageAssets.splashImage2))),
            _space,
            const Flexible(
              flex: 1,
              child: Text(
                AppStrings.splashString1,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.primary,
                ),
              ),
            ),
            const Flexible(
              flex: 1,
              child: Text(
                AppStrings.splashString2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primary,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(children: [
                Spacer(),
                ImageContainer(img: ImageAssets.splashImage3),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }
}

class ImageContainer extends StatelessWidget {
  final String img;
  const ImageContainer({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(img),
      fit: BoxFit.fill,
    );
  }
}
