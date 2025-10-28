import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/domain/entity/invoice.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
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

  void _onLoadInvoices(HomeLoadInvoices event, Emitter<HomeState> emit) {
    emit(state.copyWith(invoices: event.invoices, selectedInvoiceIndex: 0));
  }
}
