import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as thm;

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
    this.isAuthentication = true,
  });

  final bool isAuthentication;

  @override
  Widget build(BuildContext context) {
    final theme = thm.Theme.themes[thm.Theme.currentThemeIndex];
    return Scaffold(
      backgroundColor: theme.bgDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: theme.bgLight,
                borderRadius: Consts.radius.containers.xl,
              ),
              child: Center(
                child: Icon(
                  Icons.home_rounded,
                  size: Consts.sizes.base.extreme,
                  color: theme.primary,
                ),
              ),
            ),
            Consts.spacing.gap.giant,
            Text(
              context.i18n('invoApp'),
              style: TextStyle(
                fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.paragraphTitle),
                fontWeight: FontWeight.bold,
                color: theme.text,
              ),
            ),
            Consts.spacing.gap.huge,
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                strokeWidth: Consts.sizes.base.sm,
                valueColor: AlwaysStoppedAnimation(theme.primary),
              ),
            ),
            Consts.spacing.gap.ultra,
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Consts.sizes.base.xxl,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      isAuthentication ? context.i18n('checkingAuth') : context.i18n('loading'),
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.paragraphTitle, largest: Consts.fontSizes.device.mobile.header),
                        color: theme.textMuted,
                        fontWeight: FontWeight.w700,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
