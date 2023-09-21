import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget swordIcon() {
  return Builder(
    builder: (BuildContext context) {
      final iconColor = Theme.of(context).iconTheme.color ?? Colors.black;
      return ColorFiltered(
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
        child: SvgPicture.asset(
          'assets/icons/swords.svg', // Replace with your SVG file path
          width: 24, // Set the desired width
          height: 24, // Set the desired height
        ),
      );
    },
  );
}

Widget skullIcon() {
  return Builder(
    builder: (BuildContext context) {
      final iconColor = Theme.of(context).iconTheme.color ?? Colors.black;
      return ColorFiltered(
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
        child: SvgPicture.asset(
          'assets/icons/skull.svg', // Replace with your SVG file path
          width: 24, // Set the desired width
          height: 24, // Set the desired height
        ),
      );
    },
  );
}
