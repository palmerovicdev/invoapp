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
    this.page = 1,
    this.issuedAtGteq,
    this.issuedAtLteq,
    this.filterState,
  });

  final app_theme.Theme theme;
  final Locale locale;
  final List<Invoice> invoices;
  final int selectedInvoiceIndex;
  final InvoiceLoadingStatus loadingStatus;
  final String? errorMessage;
  final int page;
  final DateTime? issuedAtGteq;
  final DateTime? issuedAtLteq;
  final InvoiceState? filterState;

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
    page,
    issuedAtGteq,
    issuedAtLteq,
    filterState,
  ];

  HomeState copyWith({
    app_theme.Theme? theme,
    Locale? locale,
    List<Invoice>? invoices,
    int? selectedInvoiceIndex,
    InvoiceLoadingStatus? loadingStatus,
    String? errorMessage,
    int? page,
    DateTime? issuedAtGteq,
    DateTime? issuedAtLteq,
    InvoiceState? filterState,
    bool clearIssuedAtGteq = false,
    bool clearIssuedAtLteq = false,
    bool clearFilterState = false,
    bool clearErrorMessage = false,
  }) {
    return HomeState(
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      invoices: invoices ?? this.invoices,
      selectedInvoiceIndex: selectedInvoiceIndex ?? this.selectedInvoiceIndex,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      issuedAtGteq: clearIssuedAtGteq ? null : (issuedAtGteq ?? this.issuedAtGteq),
      issuedAtLteq: clearIssuedAtLteq ? null : (issuedAtLteq ?? this.issuedAtLteq),
      filterState: clearFilterState ? null : (filterState ?? this.filterState),
    );
  }
}
