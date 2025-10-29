import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/core/util/feedback.dart';
import 'package:invoapp/presentation/state/home/home_bloc.dart';

class DateFilterDialog extends StatelessWidget {
  const DateFilterDialog({super.key, required this.theme});

  final app_theme.Theme theme;

  Future<void> _selectStartDate(
    BuildContext context,
    DateTime? currentEnd,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.dark(
            primary: theme.primary,
            onPrimary: theme.bgDark,
            surface: theme.bg,
            onSurface: theme.text,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null && context.mounted) {
      context.read<HomeBloc>().add(
        HomeLoadInvoices(
          issuedAtGteq: picked,
          issuedAtLteq: currentEnd != null && currentEnd.isBefore(picked)
              ? picked
              : currentEnd,
          page: 1,
        ),
      );
    }
  }

  Future<void> _selectEndDate(
    BuildContext context,
    DateTime? currentStart,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: currentStart ?? DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.dark(
            primary: theme.primary,
            onPrimary: theme.bgDark,
            surface: theme.bg,
            onSurface: theme.text,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null && context.mounted) {
      context.read<HomeBloc>().add(
        HomeLoadInvoices(
          issuedAtGteq: currentStart,
          issuedAtLteq: picked,
          page: 1,
        ),
      );
    }
  }

  void _setLast7Days(BuildContext context) {
    context.read<HomeBloc>().add(
      HomeLoadInvoices(
        issuedAtGteq: DateTime.now().subtract(const Duration(days: 7)),
        issuedAtLteq: DateTime.now(),
        page: 1,
      ),
    );
  }

  void _setLast30Days(BuildContext context) {
    context.read<HomeBloc>().add(
      HomeLoadInvoices(
        issuedAtGteq: DateTime.now().subtract(const Duration(days: 30)),
        issuedAtLteq: DateTime.now(),
        page: 1,
      ),
    );
  }

  void _setThisMonth(BuildContext context) {
    final now = DateTime.now();
    context.read<HomeBloc>().add(
      HomeLoadInvoices(
        issuedAtGteq: DateTime(now.year, now.month, 1),
        issuedAtLteq: DateTime(now.year, now.month + 1, 0),
        page: 1,
      ),
    );
  }

  void _clearDates(BuildContext context) {
    context.read<HomeBloc>().add(
      const HomeLoadInvoices(
        clearDates: true,
        page: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: theme.bg,
          shape: Consts.radius.shapes.xxl,
          child: Padding(
            padding: Consts.spacing.padding.xxl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.filterByDate,
                      style: TextStyle(
                        fontSize: context.getResponsiveFontSize(
                          smallest: Consts.fontSizes.device.mobile.body,
                        ),
                        fontWeight: FontWeight.w700,
                        color: theme.text,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: theme.textMuted,
                        size: Consts.sizes.icons.md,
                      ),
                    ),
                  ],
                ),
                Consts.spacing.gap.lg,
                Wrap(
                  spacing: Consts.spacing.base.sm,
                  runSpacing: Consts.spacing.base.sm,
                  children: [
                    _buildQuickFilterChip(
                      context,
                      context.l10n.last7Days,
                      () => _setLast7Days(context),
                    ),
                    _buildQuickFilterChip(
                      context,
                      context.l10n.last30Days,
                      () => _setLast30Days(context),
                    ),
                    _buildQuickFilterChip(
                      context,
                      context.l10n.thisMonth,
                      () => _setThisMonth(context),
                    ),
                  ],
                ),
                Consts.spacing.gap.xl,
                _buildDateSelector(
                  context,
                  label: context.l10n.initDate,
                  date: state.issuedAtGteq,
                  onTap: () => _selectStartDate(context, state.issuedAtLteq),
                ),
                Consts.spacing.gap.md,
                _buildDateSelector(
                  context,
                  label: context.l10n.endDate,
                  date: state.issuedAtLteq,
                  onTap: () => _selectEndDate(context, state.issuedAtGteq),
                ),
                Consts.spacing.gap.xl,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          click(null);
                          _clearDates(context);
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.textMuted,
                          side: BorderSide(
                            color: theme.borderMuted,
                            width: 1,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: Consts.spacing.padding.sm.vertical,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: Consts.radius.containers.sm,
                          ),
                        ),
                        child: Text(
                          context.l10n.clearFilters,
                          style: TextStyle(
                            fontSize: context.getResponsiveFontSize(
                              smallest: Consts.fontSizes.device.mobile.body,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Consts.spacing.gapHorizontal.md,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          click(null);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primary,
                          foregroundColor: theme.bgDark,
                          padding: EdgeInsets.symmetric(
                            vertical: Consts.spacing.padding.sm.vertical,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: Consts.radius.containers.sm,
                          ),
                        ),
                        child: Text(
                          context.l10n.close,
                          style: TextStyle(
                            fontSize: context.getResponsiveFontSize(
                              smallest: Consts.fontSizes.device.mobile.body,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickFilterChip(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: () {
        click(null);
        onTap();
      },
      borderRadius: Consts.radius.containers.sm,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Consts.spacing.base.md,
          vertical: Consts.spacing.base.sm,
        ),
        decoration: BoxDecoration(
          color: theme.bgLight,
          borderRadius: Consts.radius.containers.sm,
          border: Border.all(
            color: theme.borderMuted.withValues(
              alpha: Consts.ui.opacities.disabled,
            ),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.getResponsiveFontSize(
              smallest: Consts.fontSizes.device.mobile.bodySmall,
            ),
            color: theme.text,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(
    BuildContext context, {
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.getResponsiveFontSize(
              smallest: Consts.fontSizes.device.mobile.bodySmall,
            ),
            color: theme.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        Consts.spacing.gap.sm,
        InkWell(
          onTap: () {
            click(null);
            onTap();
          },
          borderRadius: Consts.radius.containers.md,
          child: Container(
            padding: EdgeInsets.all(Consts.spacing.base.md),
            decoration: BoxDecoration(
              color: theme.bgLight,
              borderRadius: Consts.radius.containers.md,
              border: Border.all(
                color: theme.borderMuted.withValues(
                  alpha: Consts.ui.opacities.disabled,
                ),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: Consts.sizes.icons.sm,
                  color: theme.text,
                ),
                Consts.spacing.gapHorizontal.md,
                Text(
                  date != null
                      ? DateFormat('dd/MM/yyyy').format(date)
                      : context.l10n.selectDate,
                  style: TextStyle(
                    fontSize: context.getResponsiveFontSize(
                      smallest: Consts.fontSizes.device.mobile.bodySmall,
                    ),
                    color: theme.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
