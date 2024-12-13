import 'package:flutter/material.dart';
import 'package:live_admin/app/utils/widgets/app_button/app_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(),
            const SizedBox(height: 16),
            AppButton(
              onPressed: () {},
              text: "Tiếp tục".toUpperCase(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
