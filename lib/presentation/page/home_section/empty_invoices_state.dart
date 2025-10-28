import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;

import '../../state/home/home_bloc.dart';

class EmptyInvoicesState extends StatelessWidget {
  const EmptyInvoicesState({
    super.key,
    required this.theme,
  });

  final app_theme.Theme theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: Consts.sizes.base.colossal,
            color: theme.primary,
          ),
          Consts.spacing.gap.xxl,
          Text(
            context.l10n.youHaveNoInvoices,
            style: TextStyle(
              fontSize: context.getResponsiveFontSize(
                smallest: Consts.fontSizes.device.mobile.body,
              ),
              color: theme.textMuted,
            ),
          ),
          Consts.spacing.gap.xl,
          FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(theme.bgLight),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: Consts.radius.containers.md,
                ),
              ),
            ),
            child: Text(
              context.l10n.retryWithoutFilters,
              style: TextStyle(
                fontSize: context.getResponsiveFontSize(
                  smallest: Consts.fontSizes.device.mobile.body,
                ),
                color: theme.primary,
              ),
            ),
            onPressed: () {
              context.read<HomeBloc>().add(const HomeLoadInvoices());
            },
          ),
        ],
      ),
    );
  }
}
