import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_admin/app/controllers/home_controller.dart';
import 'package:live_admin/app/ui/utils/app_colors.dart';

import 'widgets/left_panel.dart';
import 'widgets/right_panel.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Row(
          children: const [
            LeftPanel(), // Left panel widget
            RightPanel(), // Right panel widget
          ],
        ),
      ),
    );
  }
}
