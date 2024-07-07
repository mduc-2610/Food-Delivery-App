import 'dart:math' as math;
import 'package:flutter/material.dart';

class AppBarScrollBehavior extends StatelessWidget {
  final Widget child;
  final bool isScrollHidden;
  final bool noHidden;

  const AppBarScrollBehavior({
    required this.child,
    this.isScrollHidden = true,
    this.noHidden = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

        builder: (context, c) {
          final settings = context
              .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
          double maxExtent = settings?.maxExtent ?? 0;
          double minExtent = settings?.minExtent ?? 0;
          double currentExtent = settings?.currentExtent ?? 0;

          final deltaExtent = maxExtent - minExtent;
          final t =
          (1.0 - (currentExtent - minExtent) / deltaExtent)
              .clamp(0.0, 1.0) as double;
          final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
          const fadeEnd = 1.0;
          final opacity = 1 - Interval(fadeStart, fadeEnd).transform(t);
          return Opacity(
              opacity: (!noHidden) ? ((isScrollHidden) ? opacity : 1 - opacity) : 1,
              child: child
          );
        }
    );
  }
}
