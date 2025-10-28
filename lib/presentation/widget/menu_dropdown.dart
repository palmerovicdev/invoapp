import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/core/localization/app_locale.dart';

class MenuDropdown extends StatelessWidget {
  final app_theme.Theme theme;
  final VoidCallback onAboutTap;
  final VoidCallback onThemeColorTap;
  final VoidCallback onLogoutTap;

  const MenuDropdown({
    super.key,
    required this.theme,
    required this.onAboutTap,
    required this.onThemeColorTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'about':
            onAboutTap();
            break;
          case 'theme':
            onThemeColorTap();
            break;
          case 'logout':
            onLogoutTap();
            break;
        }
      },
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.bg.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.borderMuted.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Icon(
          Icons.more_vert,
          color: theme.text,
          size: 20,
        ),
      ),
      color: theme.bgLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.borderMuted.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'about',
          child: Row(
            children: [
              Icon(Icons.info_outline, color: theme.text, size: 20),
              const SizedBox(width: 12),
              Text(
                context.l10n.aboutApp,
                style: TextStyle(
                  color: theme.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'theme',
          child: Row(
            children: [
              Icon(Icons.palette_outlined, color: theme.text, size: 20),
              const SizedBox(width: 12),
              Text(
                context.l10n.themeColor,
                style: TextStyle(
                  color: theme.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuDivider(height: 1),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: theme.danger, size: 20),
              const SizedBox(width: 12),
              Text(
                context.l10n.logout,
                style: TextStyle(
                  color: theme.danger,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
