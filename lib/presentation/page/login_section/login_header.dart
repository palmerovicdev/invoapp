import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as thm;

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = thm.Theme.themes[thm.Theme.currentThemeIndex];
    return Column(
      children: [
        Consts.spacing.gap.giant,
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: theme.bgLight,
              borderRadius: AppRadius.borderXl,
            ),
            child: Center(
              child: Icon(
                Icons.currency_bitcoin_sharp,
                size: Consts.ui.icons.huge,
                color: theme.primary,
              ),
            ),
          ),
        ),
        Consts.spacing.gap.giant,
        Text(
          context.l10n.welcomeBack,
          style: TextStyle(
            fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.paragraphTitle),
            fontWeight: FontWeight.bold,
            color: theme.text,
          ),
          textAlign: TextAlign.center,
        ),
        Consts.spacing.gap.md,
        Text(
          context.l10n.invoApp,
          style: TextStyle(
            fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.bodyLarge),
            color: theme.textMuted,
          ),
          textAlign: TextAlign.center,
        ),
        Consts.spacing.gap.giant,
      ],
    );
  }
}
