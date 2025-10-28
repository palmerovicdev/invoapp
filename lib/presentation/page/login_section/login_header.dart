import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';

import '../../state/home/home_bloc.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeBloc>().state;
    return Column(
      children: [
        Consts.spacing.gap.giant,
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: homeState.theme.bgLight,
              borderRadius: AppRadius.borderXl,
            ),
            child: Center(
              child: Icon(
                Icons.currency_bitcoin_sharp,
                size: Consts.ui.icons.huge,
                color: homeState.theme.primary,
              ),
            ),
          ),
        ),
        Consts.spacing.gap.giant,
        Text(
          context.l10n.welcomeBack,
          style: TextStyle(
            fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.bodySmall),
            fontWeight: FontWeight.bold,
            color: homeState.theme.text,
          ),
          textAlign: TextAlign.center,
        ),
        Consts.spacing.gap.md,
        Text(
          context.l10n.invoApp,
          style: TextStyle(
            fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.body),
            color: homeState.theme.textMuted,
          ),
          textAlign: TextAlign.center,
        ),
        Consts.spacing.gap.giant,
      ],
    );
  }
}
