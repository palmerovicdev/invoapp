import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oklch/oklch.dart';

class ThemeOklchScope extends InheritedWidget {
  final double hue;
  final double chroma;
  final bool isLight;

  const ThemeOklchScope({
    super.key,
    required super.child,
    this.hue = 200.0,
    this.chroma = 0.1,
    this.isLight = false,
  });

  static ThemeOklchScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeOklchScope>();
    return scope ?? const ThemeOklchScope(child: SizedBox.shrink());
  }

  @override
  bool updateShouldNotify(covariant ThemeOklchScope oldWidget) {
    return hue != oldWidget.hue || chroma != oldWidget.chroma || isLight != oldWidget.isLight;
  }
}

Color _oklchColor(bool isLight, double l, double c, double h) {
  try {
    final o = OKLCHColor(l, c, h);
    return o.color;
  } catch (_) {
    return isLight ? Colors.black : Colors.white;
  }
}

extension BuildContextThemeOklch on BuildContext {
  ThemeOklchScope get _scope => ThemeOklchScope.of(this);

  double get _hue => _scope.hue % 360;

  double get _chroma => _scope.chroma;

  double get _hueSecondary => (_hue + 180) % 360;

  bool get _isLight => _scope.isLight;

  double get _chromaBg => _roundTo(_chroma * 0.5, 3);

  double get _chromaText => _roundTo(min(_chroma, 0.1), 3);

  double get _chromaAction => _roundTo(max(_chroma, 0.1), 3);

  double get _chromaAlert => _roundTo(max(_chroma, 0.05), 3);

  Color get theme_bg_dark {
    return _isLight ? _oklchColor(_isLight, 0.92, _chromaBg, _hue) : _oklchColor(_isLight, 0.1, _chromaBg, _hue);
  }

  Color get theme_bg {
    return _isLight ? _oklchColor(_isLight, 0.96, _chromaBg, _hue) : _oklchColor(_isLight, 0.15, _chromaBg, _hue);
  }

  Color get theme_bg_light {
    return _isLight ? _oklchColor(_isLight, 1.0, _chromaBg, _hue) : _oklchColor(_isLight, 0.2, _chromaBg, _hue);
  }

  Color get theme_text {
    return _isLight ? _oklchColor(_isLight, 0.15, _chroma, _hue) : _oklchColor(_isLight, 0.96, _chromaText, _hue);
  }

  Color get theme_text_muted {
    return _isLight ? _oklchColor(_isLight, 0.4, _chroma, _hue) : _oklchColor(_isLight, 0.76, _chromaText, _hue);
  }

  Color get theme_highlight {
    return _isLight ? _oklchColor(_isLight, 1.0, _chroma, _hue) : _oklchColor(_isLight, 0.5, _chroma, _hue);
  }

  Color get theme_border {
    return _isLight ? _oklchColor(_isLight, 0.6, _chroma, _hue) : _oklchColor(_isLight, 0.4, _chroma, _hue);
  }

  Color get theme_border_muted {
    return _isLight ? _oklchColor(_isLight, 0.7, _chroma, _hue) : _oklchColor(_isLight, 0.3, _chroma, _hue);
  }

  Color get theme_primary => _oklchColor(_isLight, _isLight ? 0.4 : 0.76, _chromaAction, _hue);

  Color get theme_secondary => _oklchColor(_isLight, _isLight ? 0.4 : 0.76, _chromaAction, _hueSecondary);

  Color get theme_danger => _oklchColor(_isLight, _isLight ? 0.5 : 0.7, _chromaAlert, 30);

  Color get theme_warning => _oklchColor(_isLight, _isLight ? 0.5 : 0.7, _chromaAlert, 100);

  Color get theme_success => _oklchColor(_isLight, _isLight ? 0.5 : 0.7, _chromaAlert, 160);

  Color get theme_info => _oklchColor(_isLight, _isLight ? 0.5 : 0.7, _chromaAlert, 260);

  Map<String, Color> get theme_vars {
    return {
      '--bg-dark': theme_bg_dark,
      '--bg': theme_bg,
      '--bg-light': theme_bg_light,
      '--text': theme_text,
      '--text-muted': theme_text_muted,
      '--highlight': theme_highlight,
      '--border': theme_border,
      '--border-muted': theme_border_muted,
      '--primary': theme_primary,
      '--secondary': theme_secondary,
      '--danger': theme_danger,
      '--warning': theme_warning,
      '--success': theme_success,
      '--info': theme_info,
    };
  }

  double _roundTo(double v, int decimals) {
    final p = pow(10, decimals);
    return (v * p).roundToDouble() / p;
  }
}
