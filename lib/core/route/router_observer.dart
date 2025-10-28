import 'package:flutter/material.dart';

import '../logger.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logI('didPush: $route from($previousRoute)');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logI('didPop: $route from($previousRoute)');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logI('didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    logI('didReplace: $newRoute for($oldRoute)');
  }
}
