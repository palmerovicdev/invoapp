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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.bgLight,
        borderRadius: BorderRadius.circular(24),
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
              // Logo del contacto
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.bg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.borderMuted.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    invoice.contact.name.isNotEmpty
                        ? invoice.contact.name[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: theme.text,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
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
                    const SizedBox(height: 4),
                    Text(
                      'Invoice #${invoice.number}',
                      style: TextStyle(
                        fontSize: 14,
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
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.text,
                ),
              ),
              Text(
                invoice.amount.formatted,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: theme.primary,
                ),
              ),
            ],
          ),

          Consts.spacing.gap.xxl,

          _buildStateChip(),
        ],
      ),
    );
  }

  Widget _buildStateChip() {
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
