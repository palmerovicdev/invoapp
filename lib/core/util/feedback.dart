import 'package:flutter/services.dart';

VoidCallback click(VoidCallback? onTap) {
  return () {
    HapticFeedback.lightImpact();
    onTap?.call();
  };
}

VoidCallback select(VoidCallback? onTap) {
  return () {
    HapticFeedback.selectionClick();
    onTap?.call();
  };
}

VoidCallback error(VoidCallback? onTap) {
  return () {
    HapticFeedback.heavyImpact();
    onTap?.call();
  };
}

VoidCallback success(VoidCallback? onTap) {
  return () {
    HapticFeedback.mediumImpact();
    onTap?.call();
  };
}
