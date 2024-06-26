import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget CommonLogo(context,bool isWhite ){
  return TweenAnimationBuilder(
    duration: const Duration(milliseconds: 1500),
    curve: Curves.easeIn,
    tween: Tween(begin: 1.0, end: 0.0),
    builder: (BuildContext context, double value, Widget? child) {
      return Transform.translate(
        offset: Offset(value * 150, 0.0),
        child: SvgPicture.asset(
          isWhite ? "assets/images/Artonest_logo_white.svg" :"assets/images/Artonest_logo.svg",
          height: MediaQuery.of(context).size.height * 0.081,
          width: MediaQuery.of(context).size.width * 0.164,
          fit: BoxFit.fill,
        ),
      );
    },

  );
}