import 'package:flutter/material.dart';

import '../shared/colors.dart';

Color determineColorBasedOnChange(double change) {
  return change < 0 ? kNegativeColor : kPositiveColor;
}
