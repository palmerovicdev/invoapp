import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;

class ListHeader extends StatelessWidget {
  const ListHeader({
    super.key,
    required this.theme,
  });

  final app_theme.Theme theme;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Consts.sizes.base.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.l10n.invoices,
            style: TextStyle(
              fontSize: context.getResponsiveFontSize(
                smallest: Consts.fontSizes.device.mobile.body,
              ),
              fontWeight: FontWeight.w700,
              color: theme.text,
            ),
          ),
          Text(
            'Last 4 days',
            style: TextStyle(
              fontSize: context.getResponsiveFontSize(
                smallest: Consts.fontSizes.device.mobile.bodySmall,
              ),
              color: theme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
