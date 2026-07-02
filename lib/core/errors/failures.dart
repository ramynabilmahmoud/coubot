// ignore_for_file: lines_longer_than_80_chars, constant_pattern_never_matches_value_type

import 'package:coubot/generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// this class is used to manage the failures
abstract class Failure {
  /// Initializes the [Failure] class with the given [errMessage] and [errType].
  Failure(this.errMessage, this.errType);

  /// A factory method to create a [Failure] instance from a dynamic object.
  factory Failure.fromObject(dynamic e) {
    if (e is PostgrestException ||
        e is AuthException ||
        e is AuthApiException) {
      return Failure.fromException(e as Exception);
    } else if (e is PlatformException) {
      return PlatformExceptionFailure.fromSupabaseError(e);
    } else {
      return RegularFailure.fromException(Exception(e.toString()));
    }
  }

  /// A factory method to create a [Failure]
  /// instance from an [Exception] instance.
  factory Failure.fromException(Exception e) {
    switch (e.runtimeType) {
      case (PostgrestException() || AuthException() || AuthApiException()):
        return SupabaseFailure.fromSupabaseError(e);
      case DioException():
        return DioFailure.fromDioError(e as DioException);
      default:
        return RegularFailure.fromException(e);
    }
  }

  /// The error message.
  final String errMessage;

  /// The error type.
  final String errType;

  @override
  String toString() {
    return 'Failure: $errMessage';
  }
}

/// A class to represent the different
/// types of failures that can occur in the app.
class SupabaseFailure extends Failure {
  /// Initializes the [SupabaseFailure]
  ///  class with the given [errMessage] and [errType].
  SupabaseFailure(String errMessage) : super(errMessage, 'Supabase Exception');

  /// A factory method to create a [SupabaseFailure]
  /// instance from an [Exception] instance.
  factory SupabaseFailure.fromSupabaseError(dynamic e) {
    switch (e.runtimeType) {
      case PostgrestException():
        return SupabaseFailure.fromSupabasePostgrestException(
          e as PostgrestException,
        );
      case (AuthException() || AuthApiException()):
        return SupabaseFailure.fromAuthException(e as AuthException);
      default:
        return SupabaseFailure(e.toString());
    }
  }

  /// A factory method to create a [SupabaseFailure]
  /// instance from a [PostgrestException] instance.
  factory SupabaseFailure.fromSupabasePostgrestException(PostgrestException e) {
    return SupabaseFailure(e.message);
  }

  /// A factory method to create a [SupabaseFailure]
  /// instance from an [AuthException] instance.
  factory SupabaseFailure.fromAuthException(AuthException e) {
    return SupabaseFailure(e.message);
  }

  @override
  String toString() {
    return 'SupabaseFailure: $errMessage';
  }
}

/// A class to represent the different types of failures that can occur in the app.
class DioFailure extends Failure {
  /// Initializes the [DioFailure] class with the given [errMessage].
  DioFailure(String errMessage) : super(errMessage, 'Dio Exception');

  /// A factory method to create a [DioFailure] instance from a [DioException] instance.
  factory DioFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return DioFailure(S.current.connectionTimeoutWithApiserver);
      case DioExceptionType.sendTimeout:
        return DioFailure(S.current.sendTimeoutWithApiserver);
      case DioExceptionType.receiveTimeout:
        return DioFailure(S.current.receiveTimeoutInConnectionWithApiserver);
      case DioExceptionType.badCertificate:
        return DioFailure(S.current.badCertificateWithApiserver);
      case DioExceptionType.badResponse:
        return DioFailure(S.current.badResponseFromApiserver);
      case DioExceptionType.cancel:
        return DioFailure(S.current.requestToApiserverWasCancelled);
      case DioExceptionType.connectionError:
        if (e.message!.contains('SocketException')) {
          return DioFailure(S.current.noInternetConnection);
        }
        return DioFailure(S.current.connectionErrorWithApiserver);

      case DioExceptionType.unknown:
        return DioFailure(S.current.unknownErrorOccurred);
      case DioExceptionType.transformTimeout:
        return DioFailure(S.current.transformTimeoutWithApiServer);
    }
  }

  /// A factory method to create a [DioFailure] instance from a [statusCode] and [response].
  factory DioFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 401) {
      return DioFailure('opps there was an error, please try again');
    }
    if ([400, 403, 422, 404].contains(statusCode)) {
      final responseMap = response as Map<String, dynamic>;

      return DioFailure(
        responseMap['message'] as String? ??
            S.current.oppsThereWasAnErrorPleaseTryAgain,
      );
    } else if (statusCode == 500) {
      return DioFailure(S.current.internalServerError);
    } else {
      return DioFailure(S.current.oppsThereWasAnErrorPleaseTryAgain);
    }
  }

  @override
  String toString() {
    return 'DioFailure: $errMessage';
  }
}

/// A class to represent the different types of failures that can occur in the app.
class RegularFailure extends Failure {
  /// Initializes the [RegularFailure] class with the given [errMessage].
  RegularFailure(String errMessage) : super(errMessage, 'Regular Exception');

  /// A factory method to create a [RegularFailure] instance from a [Exception] instance.
  factory RegularFailure.fromException(Exception e) {
    return RegularFailure(e.toString());
  }

  @override
  String toString() {
    return 'RegularFailure: $errMessage';
  }
}

/// a failure class for an authentication failure
class AuthFailure extends Failure {
  /// constructor
  AuthFailure({required String errMessage})
    : super(errMessage, 'Auth Exception');

  /// factory method to create an AuthFailure object from a SupabaseError object
  factory AuthFailure.fromSupabaseError(AuthException error) {
    return AuthFailure(errMessage: error.message);
  }
}

/// PlatformExceptionFailure
class PlatformExceptionFailure extends Failure {
  /// constructor
  PlatformExceptionFailure({required String errMessage})
    : super(errMessage, 'Platform Exception');

  /// factory method to create an PlatformExceptionFailure object from a SupabaseError object
  factory PlatformExceptionFailure.fromSupabaseError(PlatformException error) {
    switch (error.code) {
      case 'sign_in_failed':
        return PlatformExceptionFailure(
          errMessage: S.current.signInFailedPleaseTryAgain,
        );

      default:
        return PlatformExceptionFailure(errMessage: S.current.anErrorOccurred);
    }
  }
}
