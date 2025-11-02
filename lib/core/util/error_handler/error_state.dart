part of 'error_handler.dart';

sealed class ErrorState<T> {
  final Exception? clientError;
  final Exception? parseError;
  final HttpException? httpError;
  final NetworkException? networkError;

  const ErrorState({
    this.clientError,
    this.parseError,
    this.httpError,
    this.networkError,
  });

  R when<R>({
    required R Function(NetworkException e) network,
    required R Function(HttpException e) http,
    required R Function(Exception e) parse,
    required R Function(Exception e) client,
  }) {
    if (networkError != null) return network(networkError!);
    if (httpError != null) return http(httpError!);
    if (parseError != null) return parse(parseError!);
    if (clientError != null) return client(clientError!);
    throw StateError('No error present in ErrorState');
  }

  String getMessage(bool isLogin) {
    return when<String>(
      network: (e) {
        switch (e) {
          case NetworkException.noInternetConnection:
            return 'noInternet';
          case NetworkException.timeOutError:
            return 'timeout';
          case NetworkException.cancelled:
            return 'canceled';
          case NetworkException.badCertificate:
            return 'ssl';
          case NetworkException.unknown:
            return 'network';
        }
      },
      http: (e) {
        switch (e) {
          case HttpException.unAuthorized:
            return 'unauthorized';
          case HttpException.forbidden:
            return 'noPermission';
          case HttpException.notFound:
            return 'notFound';
          case HttpException.conflict:
            return 'conflict';
          case HttpException.internalServerError:
            return 'serverError';
          case HttpException.badRequest:
            return 'invalidRequest';
          case HttpException.tooManyRequests:
            return 'tooManyRequests';
          case HttpException.unprocessableEntity:
            return isLogin ? 'invalidCredentials' : 'notProcessable';
          case HttpException.unknown:
            return 'unknownError';
        }
      },
      parse: (e) => 'errorParsingData',
      client: (e) => 'clientError',
    );
  }
}

final class DataClientError<T> extends ErrorState<T> {
  DataClientError(Exception error) : super(clientError: error) {
    log('DataClientError: client error captured!', error: error);
  }
}

final class DataNetworkError<T> extends ErrorState<T> {
  DataNetworkError(NetworkException error) : super(networkError: error) {
    log('DataNetworkError: network error captured!', error: error);
  }
}

final class DataHttpError<T> extends ErrorState<T> {
  DataHttpError(HttpException error) : super(httpError: error) {
    log('DataHttpError: HTTP error captured!', error: error);
  }
}

final class DataParseError<T> extends ErrorState<T> {
  DataParseError(Exception error) : super(parseError: error) {
    log('DataParseError: Unable to parse the data!', error: error);
  }
}
