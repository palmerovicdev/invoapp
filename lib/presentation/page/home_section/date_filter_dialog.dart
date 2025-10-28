import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/core/util/feedback.dart';

class DateFilterDialog extends StatefulWidget {
  const DateFilterDialog({
    super.key,
    required this.theme,
    required this.initialStartDate,
    required this.initialEndDate,
  });

  final app_theme.Theme theme;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  @override
  State<DateFilterDialog> createState() => _DateFilterDialogState();
}

class _DateFilterDialogState extends State<DateFilterDialog> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: widget.theme.primary,
              onPrimary: widget.theme.bgDark,
              surface: widget.theme.bg,
              onSurface: widget.theme.text,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: widget.theme.primary,
              onPrimary: widget.theme.bgDark,
              surface: widget.theme.bg,
              onSurface: widget.theme.text,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  void _clearDates() {
    setState(() {
      _startDate = null;
      _endDate = null;
    });
  }

  void _setLast7Days() {
    setState(() {
      _endDate = DateTime.now();
      _startDate = DateTime.now().subtract(const Duration(days: 7));
    });
  }

  void _setLast30Days() {
    setState(() {
      _endDate = DateTime.now();
      _startDate = DateTime.now().subtract(const Duration(days: 30));
    });
  }

  void _setThisMonth() {
    final now = DateTime.now();
    setState(() {
      _startDate = DateTime(now.year, now.month, 1);
      _endDate = DateTime(now.year, now.month + 1, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: widget.theme.bg,
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
                  'Filtrar por fecha',
                  style: TextStyle(
                    fontSize: context.getResponsiveFontSize(
                      smallest: Consts.fontSizes.device.mobile.body,
                    ),
                    fontWeight: FontWeight.w700,
                    color: widget.theme.text,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: widget.theme.textMuted,
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
                _buildQuickFilterChip('Últimos 7 días', _setLast7Days),
                _buildQuickFilterChip('Últimos 30 días', _setLast30Days),
                _buildQuickFilterChip('Este mes', _setThisMonth),
              ],
            ),

            Consts.spacing.gap.xl,

            _buildDateSelector(
              label: 'Fecha inicio',
              date: _startDate,
              onTap: _selectStartDate,
            ),

            Consts.spacing.gap.md,

            _buildDateSelector(
              label: 'Fecha fin',
              date: _endDate,
              onTap: _selectEndDate,
            ),

            Consts.spacing.gap.xl,

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      click(null);
                      _clearDates();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: widget.theme.textMuted,
                      side: BorderSide(
                        color: widget.theme.borderMuted,
                        width: 1,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: Consts.spacing.padding.sm.vertical,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: Consts.radius.containers.md,
                      ),
                    ),
                    child: Text(
                      'Limpiar',
                      style: TextStyle(
                        fontSize: context.getResponsiveFontSize(
                          smallest: Consts.fontSizes.device.mobile.bodySmall,
                        ),
                      ),
                    ),
                  ),
                ),
                Consts.spacing.gapHorizontal.md,
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      click(null);
                      Navigator.pop(context, {
                        'startDate': _startDate,
                        'endDate': _endDate,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.theme.primary,
                      foregroundColor: widget.theme.bgDark,
                      padding: EdgeInsets.symmetric(
                        vertical: Consts.spacing.padding.sm.vertical,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: Consts.radius.containers.md,
                      ),
                    ),
                    child: Text(
                      'Aplicar filtro',
                      style: TextStyle(
                        fontSize: context.getResponsiveFontSize(
                          smallest: Consts.fontSizes.device.mobile.bodySmall,
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
  }

  Widget _buildQuickFilterChip(String label, VoidCallback onTap) {
    return InkWell(
      onTap: () => {
        click(null),
        onTap(),
      },
      borderRadius: Consts.radius.containers.sm,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Consts.spacing.base.md,
          vertical: Consts.spacing.base.sm,
        ),
        decoration: BoxDecoration(
          color: widget.theme.bgLight,
          borderRadius: Consts.radius.containers.sm,
          border: Border.all(
            color: widget.theme.borderMuted.withValues(
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
            color: widget.theme.text,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector({
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
            color: widget.theme.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        Consts.spacing.gap.sm,
        InkWell(
          onTap: () => {
            click(null),
            onTap(),
          },
          borderRadius: Consts.radius.containers.md,
          child: Container(
            width: double.infinity,
            padding: Consts.spacing.padding.md,
            decoration: BoxDecoration(
              color: widget.theme.bgLight,
              borderRadius: Consts.radius.containers.md,
              border: Border.all(
                color: widget.theme.borderMuted.withValues(
                  alpha: Consts.ui.opacities.disabled,
                ),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null ? DateFormat('dd/MM/yyyy').format(date) : 'Seleccionar fecha',
                  style: TextStyle(
                    fontSize: context.getResponsiveFontSize(
                      smallest: Consts.fontSizes.device.mobile.bodySmall,
                    ),
                    color: date != null ? widget.theme.text : widget.theme.textMuted,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: Consts.sizes.icons.sm,
                  color: widget.theme.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
