import 'package:connect/model/experts/expert_detail_card_model.dart';
import 'package:connect/view/bottom/bottom_bar_screen.dart';
import 'package:connect/view/experts/screen/expert_detail.dart';
import 'package:connect/view/home/screen/home_screen.dart';
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
    case '/bottom-bar-screen':
      page = BottomBarScreen();
      break;
    case '/expert-detail-screen':
      final expert = args?['expert'] ??
          ExpertDetailModel(
            name: "John Doe",
            title: "Senior Developer at ExampleCorp",
            qualification: "M.S. in Computer Science · Example University",
            profileImageUrl: "https://randomuser.me/api/portraits/men/45.jpg",
            expertise: [
              "Resume Review",
              "Interview Handling",
              "Career Guidance"
            ],
            about:
                "Experienced senior developer specializing in career coaching and tech interviews. Passionate about helping others succeed.",
            overallRating: 4.9,
            reviews: [
              RatingExpertDetailsModel(
                name: "Alice",
                profileImageUrl:
                    "https://randomuser.me/api/portraits/women/10.jpg",
                rating: 5,
                review: "Very helpful and insightful advice!",
              ),
              RatingExpertDetailsModel(
                name: "Bob",
                profileImageUrl:
                    "https://randomuser.me/api/portraits/men/11.jpg",
                rating: 4,
                review: "Great experience, would recommend.",
              ),
            ],
          );
      page = ExpertDetailPage(expert: expert);
      break;
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
