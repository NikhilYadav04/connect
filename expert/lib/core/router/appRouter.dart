import 'package:expert/view/bottom/bottom_bar_screen.dart';
import 'package:expert/view/home/screen/home_screen.dart';
import 'package:expert/view/join/screens/expert_apply_approval_page.dart';
import 'package:expert/view/join/screens/expert_join_screen.dart';
import 'package:expert/view/landing_screen.dart';
import 'package:flutter/material.dart';

enum TransitionType {
  rightToLeft,
  leftToRight,
  bottomToTop,
  topToBottom,
  fade,
}

///* Builds a PageRoute with the given [child], using [type] and [duration].
PageRouteBuilder<dynamic> buildPageRoute(
  Widget child, {
  TransitionType type = TransitionType.rightToLeft,
  Duration duration = const Duration(milliseconds: 200),
}) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => child,
    transitionDuration: duration,
    transitionsBuilder: (_, animation, __, child) {
      final curveAnim = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      switch (type) {
        case TransitionType.leftToRight:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(curveAnim),
            child: child,
          );
        case TransitionType.topToBottom:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(curveAnim),
            child: child,
          );
        case TransitionType.bottomToTop:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curveAnim),
            child: child,
          );
        case TransitionType.fade:
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        case TransitionType.rightToLeft:
        default:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(curveAnim),
            child: child,
          );
      }
    },
  );
}

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments as Map<String, dynamic>?;
  final type = args?['transition'] as TransitionType?;
  final ms = args?['duration'] as int?;
  final duration = ms != null ? Duration(milliseconds: ms) : null;

  Widget page;
  switch (settings.name) {
    case '/landing-screen':
      page = ExpertLandingScreen();
      break;
    case '/bottom-bar-screen':
      page = BottomBarScreen();
      break;
    case '/expert-join-screen':
      page = ExpertSignUpScreen();
      break;
    case '/expert-approval-loader':
      page = ApplicationSubmittedPage();
    default:
      page = HomeScreen();
      break;
  }

  return buildPageRoute(
    page,
    type: type ?? TransitionType.rightToLeft,
    duration: duration ?? const Duration(milliseconds: 200),
  );
}
