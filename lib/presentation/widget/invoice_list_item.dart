import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/domain/entity/invoice.dart';

class InvoiceListItem extends StatelessWidget {
  final Invoice invoice;
  final app_theme.Theme theme;
  final bool isSelected;
  final VoidCallback onTap;

  const InvoiceListItem({
    super.key,
    required this.invoice,
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Consts.spacing.base.lg,
          vertical: Consts.spacing.base.xs,
        ),
        padding: Consts.spacing.padding.mdl,
        decoration: BoxDecoration(
          color: isSelected ? theme.primary : theme.bg,
          borderRadius: Consts.radius.containers.lg,
          border: Border.all(
            color: isSelected ? theme.secondary.withValues(alpha: 0.7) : theme.borderMuted.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: Consts.sizes.base.giant,
              height: Consts.sizes.base.giant,
              decoration: BoxDecoration(
                color: isSelected ? theme.borderMuted : theme.bgLight,
                borderRadius: Consts.radius.containers.circular,
              ),
              child: Center(
                child: Text(
                  invoice.contact.name.isNotEmpty ? invoice.contact.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontSize: context.getResponsiveFontSize(
                      smallest: Consts.fontSizes.device.mobile.body,
                    ),
                    fontWeight: FontWeight.w600,
                    color: theme.text,
                  ),
                ),
              ),
            ),
            Consts.spacing.gapHorizontal.md,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice.contact.name,
                    style: TextStyle(
                      fontSize: context.getResponsiveFontSize(
                        smallest: Consts.fontSizes.device.mobile.bodySmall,
                      ),
                      fontWeight: FontWeight.w600,
                      color: isSelected ? theme.bgDark : theme.text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Consts.spacing.gap.xs,
                  Row(
                    children: [
                      Text(
                        '#${invoice.number}',
                        style: TextStyle(
                          fontSize: context.getResponsiveFontSize(
                            smallest: Consts.fontSizes.device.mobile.bodySmall,
                          ),
                          color: isSelected ? theme.bgDark : theme.textMuted,
                        ),
                      ),
                      Consts.spacing.gapHorizontal.sm,
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: context.getResponsiveFontSize(
                            smallest: Consts.fontSizes.device.mobile.bodySmall,
                          ),
                          color: isSelected ? theme.bgDark : theme.textMuted,
                        ),
                      ),
                      Consts.spacing.gapHorizontal.sm,
                      Text(
                        DateFormat('MMM dd').format(invoice.issuedAt),
                        style: TextStyle(
                          fontSize: context.getResponsiveFontSize(
                            smallest: Consts.fontSizes.device.mobile.bodySmall,
                          ),
                          color: isSelected ? theme.bgLight : theme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  invoice.amount.formatted,
                  style: TextStyle(
                    fontSize: context.getResponsiveFontSize(
                      smallest: Consts.fontSizes.device.mobile.bodySmall,
                    ),
                    fontWeight: FontWeight.w700,
                    color: isSelected ? theme.bg : theme.text,
                  ),
                ),
                Consts.spacing.gap.xs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      invoice.state.name,
                      style: TextStyle(
                        fontSize: context.getResponsiveFontSize(
                          smallest: 12,
                        ),
                        color: isSelected ? theme.bgDark : theme.textMuted,
                      ),
                    ),
                    Consts.spacing.gapHorizontal.xs,
                    _buildStateIcon(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateIcon() {
    IconData icon;
    Color color;

    switch (invoice.state) {
      case InvoiceState.paid:
        icon = Icons.check_circle;
        color = theme.success;
        break;
      case InvoiceState.awaitingPayment:
        icon = Icons.access_time;
        color = theme.warning;
        break;
      case InvoiceState.overdue:
        icon = Icons.error;
        color = theme.danger;
        break;
      case InvoiceState.draft:
        icon = Icons.edit;
        color = theme.info;
        break;
      case InvoiceState.cancelled:
        icon = Icons.cancel;
        color = theme.textMuted;
        break;
    }

    return Icon(
      icon,
      size: Consts.sizes.icons.sm,
      color: color,
    );
  }
}
