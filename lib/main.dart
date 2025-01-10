import 'package:live_admin/app/controllers/bindings.dart';
import 'package:live_admin/app/global_imports.dart';
import 'package:live_admin/app/themes/app_theme.dart';
import 'package:live_admin/app/utils/common.dart';
import 'package:live_admin/app/utils/extensions.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SC.to.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    "Your device locale: ${Get.deviceLocale}".logStr(name: 'Locale');
    return GestureDetector(
      // Dismiss keyboard when clicked outside
      onTap: () => Common.dismissKeyboard(),
      child: GetMaterialApp(
        builder: (context, child) =>
            ResponsiveBreakpoints.builder(breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ], child: child!),
        initialRoute: AppRoutes.initial,
        theme: AppTheme.darkTheme,
        getPages: AppPages.pages,
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
      ),
    );
  }
}
