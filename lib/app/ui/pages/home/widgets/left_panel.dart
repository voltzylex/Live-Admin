import 'package:flutter/material.dart';
import 'package:live_admin/app/ui/pages/home/widgets/sliding_image.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: SlidingImage()
          //  Image.asset(
          //   Assets.frame,
          //   fit: BoxFit.cover,
          // ),
          ),
    );
  }
}
