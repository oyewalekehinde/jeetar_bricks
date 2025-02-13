import 'package:dio/dio.dart';
import 'interceptors.dart';

class HttpService {
  Dio? _dio;
  final String baseUrl;
  final bool hasAuthorization;
  final bool isFormType;

  HttpService(
      {required this.baseUrl,
      this.hasAuthorization = false,
      this.isFormType = false}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 25),
    ));
    _interceptorsInit();
  }
  static const int timeoutDuration = 1;

  Future<Response> getRequest(
    urlEndPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;

    response = await _dio!
        .get(urlEndPoint, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));
    return response;
  }

  Future<Response> post(
    urlEndpoint, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;

    response = await _dio!
        .post(urlEndpoint, data: data, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));
    return response;
  }

  Future<Response> put(urlEndpoint,
      {data, Map<String, dynamic>? queryParameters}) async {
    Response response;

    response = await _dio!
        .put(urlEndpoint, data: data, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));

    return response;
  }

  Future<Response> delete(urlEndpoint,
      {data, Map<String, dynamic>? queryParameters}) async {
    Response response;

    response = await _dio!
        .delete(urlEndpoint, data: data, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));

    return response;
  }

  Future<Response> patch(urlEndpoint,
      {data, Map<String, dynamic>? queryParameters}) async {
    Response response;

    response = await _dio!
        .patch(urlEndpoint, data: data, queryParameters: queryParameters)
        .timeout(const Duration(minutes: timeoutDuration));

    return response;
  }

  _interceptorsInit() {
    _dio!.interceptors.add(HeaderInterceptor(
        hasToken: hasAuthorization,
        dio: _dio!,
        contentType: isFormType
            ? HeaderContentType.formType
            : HeaderContentType.jsonType));
  }
}

extension ResponseExt on Response {
  bool get isSuccessful => statusCode! >= 200 && statusCode! < 300;
  get body => data;
}

String errorDefaultMessage = "An error occurred";
// Error Handler Function
String networkErrorHandler(DioException error,
    {Function(DioException e)? onResponseError}) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      if (onResponseError == null && error.response != null) {
        if (error.response?.statusCode == 500) {
          return errorDefaultMessage;
        }
        return error.response?.data["message"];
      }
      return onResponseError!(error);
    case DioExceptionType.connectionTimeout:
      return "Kindly try again, poor internet connection";
    case DioExceptionType.sendTimeout:
      return "Kindly try again, poor internet connection";
    case DioExceptionType.receiveTimeout:
      return "Kindly try again, poor internet connection";
    case DioExceptionType.cancel:
      return "Request cancelled";
    case DioExceptionType.unknown:
      return "No internet connection";
    default:
      return errorDefaultMessage;
  }
}
