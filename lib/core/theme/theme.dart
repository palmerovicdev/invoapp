import 'package:flutter/material.dart';

class HSLTheme {
  final double hue;
  final double chroma;
  final bool isLight;

  const HSLTheme({
    required this.hue,
    required this.chroma,
    required this.isLight,
  });

  double _clamp01(double v) => v.isNaN ? 0.0 : v.clamp(0.0, 1.0);

  Map<String, HSLColor> resolvedHsl() {
    final hueSecondary = (hue + 180) % 360;
    final chromaBg = 0.01;
    final chromaText = chroma < 0.1 ? chroma : 0.1;
    final chromaAction = chroma;
    final chromaAlert = chroma > 0.05 ? chroma : 0.05;

    if (!isLight) {
      return {
        '--bg-dark': HSLColor.fromAHSL(1.0, 243, 0.33, 0.03),
        '--bg': HSLColor.fromAHSL(1.0, 211, 0.08, 0.1),
        '--bg-light': HSLColor.fromAHSL(1.0, 237, 0.02, 0.16),
        '--text': HSLColor.fromAHSL(1.0, hue, _clamp01(chromaText), 0.96),
        '--text-muted': HSLColor.fromAHSL(1.0, hue, _clamp01(chromaText), 0.76),
        '--highlight': HSLColor.fromAHSL(1.0, hue, _clamp01(chroma), 0.50),
        '--border': HSLColor.fromAHSL(1.0, hue, _clamp01(chroma), 0.40),
        '--border-muted': HSLColor.fromAHSL(1.0, hue, _clamp01(chroma), 0.30),
        '--primary': HSLColor.fromAHSL(1.0, hue, _clamp01(chromaAction), 0.76),
        '--secondary': HSLColor.fromAHSL(1.0, hueSecondary, _clamp01(chromaAction), 0.76),
        '--danger': HSLColor.fromAHSL(1.0, 7, 0.94, 0.66),
        '--warning': HSLColor.fromAHSL(1.0, 53, 1, 0.24),
        '--success': HSLColor.fromAHSL(1.0, 163, 1, 0.26),
        '--info': HSLColor.fromAHSL(1.0, 217, 1, 0.70),
      };
    } else {
      return {
        '--bg-dark': HSLColor.fromAHSL(1.0, hue, _clamp01(chromaBg), 0.92),
        '--bg': HSLColor.fromAHSL(1.0, hue, _clamp01(chromaBg), 0.96),
        '--bg-light': HSLColor.fromAHSL(1.0, hue, _clamp01(chromaBg), 1.00),
        '--text': HSLColor.fromAHSL(1.0, hue, _clamp01(chroma), 0.15),
        '--text-muted': HSLColor.fromAHSL(1.0, hue, _clamp01(chroma), 0.40),
        '--highlight': HSLColor.fromAHSL(1.0, hue, _clamp01(chroma), 1.00),
        '--border': HSLColor.fromAHSL(1.0, hue, _clamp01(chroma), 0.60),
        '--border-muted': HSLColor.fromAHSL(1.0, hue, _clamp01(chroma), 0.70),
        '--primary': HSLColor.fromAHSL(1.0, hue, _clamp01(chromaAction), 0.40),
        '--secondary': HSLColor.fromAHSL(1.0, hueSecondary, _clamp01(chromaAction), 0.40),
        '--danger': HSLColor.fromAHSL(1.0, 340, _clamp01(chromaAlert), 0.50),
        '--warning': HSLColor.fromAHSL(1.0, 100, _clamp01(chromaAlert), 0.50),
        '--success': HSLColor.fromAHSL(1.0, 160, _clamp01(chromaAlert), 0.50),
        '--info': HSLColor.fromAHSL(1.0, 260, _clamp01(chromaAlert), 0.50),
      };
    }
  }

  Map<String, Color> resolvedColors() {
    final map = resolvedHsl();
    return map.map((k, v) => MapEntry(k, v.toColor()));
  }
}

class Theme {
  final Color bgDark;
  final Color bg;
  final Color bgLight;
  final Color text;
  final Color textMuted;
  final Color border;
  final Color borderMuted;
  final Color highlight;
  final Color primary;
  final Color secondary;
  final Color danger;
  final Color warning;
  final Color success;
  final Color info;
  static int currentThemeIndex = 0;

  static List<Theme> get themes => [
    Theme.fromHSLTheme(HSLTheme(hue: 58, chroma: 0.2, isLight: false)),
    Theme.fromHSLTheme(HSLTheme(hue: 210, chroma: 0.05, isLight: false)),
    Theme.fromHSLTheme(HSLTheme(hue: 120, chroma: 0.05, isLight: false)),
    Theme.fromHSLTheme(HSLTheme(hue: 0, chroma: 0.05, isLight: true)),
  ];

  Theme({
    required this.bgDark,
    required this.bg,
    required this.bgLight,
    required this.text,
    required this.textMuted,
    required this.border,
    required this.borderMuted,
    required this.highlight,
    required this.primary,
    required this.secondary,
    required this.danger,
    required this.warning,
    required this.success,
    required this.info,
  });

  static Theme fromHSLTheme(HSLTheme hslTheme) {
    final colors = hslTheme.resolvedColors();
    return Theme(
      bgDark: colors['--bg-dark']!,
      bg: colors['--bg']!,
      bgLight: colors['--bg-light']!,
      text: colors['--text']!,
      textMuted: colors['--text-muted']!,
      border: colors['--border']!,
      borderMuted: colors['--border-muted']!,
      highlight: colors['--highlight']!,
      primary: colors['--primary']!,
      secondary: colors['--secondary']!,
      danger: colors['--danger']!,
      warning: colors['--warning']!,
      success: colors['--success']!,
      info: colors['--info']!,
    );
  }
}
