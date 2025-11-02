import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;

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
        padding: AppSpacing.paddingMds,
        decoration: BoxDecoration(
          borderRadius: Consts.radius.containers.md,
        ),
        child: Icon(
          Icons.wallet,
          color: theme.primary,
          size: AppSizes.iconXl,
        ),
      ),
      color: theme.bgLight,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderLg,
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
              Icon(
                Icons.info_outline,
                color: theme.text,
                size: Consts.sizes.icons.sm,
              ),
              Consts.spacing.gapHorizontal.sm,
              Text(
                context.i18n('aboutApp'),
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
        const PopupMenuDivider(
          height: 1,
          indent: 12,
          endIndent: 12,
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(
                Icons.logout,
                color: theme.danger,
                size: Consts.sizes.icons.sm,
              ),
              Consts.spacing.gapHorizontal.sm,
              Text(
                context.i18n('logout'),
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
