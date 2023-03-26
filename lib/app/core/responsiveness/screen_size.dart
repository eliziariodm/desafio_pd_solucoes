import 'package:flutter/material.dart';

class ScreenSize {
  bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width > 1280.0;
  }

  bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width > 279.0 &&
        MediaQuery.of(context).size.width < 599.0;
  }

  double totalWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double totalHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double columnOne(BuildContext context) {
    final width = 8.33 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnTwo(BuildContext context) {
    final width = 16.66 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnThree(BuildContext context) {
    final width = 25 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnFour(BuildContext context) {
    final width = 33.33 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnFive(BuildContext context) {
    final width = 41.66 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnSix(BuildContext context) {
    final width = 50 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnSeven(BuildContext context) {
    final width = 58.33 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnEight(BuildContext context) {
    final width = 66.66 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnNine(BuildContext context) {
    final width = 75 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnTen(BuildContext context) {
    final width = 83.33 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnEleven(BuildContext context) {
    final width = 91.66 / 100 * MediaQuery.of(context).size.width;
    return width;
  }

  double columnTwelve(BuildContext context) {
    final width = 100 * MediaQuery.of(context).size.width;
    return width;
  }
}
