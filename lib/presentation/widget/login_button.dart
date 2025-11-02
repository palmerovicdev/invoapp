import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/button/animated_state_button.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as thm;

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
    required this.controller,
  });

  final VoidCallback onPressed;
  final AnimatedStateButtonController controller;

  @override
  Widget build(BuildContext context) {
    final theme = thm.Theme.themes[thm.Theme.currentThemeIndex];
    return AnimatedStateButton(
      controller: controller,
      initColor: theme.primary,
      borderRadius: Consts.radius.base.md,
      compactSize: Consts.sizes.base.mega,
      width: Consts.sizes.base.mega,
      height: Consts.sizes.base.mega,
      onPressed: () async => onPressed.call(),
      initChild: Text(
        context.i18n('signIn'),
        style: TextStyle(
          fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.body),
          fontWeight: FontWeight.w600,
          color: theme.text,
        ),
      ),
    );
  }
}
