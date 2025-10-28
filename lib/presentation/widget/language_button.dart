import 'package:consts/constants/app_font_sizes.dart';
import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;

class LanguageButton extends StatelessWidget {
  final String currentLanguageCode;
  final VoidCallback onToggle;
  final app_theme.Theme theme;

  const LanguageButton({
    super.key,
    required this.currentLanguageCode,
    required this.onToggle,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: Consts.radius.containers.md,
        ),
        child: Icon(
          Icons.g_translate,
          size: 28,
          color: theme.primary,
        ),
      ),
    );
  }
}
