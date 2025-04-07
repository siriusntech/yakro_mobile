import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static Future<void> launchInAppBrowsers(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode
            .inAppBrowserView, // This opens the link in an in-app browser.
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchInAppBrowser(Uri uri) => launchUrl(
      Uri(
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
      ),
      mode: LaunchMode.inAppBrowserView,
      browserConfiguration: const BrowserConfiguration(
        showTitle: false,
      ),
      webViewConfiguration:
          const WebViewConfiguration(enableJavaScript: false));

  static formatDateHour(String date) {
    DateTime dateTime = DateTime.parse(date);
    var formatter = DateFormat("d MMMM y", "fr_FR");
    return formatter.format(dateTime);
  }

  static String formatPrice(double price) {
    var formatter = NumberFormat("#,##0", "fr_FR");
    return formatter.format(price);
  }

  //get date time plus 1 day
  static String addOneDay(DateTime dateTime, {int days = 1}) {
    return formatDateHour(dateTime.add(Duration(days: days)).toString());
  }

  //Generate
  static String generateRandomString(int length) {
    var chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    var random = Random();
    String randomString = '';
    for (int i = 0; i < length; i++) {
      var index = random.nextInt(chars.length);
      randomString += chars[index];
    }
    return randomString;
  }

  static String generateRandomInt(int length) {
    var chars =
        '1234567890';
    var random = Random();
    String randomString = '';
    for (int i = 0; i < length; i++) {
      var index = random.nextInt(chars.length);
      randomString += chars[index];
    }
    return randomString;
  }

  //presse papiers
  static Future<void> pressPapiers(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
