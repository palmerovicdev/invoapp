import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';

import '../state/home/home_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeBloc>().state;
    return Scaffold(
      backgroundColor: homeState.theme.bgDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: homeState.theme.bgLight,
                borderRadius: Consts.radius.containers.xl,
              ),
              child: Center(
                child: Icon(
                  Icons.home_rounded,
                  size: Consts.sizes.base.extreme,
                  color: homeState.theme.primary,
                ),
              ),
            ),
            Consts.spacing.gap.giant,
            Text(
              context.l10n.invoApp,
              style: TextStyle(
                fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.paragraphTitle),
                fontWeight: FontWeight.bold,
                color: homeState.theme.text,
              ),
            ),
            Consts.spacing.gap.huge,
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                strokeWidth: Consts.sizes.base.sm,
                valueColor: AlwaysStoppedAnimation(homeState.theme.primary),
              ),
            ),
            Consts.spacing.gap.ultra,
            Text(
              context.l10n.checkingAuth,
              style: TextStyle(
                fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.body),
                color: homeState.theme.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
