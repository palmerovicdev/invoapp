import 'package:animate_do/animate_do.dart';
import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/util/feedback.dart';
import 'package:invoapp/presentation/page/home_section/empty_invoices_state.dart';
import 'package:invoapp/presentation/page/home_section/home_header.dart';
import 'package:invoapp/presentation/page/home_section/list_header.dart';
import 'package:invoapp/presentation/page/home_section/list_pagination.dart';
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
  late final PageController _pageController;
  var _isPageChange = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(HomeLoadInvoices());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (_pageController.hasClients) {
          final currentPage = (_pageController.page ?? _pageController.initialPage).round();
          if (currentPage != state.selectedInvoiceIndex) {
            _pageController.animateToPage(
              state.selectedInvoiceIndex,
              duration: Consts.durations.base.sm,
              curve: Curves.easeInOut,
            );
          }
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
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
                                child: GestureDetector(
                                  onHorizontalDragDown: (_) => _isPageChange = true,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: state.invoices.length,
                                    onPageChanged: (index) {
                                      if (_isPageChange) {
                                        context.read<HomeBloc>().add(
                                          HomeSelectInvoice(index),
                                        );
                                      }
                                    },
                                    itemBuilder: (context, index) {
                                      return InvoiceCard(
                                        invoice: state.invoices[index],
                                        theme: theme,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: NavigationAndSearch(
                                  state: state,
                                  scrollToNext: () => click(() => _scrollToNext(state)),
                                  scrollToPrevious: () => click(() => _scrollToPrevious(state)),
                                ),
                              ),
                              ListHeader(theme: theme),
                              Consts.spacing.gap.sm,
                              Expanded(
                                flex: 12,
                                child: state.loadingStatus == InvoiceLoadingStatus.loading
                                    ? Center(
                                        child: ZoomIn(
                                          duration: Consts.durations.base.xl,
                                          child: SizedBox(
                                            height: Consts.sizes.base.colossal,
                                            width: Consts.sizes.base.colossal,
                                            child: CircularProgressIndicator(
                                              color: theme.primary,
                                              strokeWidth: Consts.sizes.base.sm,
                                            ),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
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
                                              delay: Duration(
                                                milliseconds: 100 * index,
                                              ),
                                              child: InvoiceListItem(
                                                invoice: state.invoices[index],
                                                theme: theme,
                                                isSelected: index == state.selectedInvoiceIndex,
                                                onTap: () {
                                                  select(null);
                                                  _isPageChange = false;
                                                  context.read<HomeBloc>().add(
                                                    HomeSelectInvoice(index),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                              Consts.spacing.gap.sm,
                              Expanded(
                                flex: 1,
                                child: ListPagination(
                                  state: state,
                                  theme: theme,
                                  searchController: _searchController,
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
      ),
    );
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
}
