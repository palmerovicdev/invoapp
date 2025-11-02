import 'package:animate_do/animate_do.dart';
import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/domain/entity/invoice.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  final app_theme.Theme theme;

  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Consts.sizes.base.xl,
          vertical: 8,
        ),
        padding: Consts.spacing.padding.xxl,
        decoration: BoxDecoration(
          color: theme.primary,
          borderRadius: Consts.radius.containers.xxl,
          border: Border.all(
            color: theme.borderMuted.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.bgDark.withValues(alpha: 0.12),
                  borderRadius: Consts.radius.containers.sm,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Consts.spacing.base.smd,
                    vertical: Consts.spacing.base.xxs,
                  ),
                  child: Text(
                    invoice.amount.currency,
                    style: TextStyle(
                      fontSize: context.getResponsiveFontSize(
                        smallest: Consts.fontSizes.components.badge.body,
                      ),
                      fontWeight: FontWeight.w300,
                      color: theme.bgDark,
                    ),
                  ),
                ),
              ),
              Consts.spacing.gap.sm,

              Text(
                invoice.amount.formatted,
                style: TextStyle(
                  fontSize: context.getResponsiveFontSize(
                    smallest: Consts.fontSizes.device.mobile.h1,
                  ),
                  fontWeight: FontWeight.w400,
                  color: theme.bgDark,
                ),
              ),

              Consts.spacing.gap.sm,

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: Consts.spacing.base.md,
                  children: [
                    Text(
                      invoice.amountWithoutTaxes.formatted,
                      style: TextStyle(
                        color: theme.bgDark.withValues(alpha: 0.5),
                        fontSize: context.getResponsiveFontSize(
                          smallest: Consts.fontSizes.device.mobile.bodySmall,
                        ),
                      ),
                    ),
                    Text(
                      '+${invoice.taxAmount.formatted}',
                      style: TextStyle(
                        color: theme.bgLight,
                        fontSize: context.getResponsiveFontSize(
                          smallest: Consts.fontSizes.device.mobile.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
