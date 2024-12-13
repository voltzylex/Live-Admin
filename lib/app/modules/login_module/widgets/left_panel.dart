import 'package:live_admin/app/global_imports.dart';


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
        child: Image.asset(
          Assets.frame,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
