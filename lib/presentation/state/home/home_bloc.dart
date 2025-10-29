import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/domain/entity/invoice.dart';
import 'package:invoapp/presentation/state/login/login_bloc.dart';
import 'package:invoapp/service/invoice_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final InvoiceService _invoiceService;
  final LoginBloc _loginBloc;

  HomeBloc(this._invoiceService, this._loginBloc)
    : super(
        HomeState(
          theme: app_theme.Theme.themes[app_theme.Theme.currentThemeIndex],
        ),
      ) {
    on<HomeToggleLocale>(_onToggleLocale);
    on<HomeSelectInvoice>(_onSelectInvoice);
    on<HomeLoadInvoices>(_onLoadInvoices);
  }

  void _onToggleLocale(HomeToggleLocale event, Emitter<HomeState> emit) {
    final newLocale = state.locale.languageCode == 'en' ? const Locale('es') : const Locale('en');
    emit(state.copyWith(locale: newLocale));
  }

  void _onSelectInvoice(HomeSelectInvoice event, Emitter<HomeState> emit) {
    if (event.index >= 0 && event.index < state.invoices.length) {
      emit(state.copyWith(selectedInvoiceIndex: event.index));
    }
  }

  Future<void> _onLoadInvoices(
    HomeLoadInvoices event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: InvoiceLoadingStatus.loading));

    try {
      final token = _loginBloc.state.token?.token;
      if (token == null) {
        emit(
          state.copyWith(
            loadingStatus: InvoiceLoadingStatus.error,
            errorMessage: 'No authentication token available',
          ),
        );
        return;
      }

      final isStateFilterChange = event.page == 1 && event.clearFilters == false && event.issuedAtGteq == null && event.issuedAtLteq == null && event.searchQuery == null;

      final effectiveIssuedAtGteq = event.clearDates || event.clearFilters ? null : (event.issuedAtGteq ?? state.issuedAtGteq);
      final effectiveIssuedAtLteq = event.clearDates || event.clearFilters ? null : (event.issuedAtLteq ?? state.issuedAtLteq);
      final effectiveState = event.clearState || event.clearFilters ? null : (isStateFilterChange ? event.state : (event.state ?? state.filterState));
      final effectiveSearchQuery = event.searchQuery;
      final effectivePage = event.resetPage ? 1 : (event.page ?? state.page);

      final invoices = await _invoiceService.getInvoices(
        token: token,
        issuedAtGteq: effectiveIssuedAtGteq,
        issuedAtLteq: effectiveIssuedAtLteq,
        state: effectiveState,
        searchQuery: effectiveSearchQuery,
        page: effectivePage,
      );

      emit(
        state.copyWith(
          invoices: invoices,
          loadingStatus: InvoiceLoadingStatus.loaded,
          selectedInvoiceIndex: state.selectedInvoiceIndex,
          page: event.page ?? state.page,
          issuedAtGteq: effectiveIssuedAtGteq,
          issuedAtLteq: effectiveIssuedAtLteq,
          filterState: effectiveState,
          clearIssuedAtGteq: event.clearFilters || event.clearDates,
          clearIssuedAtLteq: event.clearFilters || event.clearDates,
          clearFilterState: event.clearFilters || (isStateFilterChange && event.state == null) || event.clearState,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      final errorMap = {
        'UNAUTHORIZED': 'UNAUTHORIZED',
        'FORBIDDEN': 'FORBIDDEN',
        'NOT_FOUND': 'NOT_FOUND',
        'SERVER_ERROR': 'SERVER_ERROR',
        'NETWORK_ERROR': 'NETWORK_ERROR',
      };

      final error = e.toString();
      final message = errorMap.entries
          .firstWhere(
            (entry) => error.contains(entry.key),
            orElse: () => const MapEntry('', 'UNEXPECTED_ERROR'),
          )
          .value;
      final isStateFilterChange = event.page == 1 && event.clearFilters == false && event.issuedAtGteq == null && event.issuedAtLteq == null && event.searchQuery == null;
      final effectiveIssuedAtGteq = event.clearDates || event.clearFilters ? null : (event.issuedAtGteq ?? state.issuedAtGteq);
      final effectiveIssuedAtLteq = event.clearDates || event.clearFilters ? null : (event.issuedAtLteq ?? state.issuedAtLteq);
      final effectiveState = event.clearState || event.clearFilters ? null : (isStateFilterChange ? event.state : (event.state ?? state.filterState));

      emit(
        state.copyWith(
          loadingStatus: InvoiceLoadingStatus.error,
          errorMessage: message,
          selectedInvoiceIndex: state.selectedInvoiceIndex,
          page: event.page ?? state.page,
          issuedAtGteq: effectiveIssuedAtGteq,
          issuedAtLteq: effectiveIssuedAtLteq,
          filterState: effectiveState,
          clearIssuedAtGteq: event.clearFilters || event.clearDates,
          clearIssuedAtLteq: event.clearFilters || event.clearDates,
          clearFilterState: event.clearFilters || (isStateFilterChange && event.state == null) || event.clearState,
          clearErrorMessage: true,
        ),
      );
    }
  }
}
