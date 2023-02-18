///this file is to handle the images in the splash screen
//
//
import 'package:flutter/cupertino.dart';

///this class is to put the image in center and Expanded
///(Mario) why using class
class ImageContainerWithExpanded extends StatelessWidget {
  final String img;
  final int flx;
  const ImageContainerWithExpanded(
      {Key? key, required this.img, required this.flx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flx,
      child: Center(
        child: Image(
          image: AssetImage(img),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
/**
*
  Making code readable  : )
*
* **/

///this class is to put the image in center and Flexible
class ImageContainerWithFlexible extends StatelessWidget {
  final String img;
  final int flx;
  const ImageContainerWithFlexible(
      {Key? key, required this.img, required this.flx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flx,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Image(
          image: AssetImage(img),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
