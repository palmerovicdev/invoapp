import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/core/util/feedback.dart';
import 'package:invoapp/domain/entity/invoice.dart';
import 'package:invoapp/presentation/state/home/home_bloc.dart';

import 'date_filter_dialog.dart';
import 'state_filter_dropdown.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    super.key,
    required this.theme,
    required this.startDate,
    required this.endDate,
    this.filterState,
  });

  final app_theme.Theme theme;
  final DateTime? startDate;
  final DateTime? endDate;
  final InvoiceState? filterState;

  String _getDateRangeText() {
    if (startDate == null && endDate == null) {
      return 'Todas las fechas';
    }

    if (startDate != null && endDate != null) {
      final start = DateFormat('dd/MM').format(startDate!);
      final end = DateFormat('dd/MM').format(endDate!);
      return '$start - $end';
    }

    if (startDate != null) {
      return 'Desde ${DateFormat('dd/MM/yy').format(startDate!)}';
    }

    return 'Hasta ${DateFormat('dd/MM/yy').format(endDate!)}';
  }

  @override
  Widget build(BuildContext context) {
    final hasDateFilter = startDate != null || endDate != null;

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
          Consts.spacing.gapHorizontal.md,
          Row(
            children: [
              StateFilterDropdown(
                theme: theme,
                currentState: filterState,
                onStateSelected: (state) {
                  context.read<HomeBloc>().add(
                    HomeLoadInvoices(
                      state: state,
                      clearState: state == null,
                      page: 1,
                    ),
                  );
                },
              ),
              Consts.spacing.gapHorizontal.sm,
              GestureDetector(
                onTap: () {
                  click(null);
                  showDialog(
                    context: context,
                    builder: (context) => DateFilterDialog(theme: theme),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Consts.spacing.base.sm,
                    vertical: Consts.spacing.base.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: hasDateFilter
                        ? theme.bg.withValues(alpha: 0.15)
                        : theme.bg,
                    borderRadius: Consts.radius.containers.sm,
                    border: Border.all(
                      color: hasDateFilter
                          ? theme.primary.withValues(alpha: 0.4)
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
                        Icons.calendar_today,
                        size: Consts.sizes.icons.xs,
                        color: hasDateFilter ? theme.primary : theme.textMuted,
                      ),
                      Consts.spacing.gapHorizontal.xs,
                      Text(
                        _getDateRangeText(),
                        style: TextStyle(
                          fontSize: context.getResponsiveFontSize(
                            smallest: Consts.fontSizes.device.mobile.bodySmall,
                          ),
                          color: hasDateFilter
                              ? theme.primary
                              : theme.textMuted,
                          fontWeight: hasDateFilter
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                      if (hasDateFilter) ...[
                        Consts.spacing.gapHorizontal.xs,
                        Icon(
                          Icons.filter_alt,
                          size: Consts.sizes.icons.xs,
                          color: theme.primary,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
