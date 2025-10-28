part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeToggleLocale extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeSelectInvoice extends HomeEvent {
  final int index;

  const HomeSelectInvoice(this.index);

  @override
  List<Object?> get props => [index];
}

class HomeLoadInvoices extends HomeEvent {
  final DateTime? issuedAtGteq;
  final DateTime? issuedAtLteq;
  final InvoiceState? state;
  final String? searchQuery;
  final int? page;
  final bool clearFilters;
  final bool clearDates;
  final bool clearState;
  final bool clearSearch;
  final bool resetPage;

  const HomeLoadInvoices({
    this.issuedAtGteq,
    this.issuedAtLteq,
    this.state,
    this.searchQuery,
    this.page,
    this.clearFilters = false,
    this.clearDates = false,
    this.clearState = false,
    this.clearSearch = false,
    this.resetPage = false,
  });

  @override
  List<Object?> get props => [
    issuedAtGteq,
    issuedAtLteq,
    state,
    searchQuery,
    page,
    clearFilters,
    clearDates,
    clearState,
    clearSearch,
    resetPage,
  ];
}
