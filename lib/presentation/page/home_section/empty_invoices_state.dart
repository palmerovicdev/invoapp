import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;

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
            size: Consts.sizes.base.massive,
            color: theme.textMuted.withValues(alpha: Consts.ui.opacities.hover),
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
        ],
      ),
    );
  }
}
