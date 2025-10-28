import 'package:flutter/cupertino.dart';

extension ScreeSize on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;
}
