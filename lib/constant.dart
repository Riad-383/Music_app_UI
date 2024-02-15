import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryTextColor = Color(0xFF6c7a92);
  static const Color secondaryTextColor = Color(0xFFa1b1ca);
  static const Color bgColor = Color(0xFFe6eefe);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color bgDark = Color(0xFFB5D5EF);
  static const Color blue = Color(0xFF91adff);
  static const Color blueDark = Color(0xFF769eff);
  static const Color blueTopDark = Color(0xFF4C70E8);
  static const Color bluebottomDark = Color(0xFF839fff);
}

class neomorphijmbtn extends StatelessWidget {
  const neomorphijmbtn({
    super.key,
    required this.size,
    this.child,
    this.distance = 10,
    this.blur = 20,
    this.colors,
    this.onpressed,
    this.imageurl, this.padding,
  });
  final double size;
  final Widget? child;
  final double distance;
  final double blur;
  final List<Color>? colors;
  final VoidCallback? onpressed;
  final String? imageurl;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: size,
        width: size,
        padding:  EdgeInsets.all(padding??3),
        decoration: BoxDecoration(
            color: colors == null ? AppColor.bgColor : colors![1],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: AppColor.white,
                  blurRadius: blur,
                  offset: Offset(-distance, -distance)),
              BoxShadow(
                  color: AppColor.bgDark,
                  blurRadius: blur,
                  offset: Offset(distance, distance))
            ]),
        child: imageurl != null
            ? CircleAvatar(
                backgroundImage: AssetImage(imageurl!),
              )
            : Container(
                decoration: BoxDecoration(
                    color: AppColor.bgColor,
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: colors ??
                            [
                              AppColor.white,
                              AppColor.bgDark,
                            ])),
                child: child,
              ),
      ),
    );
  }
}
