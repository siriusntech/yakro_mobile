import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';import '../controllers/main_controller.dart';
import 'package:get/get.dart';

import '../data/repository/data/Env.dart';

// ignore: must_be_immutable
class ImageWidgetBaseUrl extends StatelessWidget {

  static MainController settingsCtrl = Get.put(MainController());

   final String? url;
   final String? default_image;
   final double? width;
   final double? default_image_width;
   final double? height;
   final double? default_image_height;
   final BoxFit? fit;
   final BoxFit? default_image_fit;
   bool isNetWork;

   ImageWidgetBaseUrl({this.url, this.width, this.height, this.fit, required this.isNetWork,
     this.default_image, this.default_image_width, this.default_image_height, this.default_image_fit
   });


  @override
  Widget build(BuildContext context) {
    return isNetWork ? CachedNetworkImage(
      imageUrl: settingsCtrl.baseUrlsansSlash+url!.toString(),
      width: width,
      height: height,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Image.asset(default_image.toString(),
        width: default_image_width,
        height: default_image_height,
        fit: default_image_fit,
      ),
    ) : Image.asset(settingsCtrl.baseUrlsansSlash+url!.toString(),
      width: width,
      height: height,
      fit: fit,
    );
  }


  //  @override
  //  Widget build(BuildContext context) {
  //    return isNetWork ? Image.network(siteUrl+url!,
  //      width: width,
  //      height: height,
  //      fit: fit,
  //    ) : Image.asset(url!,
  //      width: width,
  //      height: height,
  //      fit: fit,
  //    );
  //  }



}

