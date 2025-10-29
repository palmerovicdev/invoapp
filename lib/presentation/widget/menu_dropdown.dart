import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/core/localization/app_locale.dart';

class MenuDropdown extends StatelessWidget {
  final app_theme.Theme theme;
  final VoidCallback onAboutTap;
  final VoidCallback onLogoutTap;

  const MenuDropdown({
    super.key,
    required this.theme,
    required this.onAboutTap,
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
          case 'logout':
            onLogoutTap();
            break;
        }
      },
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: Consts.radius.containers.md,
        ),
        child: Icon(
          Icons.wallet,
          color: theme.primary,
          size: 32,
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
                  fontSize: context.getResponsiveFontSize(
                    smallest: Consts.fontSizes.device.mobile.bodySmall,
                  ),
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
                  fontSize: context.getResponsiveFontSize(
                    smallest: Consts.fontSizes.device.mobile.bodySmall,
                  ),
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
