import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:live_admin/app/themes/app_colors.dart';
import 'package:live_admin/app/themes/app_text_theme.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.title,
    this.opacity,
    this.loadingType = LoadingType.chasingDots,
    this.loadingColor,
  });

  final String? title;
  final double? opacity;
  final LoadingType loadingType;
  final Color? loadingColor;

  Widget getLoading() {
    switch (loadingType) {
      case LoadingType.dualRing:
        return SpinKitDualRing(
          color: loadingColor ?? AppColors.primary,
          size: 50,
        );
      case LoadingType.doubleBounce:
        return SpinKitDoubleBounce(
          color: loadingColor ?? AppColors.primary,
          size: 50,
        );
      default:
        return SpinKitChasingDots(
          color: loadingColor ?? AppColors.primary,
          size: 50,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(opacity ?? 1),
      body: Stack(
        children: [
          Center(
            child: getLoading(),
          ),
          if (title != null)
            Positioned(
              bottom: 20,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: Center(
                    child: Text(
                      title!,
                      style: AppTextStyles.base.w700.s16.whiteColor,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

enum LoadingType {
  dualRing,
  chasingDots,
  doubleBounce,
}
