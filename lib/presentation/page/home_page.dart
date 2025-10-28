import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/domain/entity/invoice.dart';
import 'package:invoapp/presentation/page/home_section/navigation_and_search.dart';
import 'package:invoapp/presentation/state/home/home_bloc.dart';
import 'package:invoapp/presentation/widget/invoice_card.dart';
import 'package:invoapp/presentation/widget/invoice_list_item.dart';
import 'package:invoapp/presentation/widget/language_button.dart';
import 'package:invoapp/presentation/widget/menu_dropdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(HomeLoadInvoices(_getSampleInvoices()));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Invoice> _getSampleInvoices() {
    return [
      Invoice(
        id: 38,
        companyId: 25,
        number: '3',
        reference: 'jhugugu',
        issuedAt: DateTime(2025, 10, 23),
        dueAt: DateTime(2025, 11, 6),
        state: InvoiceState.awaitingPayment,
        taxAmount: Money(cents: 3075, currency: 'NOK', formatted: '30.75 kr'),
        amountWithoutTaxes: Money(
          cents: 12300,
          currency: 'NOK',
          formatted: '123.00 kr',
        ),
        amount: Money(cents: 15375, currency: 'NOK', formatted: '153.75 kr'),
        amountDue: Money(cents: 15375, currency: 'NOK', formatted: '153.75 kr'),
        amountPaid: Money(cents: 0, currency: 'NOK', formatted: '0.00 kr'),
        humanizedAmount: '153.75 kr',
        createdAt: DateTime(2025, 10, 23, 14, 21, 10),
        updatedAt: DateTime(2025, 10, 23, 14, 21, 31),
        contact: Contact(
          id: 24,
          name: 'Contact1',
          email: 'contact@gmail.com',
          phone: '7863456789',
          website: '',
          actsAsCostumer: true,
          actsAsSupplier: false,
          companyNumber: 'ewre',
          createdAt: DateTime(2025, 10, 21, 1, 36, 8),
          updatedAt: DateTime(2025, 10, 27, 22, 13, 14),
        ),
      ),
      Invoice(
        id: 39,
        companyId: 25,
        number: '4',
        reference: 'REF-001',
        issuedAt: DateTime(2025, 10, 20),
        dueAt: DateTime(2025, 11, 4),
        state: InvoiceState.paid,
        taxAmount: Money(cents: 5000, currency: 'NOK', formatted: '50.00 kr'),
        amountWithoutTaxes: Money(
          cents: 20000,
          currency: 'NOK',
          formatted: '200.00 kr',
        ),
        amount: Money(cents: 25000, currency: 'NOK', formatted: '250.00 kr'),
        amountDue: Money(cents: 0, currency: 'NOK', formatted: '0.00 kr'),
        amountPaid: Money(
          cents: 25000,
          currency: 'NOK',
          formatted: '250.00 kr',
        ),
        humanizedAmount: '250.00 kr',
        createdAt: DateTime(2025, 10, 20, 10, 30, 0),
        updatedAt: DateTime(2025, 10, 25, 15, 20, 0),
        contact: Contact(
          id: 25,
          name: 'Tech Solutions',
          email: 'tech@example.com',
          phone: '1234567890',
          website: 'techsolutions.com',
          actsAsCostumer: true,
          actsAsSupplier: false,
          companyNumber: 'TS001',
          createdAt: DateTime(2025, 10, 15, 9, 0, 0),
          updatedAt: DateTime(2025, 10, 25, 15, 20, 0),
        ),
      ),
      Invoice(
        id: 40,
        companyId: 25,
        number: '5',
        reference: 'REF-002',
        issuedAt: DateTime(2025, 10, 18),
        dueAt: DateTime(2025, 10, 25),
        state: InvoiceState.overdue,
        taxAmount: Money(cents: 2500, currency: 'NOK', formatted: '25.00 kr'),
        amountWithoutTaxes: Money(
          cents: 10000,
          currency: 'NOK',
          formatted: '100.00 kr',
        ),
        amount: Money(cents: 12500, currency: 'NOK', formatted: '125.00 kr'),
        amountDue: Money(cents: 12500, currency: 'NOK', formatted: '125.00 kr'),
        amountPaid: Money(cents: 0, currency: 'NOK', formatted: '0.00 kr'),
        humanizedAmount: '125.00 kr',
        createdAt: DateTime(2025, 10, 18, 8, 15, 0),
        updatedAt: DateTime(2025, 10, 18, 8, 15, 0),
        contact: Contact(
          id: 26,
          name: 'Design Studio',
          email: 'design@example.com',
          phone: '9876543210',
          website: 'designstudio.com',
          actsAsCostumer: true,
          actsAsSupplier: false,
          companyNumber: 'DS001',
          createdAt: DateTime(2025, 10, 10, 11, 30, 0),
          updatedAt: DateTime(2025, 10, 18, 8, 15, 0),
        ),
      ),
    ];
  }

  void _scrollToNext() {
    final state = context.read<HomeBloc>().state;
    if (state.selectedInvoiceIndex < state.invoices.length - 1) {
      context.read<HomeBloc>().add(
        HomeSelectInvoice(state.selectedInvoiceIndex + 1),
      );
      _animateToIndex(state.selectedInvoiceIndex + 1);
    }
  }

  void _scrollToPrevious() {
    final state = context.read<HomeBloc>().state;
    if (state.selectedInvoiceIndex > 0) {
      context.read<HomeBloc>().add(
        HomeSelectInvoice(state.selectedInvoiceIndex - 1),
      );
      _animateToIndex(state.selectedInvoiceIndex - 1);
    }
  }

  void _animateToIndex(int index) {
    final itemHeight = 80.0;
    final targetOffset = index * itemHeight;

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final theme = state.theme;
        return Scaffold(
          backgroundColor: theme.bgDark,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(context, state, theme),
                Expanded(
                  child: state.invoices.isEmpty
                      ? _buildEmptyState(context, theme)
                      : Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: PageView.builder(
                                itemCount: state.invoices.length,
                                onPageChanged: (index) {
                                  context.read<HomeBloc>().add(
                                    HomeSelectInvoice(index),
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return InvoiceCard(
                                    invoice: state.invoices[index],
                                    theme: theme,
                                  );
                                },
                              ),
                            ),

                            SizedBox(
                              height: 42,
                              child: NavigationAndSearch(
                                state: state,
                                scrollToNext: _scrollToNext,
                                scrollToPrevious: _scrollToPrevious,
                              ),
                            ),

                            const SizedBox(height: 16),

                            _buildListHeader(context, theme),

                            const SizedBox(height: 8),

                            Expanded(
                              flex: 5,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: state.invoices.length,
                                itemBuilder: (context, index) {
                                  return InvoiceListItem(
                                    invoice: state.invoices[index],
                                    theme: theme,
                                    isSelected: index == state.selectedInvoiceIndex,
                                    onTap: () {
                                      context.read<HomeBloc>().add(
                                        HomeSelectInvoice(index),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    HomeState state,
    app_theme.Theme theme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LanguageButton(
            currentLanguageCode: state.locale.languageCode,
            onToggle: () {
              context.read<HomeBloc>().add(HomeToggleLocale());
            },
            theme: theme,
          ),
          MenuDropdown(
            theme: theme,
            onAboutTap: () {
              // TODO: Implementar navegación a About
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.aboutApp),
                  backgroundColor: theme.info,
                ),
              );
            },
            onThemeColorTap: () {
              // TODO: Implementar selector de tema
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.themeColor),
                  backgroundColor: theme.info,
                ),
              );
            },
            onLogoutTap: () {
              _showLogoutDialog(context, theme);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader(BuildContext context, app_theme.Theme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              fontSize: 14,
              color: theme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, app_theme.Theme theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: theme.textMuted.withValues(alpha: 0.5),
          ),
          Consts.spacing.gap.xxl,
          Text(
            context.l10n.youHaveNoInvoices,
            style: TextStyle(
              fontSize: context.getResponsiveFontSize(
                smallest: Consts.fontSizes.device.mobile.body,
              ),
              color: theme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, app_theme.Theme theme) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: theme.bg,
        shape: Consts.radius.shapes.xxl,
        child: Padding(
          padding: Consts.spacing.padding.xxl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.doYouWantToLogout,
                style: TextStyle(
                  fontSize: context.getResponsiveFontSize(
                    smallest: Consts.fontSizes.device.mobile.body,
                  ),
                  fontWeight: FontWeight.w600,
                  color: theme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              Consts.spacing.gap.xxl,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.bgLight,
                        foregroundColor: theme.primary,
                        padding: EdgeInsets.symmetric(vertical: Consts.spacing.padding.lg.vertical),
                        shape: RoundedRectangleBorder(
                          borderRadius: Consts.radius.containers.lg,
                          side: BorderSide(
                            color: theme.borderMuted.withOpacity(Consts.ui.opacities.disabled),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(context.l10n.cancel, style: TextStyle(color: theme.primary)),
                    ),
                  ),
                  Consts.spacing.gap.md,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        // TODO: Implementar logout
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.danger.withOpacity(Consts.ui.opacities.disabled),
                        foregroundColor: theme.danger,
                        padding: EdgeInsets.symmetric(vertical: Consts.spacing.padding.lg.vertical),
                        shape: Consts.radius.shapes.lg,
                      ),
                      child: Text(context.l10n.logout),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
