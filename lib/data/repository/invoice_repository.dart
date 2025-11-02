import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:invoapp/core/env/env.dart';
import 'package:invoapp/core/util/error_handler/error_handler.dart';
import 'package:invoapp/domain/entity/invoice.dart';

abstract class InvoiceRepository {
  Future<Either<ErrorState, List<Invoice>>> getInvoices({
    String? token,
    DateTime? issuedAtGteq,
    DateTime? issuedAtLteq,
    InvoiceState? state,
    String? searchQuery,
    int? page,
  });
}

class InvoiceRepositoryImpl implements InvoiceRepository {
  final String _baseUrl = Env.baseUrl;
  final String _invoicesUrl = Env.invoicesUrl;
  late final Dio _dio;

  InvoiceRepositoryImpl() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '$_baseUrl$_invoicesUrl',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  @override
  Future<Either<ErrorState, List<Invoice>>> getInvoices({
    String? token,
    DateTime? issuedAtGteq,
    DateTime? issuedAtLteq,
    InvoiceState? state,
    String? searchQuery,
    int? page,
  }) async {
    final queryParams = <String, dynamic>{};

    if (issuedAtGteq != null) {
      queryParams['q[issued_at_gteq]'] = DateFormat(
        'yyyy-MM-dd',
      ).format(issuedAtGteq);
    }
    if (issuedAtLteq != null) {
      queryParams['q[issued_at_lteq]'] = DateFormat(
        'yyyy-MM-dd',
      ).format(issuedAtLteq);
    }
    if (state != null) {
      queryParams['q[state_eq]'] = _getStateString(state);
    }
    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams['q[contact_name_or_number_or_reference_or_description_cont]'] = searchQuery;
    }
    if (page != null) {
      queryParams['page'] = page;
    }

    return await ErrorHandler.callApi<List<Invoice>>(
      api: () => _dio.get(
        '',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token ?? ''}',
            'Content-Type': 'application/json',
          },
        ),
      ),
      parse: (data) => (data['invoices'] as List<dynamic>).map((json) => Invoice.fromJson(json)).toList(),
    );
  }

  String _getStateString(InvoiceState state) {
    switch (state) {
      case InvoiceState.draft:
        return 'draft';
      case InvoiceState.awaitingPayment:
        return 'awaiting_payment';
      case InvoiceState.paid:
        return 'paid';
      case InvoiceState.overdue:
        return 'overdue';
      case InvoiceState.cancelled:
        return 'cancelled';
    }
  }
}
