import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app/resources/app_numbers.dart';
import 'package:todo_app/resources/color_resources.dart';
import 'package:todo_app/resources/image_assets.dart';
import 'package:todo_app/resources/localization.dart';
import 'package:todo_app/resources/text_resource.dart';
import 'package:todo_app/ui/home_page/home_page.dart';
import 'package:todo_app/ui/splash_screen/widgets/image_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    ///this function for displaying the splash screen for a period of time
    _startTimer();
  }

  ///this Method is called to start the timer
  _startTimer() {
    ///AppNumbers is a general class for all numbers in the app
    ///_Navigate is what happen after the period of time
    _timer = Timer(const Duration(seconds: AppNumbers.splashTimer), _navigate);
  }

  ///_navigate() to go to the home page after the splash screen and removing all the previous pages
  _navigate() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false);
  }

  /// Spaces in the splash screen made by the following sized Box ,
  /// its sizes is from the AppSizes you can change it from resources
  final SizedBox _space = const SizedBox(height: AppSizes.size1);
  final SizedBox _space15 = const SizedBox(height: AppSizes.size6);
  final SizedBox _space10 = const SizedBox(height: AppSizes.size3);

  ///used to replace Text to simplify the code and to make it readable
  Widget _flexibleText(String txt, bool align, [TextStyle? txtStyle]) {
    return Flexible(
      flex: AppNumbers.splashTextFlex,
      child: Align(
        alignment: align ? Alignment.bottomLeft : Alignment.center,
        child: Text(
          txt,
          style: txtStyle ?? Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  /// Notice that
  /// AppNumber is used to put any specific important number in the app
  /// it is in the resources in the same file with the AppSizes

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.splashBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppNumbers.splashPaddingLeft,
            AppNumbers.splashPaddingTop,
            AppNumbers.splashPaddingRight,
            AppNumbers.splashPaddingBottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              /// the arguments are(String for the text , boolean to make the alignment center or left ,
              /// and there is an optional argument which is the Style of the text )
              _flexibleText(AppStrings.titleSplash, false),
              _space,
              _flexibleText(AppStrings.titleArabicSplash, false),
              _space10,
              ImageContainerWithExpanded(
                  img: ImageAssets.splashImage1,
                  flx: AppNumbers.splashImage1Flex),
              _space15,
              ImageContainerWithExpanded(
                  img: ImageAssets.splashImage2,
                  flx: AppNumbers.splashImage2Flex),
              _space,
              _flexibleText(LocalizationKeys.splashString1, true,
                  Theme.of(context).textTheme.displayMedium),
              _flexibleText(LocalizationKeys.splashString2, true,
                  Theme.of(context).textTheme.displayMedium),
              ImageContainerWithFlexible(
                  img: ImageAssets.cupIcon, flx: AppNumbers.splashCupIconFlex),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    /// to cancel the timer if it has a periodic type
    _timer?.cancel();
    super.dispose();
  }
}
