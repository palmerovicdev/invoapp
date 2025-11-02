import 'package:animate_do/animate_do.dart';
import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as thm;

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = thm.Theme.themes[thm.Theme.currentThemeIndex];
    final Duration delay = Consts.durations.base.xs;
    return Column(
      children: [
        Consts.spacing.gap.giant,
        FadeInUp(
          duration: Consts.durations.base.md,
          child: Center(
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
        ),
        Consts.spacing.gap.giant,
        FadeInUp(
          delay: delay,
          duration: Consts.durations.base.md,
          child: Column(
            children: [
              Text(
                context.i18n('welcomeBack'),
                style: TextStyle(
                  fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.paragraphTitle),
                  fontWeight: FontWeight.bold,
                  color: theme.text,
                ),
                textAlign: TextAlign.center,
              ),
              Consts.spacing.gap.md,
              Text(
                context.i18n('invoApp'),
                style: TextStyle(
                  fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.bodyLarge),
                  color: theme.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Consts.spacing.gap.giant,
      ],
    );
  }
}
