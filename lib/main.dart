import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/app/app.bottomsheets.dart';
import 'package:movies_app/app/app.dialogs.dart';
import 'package:movies_app/app/app.locator.dart';
import 'package:movies_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_shared/stacked_shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(environment: Environment.test);
  setupDialogUi();
  setupBottomSheetUi();

  // Restrict app to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,  // Portrait mode (top-up)
    DeviceOrientation.portraitDown, // Portrait mode (bottom-up)
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:
            const Size(375, 812), // Set base design size (width x height)
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.startupView,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorKey: StackedService.navigatorKey,
            navigatorObservers: [
              StackedService.routeObserver,
            ],
          );
        });
  }
}
