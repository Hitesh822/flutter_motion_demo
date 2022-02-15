import 'package:flutter/material.dart';
import 'package:flutter_motion_demo/routers/motion_animator.dart';
import 'package:flutter_motion_demo/screens/home_screen.dart';
import 'package:flutter_motion_demo/screens/search_screen.dart';
import 'package:flutter_motion_demo/routers/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Motion Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.search:
            //TODO: try with fadeThroughPageTranisition
            return MotionAnimator().sharedAxisPageTranisition(
              axis: SharedAxis.z, // TODO: try with different axis
              screen: const SearchScreen(key: ValueKey(AppRoutes.search)),
            );
          default:
            //TODO: try with fadeThroughPageTranisition
            return MotionAnimator().sharedAxisPageTranisition(
              axis: SharedAxis.z, // TODO: try with different axis
              screen: const HomeScreen(key: ValueKey(AppRoutes.home)),
            );
        }
      },
    );
  }
}
