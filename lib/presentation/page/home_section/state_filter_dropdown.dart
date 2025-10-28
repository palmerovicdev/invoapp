import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/domain/entity/invoice.dart';

class StateFilterDropdown extends StatelessWidget {
  const StateFilterDropdown({
    super.key,
    required this.theme,
    required this.currentState,
    required this.onStateSelected,
  });

  final app_theme.Theme theme;
  final InvoiceState? currentState;
  final Function(InvoiceState?) onStateSelected;

  String _getStateLabel(InvoiceState? state) {
    if (state == null) return 'Todos';

    switch (state) {
      case InvoiceState.draft:
        return 'Borrador';
      case InvoiceState.awaitingPayment:
        return 'En espera';
      case InvoiceState.paid:
        return 'Pagado';
      case InvoiceState.overdue:
        return 'Vencido';
      case InvoiceState.cancelled:
        return 'Cancelado';
    }
  }

  IconData _getStateIcon(InvoiceState? state) {
    if (state == null) return Icons.filter_list;

    switch (state) {
      case InvoiceState.draft:
        return Icons.edit_note;
      case InvoiceState.awaitingPayment:
        return Icons.schedule;
      case InvoiceState.paid:
        return Icons.check_circle;
      case InvoiceState.overdue:
        return Icons.warning;
      case InvoiceState.cancelled:
        return Icons.cancel;
    }
  }

  Color _getStateColor(InvoiceState? state) {
    if (state == null) return theme.textMuted;

    switch (state) {
      case InvoiceState.draft:
        return theme.textMuted;
      case InvoiceState.awaitingPayment:
        return theme.warning;
      case InvoiceState.paid:
        return theme.success;
      case InvoiceState.overdue:
        return theme.danger;
      case InvoiceState.cancelled:
        return theme.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFilter = currentState != null;

    return PopupMenuButton<InvoiceState?>(
      onSelected: (state) => onStateSelected(state),
      offset: Offset(0, Consts.sizes.base.xl),
      color: theme.bgLight,
      shape: RoundedRectangleBorder(
        borderRadius: Consts.radius.containers.md,
        side: BorderSide(
          color: theme.borderMuted.withValues(
            alpha: Consts.ui.opacities.disabled,
          ),
          width: 1,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Consts.spacing.base.sm,
          vertical: Consts.spacing.base.xxs,
        ),
        decoration: BoxDecoration(
          color: hasFilter ? _getStateColor(currentState!).withValues(alpha: 0.15) : theme.bg,
          borderRadius: Consts.radius.containers.sm,
          border: Border.all(
            color: hasFilter
                ? _getStateColor(currentState!).withValues(alpha: 0.5)
                : theme.borderMuted.withValues(
                    alpha: Consts.ui.opacities.disabled,
                  ),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getStateIcon(currentState),
              size: Consts.sizes.icons.md,
              color: _getStateColor(currentState),
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<InvoiceState?>(
          onTap: () => onStateSelected(null),
          value: null,
          child: Row(
            children: [
              Icon(
                Icons.filter_list_off,
                color: theme.text,
                size: Consts.sizes.icons.sm,
              ),
              Consts.spacing.gapHorizontal.sm,
              Text(
                'Todos',
                style: TextStyle(
                  color: theme.text,
                  fontSize: context.getResponsiveFontSize(
                    smallest: Consts.fontSizes.device.mobile.bodySmall,
                  ),
                  fontWeight: currentState == null ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              if (currentState == null) ...[
                const Spacer(),
                Icon(
                  Icons.check,
                  size: Consts.sizes.icons.sm,
                  color: theme.primary,
                ),
              ],
            ],
          ),
        ),
        const PopupMenuDivider(height: 1),
        ...InvoiceState.values.map((state) {
          final isSelected = currentState == state;
          final color = _getStateColor(state);

          return PopupMenuItem<InvoiceState?>(
            value: state,
            child: Row(
              children: [
                Icon(
                  _getStateIcon(state),
                  color: color,
                  size: Consts.sizes.icons.sm,
                ),
                Consts.spacing.gapHorizontal.sm,
                Text(
                  _getStateLabel(state),
                  style: TextStyle(
                    color: isSelected ? color : theme.text,
                    fontSize: context.getResponsiveFontSize(
                      smallest: Consts.fontSizes.device.mobile.bodySmall,
                    ),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                if (isSelected) ...[
                  const Spacer(),
                  Icon(
                    Icons.check,
                    size: Consts.sizes.icons.sm,
                    color: color,
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }
}
