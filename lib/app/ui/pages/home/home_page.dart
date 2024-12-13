
import 'package:flutter/material.dart';

import 'widgets/left_panel.dart';
import 'widgets/right_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 800;
        return Scaffold(
          body: Row(
            children: [
              if (!isSmallScreen) const LeftPanel(),
              const RightPanel(),
            ],
          ),
        );
      },
    );
  }
}
