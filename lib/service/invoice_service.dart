import '../data/repository/invoice_repository.dart';
import '../domain/entity/invoice.dart';

abstract class InvoiceService {
  Future<List<Invoice>> getInvoices({
    String? token,
    DateTime? issuedAtGteq,
    DateTime? issuedAtLteq,
    InvoiceState? state,
    String? searchQuery,
    int? page,
  });
}

class InvoiceServiceImpl implements InvoiceService {
  final InvoiceRepository _repository;

  InvoiceServiceImpl(this._repository);

  @override
  Future<List<Invoice>> getInvoices({
    String? token,
    DateTime? issuedAtGteq,
    DateTime? issuedAtLteq,
    InvoiceState? state,
    String? searchQuery,
    int? page,
  }) async {
    return await _repository.getInvoices(
      token: token,
      issuedAtGteq: issuedAtGteq,
      issuedAtLteq: issuedAtLteq,
      state: state,
      searchQuery: searchQuery,
      page: page,
    );
  }
}
