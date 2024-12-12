import 'package:flutter/material.dart';
import 'package:live_admin/app/ui/utils/assets.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({Key? key}) : super(key: key);

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
        child: Image.asset(
          Assets.frame,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
