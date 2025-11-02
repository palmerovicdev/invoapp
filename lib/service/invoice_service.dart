import 'package:dartz/dartz.dart';
import 'package:invoapp/core/util/error_handler/error_handler.dart';

import '../data/repository/invoice_repository.dart';
import '../domain/entity/invoice.dart';

abstract class InvoiceService {
  Future<Either<ErrorState, List<Invoice>>> getInvoices({
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
  Future<Either<ErrorState, List<Invoice>>> getInvoices({
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
