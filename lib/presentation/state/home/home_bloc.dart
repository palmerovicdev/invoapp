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
    final newLocale = state.locale.languageCode == 'en'
        ? const Locale('es')
        : const Locale('en');
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

      final invoices = await _invoiceService.getInvoices(
        token: token,
        issuedAtGteq: event.issuedAtGteq,
        issuedAtLteq: event.issuedAtLteq,
        state: event.state,
        searchQuery: event.searchQuery,
        page: event.page,
      );

      emit(
        state.copyWith(
          invoices: invoices,
          loadingStatus: InvoiceLoadingStatus.loaded,
          selectedInvoiceIndex: 0,
          page: event.page,
          issuedAtGteq: event.issuedAtGteq,
          issuedAtLteq: event.issuedAtLteq,
          filterState: event.state,
        ),
      );
    } catch (e) {
      String message = 'UNEXPECTED_ERROR';
      final error = e.toString();

      if (error.contains('UNAUTHORIZED')) {
        message = 'UNAUTHORIZED';
      } else if (error.contains('FORBIDDEN')) {
        message = 'FORBIDDEN';
      } else if (error.contains('NOT_FOUND')) {
        message = 'NOT_FOUND';
      } else if (error.contains('SERVER_ERROR')) {
        message = 'SERVER_ERROR';
      } else if (error.contains('NETWORK_ERROR')) {
        message = 'NETWORK_ERROR';
      }

      emit(
        state.copyWith(
          loadingStatus: InvoiceLoadingStatus.error,
          errorMessage: message,
          selectedInvoiceIndex: 0,
          page: event.page,
          issuedAtGteq: event.issuedAtGteq,
          issuedAtLteq: event.issuedAtLteq,
          filterState: event.state,
        ),
      );
    }
  }
}
