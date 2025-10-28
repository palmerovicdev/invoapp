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
          color: theme.bg.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.borderMuted.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              size: 20,
              color: theme.text,
            ),
            const SizedBox(width: 6),
            Text(
              currentLanguageCode.toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
