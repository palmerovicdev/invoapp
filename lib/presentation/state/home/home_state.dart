part of 'home_bloc.dart';

enum InvoiceLoadingStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  const HomeState({
    required this.theme,
    this.locale = const Locale('en'),
    this.invoices = const [],
    this.selectedInvoiceIndex = 0,
    this.loadingStatus = InvoiceLoadingStatus.initial,
    this.errorMessage,
  });

  final app_theme.Theme theme;
  final Locale locale;
  final List<Invoice> invoices;
  final int selectedInvoiceIndex;
  final InvoiceLoadingStatus loadingStatus;
  final String? errorMessage;

  bool get isLoading => loadingStatus == InvoiceLoadingStatus.loading;
  bool get hasError => loadingStatus == InvoiceLoadingStatus.error;
  bool get isLoaded => loadingStatus == InvoiceLoadingStatus.loaded;

  @override
  List<Object?> get props => [
    theme,
    locale,
    invoices,
    selectedInvoiceIndex,
    loadingStatus,
    errorMessage,
  ];

  HomeState copyWith({
    app_theme.Theme? theme,
    Locale? locale,
    List<Invoice>? invoices,
    int? selectedInvoiceIndex,
    InvoiceLoadingStatus? loadingStatus,
    String? errorMessage,
  }) {
    return HomeState(
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      invoices: invoices ?? this.invoices,
      selectedInvoiceIndex: selectedInvoiceIndex ?? this.selectedInvoiceIndex,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
