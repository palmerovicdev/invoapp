import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/domain/entity/invoice.dart';
import 'package:intl/intl.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? theme.bgLight : theme.bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? theme.primary.withValues(alpha: 0.5)
                : theme.borderMuted.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Logo
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.bgLight,
                borderRadius: BorderRadius.circular(12),
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
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.text,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Información
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          invoice.contact.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: theme.text,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildStateIcon(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '#${invoice.number}',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.textMuted,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.textMuted,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('MMM dd').format(invoice.issuedAt),
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Monto
            Text(
              invoice.amount.formatted,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: theme.text,
              ),
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
      size: 18,
      color: color,
    );
  }
}
