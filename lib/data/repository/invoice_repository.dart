import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:invoapp/core/env/env.dart';
import 'package:invoapp/domain/entity/invoice.dart';

abstract class InvoiceRepository {
  Future<List<Invoice>> getInvoices({
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
  Future<List<Invoice>> getInvoices({
    String? token,
    DateTime? issuedAtGteq,
    DateTime? issuedAtLteq,
    InvoiceState? state,
    String? searchQuery,
    int? page,
  }) async {
    try {
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
        queryParams['q[contact_name_or_number_or_reference_or_description_cont]'] =
            searchQuery;
      }
      if (page != null) {
        queryParams['page'] = page;
      }

      final response = await _dio.get(
        '',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token ?? ''}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('SERVER_ERROR');
      }

      final List<dynamic> invoicesData = response.data['invoices'] ?? [];
      return invoicesData.map((json) => Invoice.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('NETWORK_ERROR');
      } else if (e.response?.statusCode == 401) {
        throw Exception('UNAUTHORIZED');
      } else if (e.response?.statusCode == 403) {
        throw Exception('FORBIDDEN');
      } else if (e.response?.statusCode == 404) {
        throw Exception('NOT_FOUND');
      } else if (e.response?.statusCode != null &&
          e.response!.statusCode! >= 500) {
        throw Exception('SERVER_ERROR');
      }
      throw Exception('UNEXPECTED_ERROR');
    } catch (e) {
      throw Exception('UNEXPECTED_ERROR');
    }
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
