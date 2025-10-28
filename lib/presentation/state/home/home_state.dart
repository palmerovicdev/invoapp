part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.theme,
    this.locale = const Locale('en'),
    this.invoices = const [],
    this.selectedInvoiceIndex = 0,
  });

  final app_theme.Theme theme;
  final Locale locale;
  final List<Invoice> invoices;
  final int selectedInvoiceIndex;

  @override
  List<Object?> get props => [theme, locale, invoices, selectedInvoiceIndex];

  HomeState copyWith({
    app_theme.Theme? theme,
    Locale? locale,
    List<Invoice>? invoices,
    int? selectedInvoiceIndex,
  }) {
    return HomeState(
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      invoices: invoices ?? this.invoices,
      selectedInvoiceIndex: selectedInvoiceIndex ?? this.selectedInvoiceIndex,
    );
  }
}
