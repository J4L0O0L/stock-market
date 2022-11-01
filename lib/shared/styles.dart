import 'package:flutter/material.dart';

import 'colors.dart';

const kProfileCompanyName = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const priceStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
);

TextStyle determineTextStyleBasedOnChange(double change) {
  return change < 0 ? kNegativeChange : kPositiveChange;
}

const TextStyle kPositiveChange =
    TextStyle(color: kPositiveColor, fontSize: 16, fontWeight: FontWeight.w800);

const TextStyle kNegativeChange =
    TextStyle(color: kNegativeColor, fontSize: 16, fontWeight: FontWeight.w800);
