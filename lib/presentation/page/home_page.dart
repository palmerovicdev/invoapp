import 'package:animate_do/animate_do.dart';
import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/domain/entity/invoice.dart';
import 'package:invoapp/presentation/page/home_section/empty_invoices_state.dart';
import 'package:invoapp/presentation/page/home_section/home_header.dart';
import 'package:invoapp/presentation/page/home_section/list_header.dart';
import 'package:invoapp/presentation/page/home_section/navigation_and_search.dart';
import 'package:invoapp/presentation/state/home/home_bloc.dart';
import 'package:invoapp/presentation/widget/invoice_card.dart';
import 'package:invoapp/presentation/widget/invoice_list_item.dart';
import 'package:invoapp/presentation/widget/measure_side.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final Map<int, double> _itemHeights = {};
  static const double _fallbackItemHeight = 72;


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

  void _scrollToNext(HomeState state) {
    final s = context.read<HomeBloc>().state;
    if (s.selectedInvoiceIndex < s.invoices.length - 1) {
      final next = s.selectedInvoiceIndex + 1;
      context.read<HomeBloc>().add(HomeSelectInvoice(next));
      _animateToIndex(next, s);
    }
  }

  void _scrollToPrevious(HomeState state) {
    final s = context.read<HomeBloc>().state;
    if (s.selectedInvoiceIndex > 0) {
      final prev = s.selectedInvoiceIndex - 1;
      context.read<HomeBloc>().add(HomeSelectInvoice(prev));
      _animateToIndex(prev, s);
    }
  }

  void _animateToIndex(int index, HomeState state) {

    double targetOffset = 0;
    for (int i = 0; i < index; i++) {
      targetOffset += _itemHeights[i] ?? _fallbackItemHeight;
    }

    _scrollController.animateTo(
      targetOffset.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      ),
      duration: Consts.durations.base.sm,
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
                HomeHeader(
                  theme: theme,
                  currentLanguageCode: state.locale.languageCode,
                ),
                Expanded(
                  child: state.invoices.isEmpty
                      ? EmptyInvoicesState(theme: theme)
                      : Column(
                          children: [
                            Expanded(
                              flex: 7,
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
                            Expanded(
                              flex: 2,
                              child: NavigationAndSearch(
                                state: state,
                                scrollToNext: () => _scrollToNext(state),
                                scrollToPrevious: () => _scrollToPrevious(state),
                              ),
                            ),
                            ListHeader(theme: theme),
                            Consts.spacing.gap.sm,
                            Expanded(
                              flex: 12,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: state.invoices.length,
                                itemBuilder: (context, index) {
                                  return MeasureSize(
                                    onChange: (size) {
                                      if (_itemHeights[index] != size.height) {
                                        _itemHeights[index] = size.height;
                                      }
                                    },
                                    child: ZoomIn(
                                      delay: Duration(milliseconds: 100 * index),
                                      child: InvoiceListItem(
                                        invoice: state.invoices[index],
                                        theme: theme,
                                        isSelected: index == state.selectedInvoiceIndex,
                                        onTap: () {
                                          context.read<HomeBloc>().add(
                                            HomeSelectInvoice(index),
                                          );
                                          setState(() {});
                                        },
                                      ),
                                    ),
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
}
