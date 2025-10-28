import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_motionly/widget/button/animated_state_button.dart';
import 'package:invoapp/core/localization/app_locale.dart';

import '../state/home/home_bloc.dart';

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
    final homeState = context.watch<HomeBloc>().state;
    return AnimatedStateButton(
      controller: controller,
      initColor: homeState.theme.primary,
      borderRadius: Consts.radius.base.md,
      compactSize: Consts.sizes.base.mega,
      width: Consts.sizes.base.mega,
      height: Consts.sizes.base.mega,
      onPressed: () async => onPressed.call(),
      initChild: Text(
        context.l10n.signIn,
        style: TextStyle(
          fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.body),
          fontWeight: FontWeight.w600,
          color: homeState.theme.text,
        ),
      ),
    );
  }
}
