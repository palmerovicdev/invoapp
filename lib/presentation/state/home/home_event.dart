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
  final List<Invoice> invoices;

  const HomeLoadInvoices(this.invoices);

  @override
  List<Object?> get props => [invoices];
}
