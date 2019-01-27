import 'package:flutter/material.dart';

class FadeInFadeOutRoute<T> extends MaterialPageRoute<T> {
  FadeInFadeOutRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
//    if (animation.status == AnimationStatus.reverse)
//      return super.buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(opacity: animation, child: child);
  }
}