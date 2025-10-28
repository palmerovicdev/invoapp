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
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Consts.sizes.base.xl,
        vertical: 8,
      ),
      padding: Consts.spacing.padding.xxl,
      decoration: BoxDecoration(
        color: theme.bgLight,
        borderRadius: Consts.radius.containers.xxl,
        border: Border.all(
          color: theme.borderMuted.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Consts.sizes.base.ultra,
                height: Consts.sizes.base.ultra,
                decoration: BoxDecoration(
                  color: theme.bg,
                  borderRadius: Consts.radius.containers.lg,
                  border: Border.all(
                    color: theme.borderMuted.withValues(
                      alpha: Consts.ui.opacities.disabled,
                    ),
                    width: Consts.sizes.base.xxs,
                  ),
                ),
                child: Center(
                  child: Text(
                    invoice.contact.name.isNotEmpty
                        ? invoice.contact.name[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: context.getResponsiveFontSize(
                        smallest: Consts.fontSizes.device.mobile.bodyLarge,
                      ),
                      fontWeight: FontWeight.w600,
                      color: theme.text,
                    ),
                  ),
                ),
              ),
              Consts.spacing.gapHorizontal.lg,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.contact.name,
                      style: TextStyle(
                        fontSize: context.getResponsiveFontSize(
                          smallest: Consts.fontSizes.device.mobile.body,
                        ),
                        fontWeight: FontWeight.w600,
                        color: theme.text,
                      ),
                    ),
                    Consts.spacing.gap.xs,
                    Text(
                      'Invoice #${invoice.number}',
                      style: TextStyle(
                        fontSize: context.getResponsiveFontSize(
                          smallest: Consts.fontSizes.device.mobile.bodySmall,
                        ),
                        color: theme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Consts.spacing.gap.xxl,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: context.getResponsiveFontSize(
                    smallest: Consts.fontSizes.device.mobile.body,
                  ),
                  fontWeight: FontWeight.w700,
                  color: theme.text,
                ),
              ),
              Text(
                invoice.amount.formatted,
                style: TextStyle(
                  fontSize: context.getResponsiveFontSize(
                    smallest: Consts.fontSizes.device.mobile.bodyLarge,
                  ),
                  fontWeight: FontWeight.w700,
                  color: theme.primary,
                ),
              ),
            ],
          ),

          Consts.spacing.gap.xxl,

          _buildStateChip(context),
        ],
      ),
    );
  }

  Widget _buildStateChip(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (invoice.state) {
      case InvoiceState.paid:
        backgroundColor = theme.success.withValues(alpha: 0.2);
        textColor = theme.success;
        text = 'Paid';
        break;
      case InvoiceState.awaitingPayment:
        backgroundColor = theme.warning.withValues(alpha: 0.2);
        textColor = theme.warning;
        text = 'Awaiting Payment';
        break;
      case InvoiceState.overdue:
        backgroundColor = theme.danger.withValues(alpha: 0.2);
        textColor = theme.danger;
        text = 'Overdue';
        break;
      case InvoiceState.draft:
        backgroundColor = theme.info.withValues(alpha: 0.2);
        textColor = theme.info;
        text = 'Draft';
        break;
      case InvoiceState.cancelled:
        backgroundColor = theme.textMuted.withValues(alpha: 0.2);
        textColor = theme.textMuted;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Consts.spacing.base.lg,
        vertical: Consts.spacing.base.sm,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: Consts.radius.containers.md,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: context.getResponsiveFontSize(
              smallest: Consts.fontSizes.device.mobile.bodySmall,
            ),
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
