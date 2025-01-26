import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    Color? backgroundColor,
    double? elevation,
    Brightness? brightness,
  }) : super(
          backgroundColor: backgroundColor ?? Colors.transparent,
          elevation: elevation ?? 0,
        );
}
