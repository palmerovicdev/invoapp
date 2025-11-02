import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../enums.dart';

part 'error_state.dart';

typedef Parser<T> = T Function(Map<String, dynamic> data);

class ErrorHandler {
  static Future<bool> _isConnected() async {
    final result = await Connectivity().checkConnectivity();
    if (result.first == ConnectivityResult.none) return false;

    try {
      final result = await InternetAddress.lookup('www.youtube.com').timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Envoltorio común para llamadas Dio que devuelve Either<ErrorState, T>
  /// - `api` debe ejecutar la request y retornar un Response
  /// - `parse` recibe `response.data` y retorna T (haz parsing/DTO afuera si quieres)
  static Future<Either<ErrorState<T>, T>> callApi<T>({
    required Future<Response<dynamic>> Function() api,
    required Parser<T> parse,
  }) async {
    try {
      final res = await api();

      final status = res.statusCode ?? 0;
      if (status >= 200 && status < 300) {
        try {
          return right(parse(res.data));
        } catch (e, s) {
          log('Parse error', error: e, stackTrace: s);
          return left(DataParseError<T>(Exception(e.toString())));
        }
      }

      // HTTP
      final httpErr = switch (status) {
        400 => HttpException.badRequest,
        401 => HttpException.unAuthorized,
        403 => HttpException.forbidden,
        404 => HttpException.notFound,
        409 => HttpException.conflict,
        422 => HttpException.unprocessableEntity,
        429 => HttpException.tooManyRequests,
        500 => HttpException.internalServerError,
        _ => HttpException.unknown,
      };
      return left(DataHttpError<T>(httpErr));
    } on DioException catch (e, s) {
      log('DioException', error: e, stackTrace: s);

      // Internet
      if (!await _isConnected()) {
        return left(DataNetworkError<T>(NetworkException.noInternetConnection));
      }

      // Cancelación
      if (e.type == DioExceptionType.cancel) {
        return left(DataNetworkError<T>(NetworkException.cancelled));
      }

      // Timeouts
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.sendTimeout || e.type == DioExceptionType.receiveTimeout) {
        return left(DataNetworkError<T>(NetworkException.timeOutError));
      }

      // SSL
      if (e.type == DioExceptionType.badCertificate) {
        return left(DataNetworkError<T>(NetworkException.badCertificate));
      }

      // HTTP no 2xx
      final status = e.response?.statusCode ?? 0;
      if (status != 0) {
        final httpErr = switch (status) {
          400 => HttpException.badRequest,
          401 => HttpException.unAuthorized,
          403 => HttpException.forbidden,
          404 => HttpException.notFound,
          409 => HttpException.conflict,
          422 => HttpException.unprocessableEntity,
          429 => HttpException.tooManyRequests,
          500 => HttpException.internalServerError,
          _ => HttpException.unknown,
        };
        return left(DataHttpError<T>(httpErr));
      }

      return left(DataNetworkError<T>(NetworkException.unknown));
    } catch (e, s) {
      log('Client exception', error: e, stackTrace: s);
      return left(DataClientError<T>(Exception(e.toString())));
    }
  }
}
