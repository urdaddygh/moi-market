
import 'package:flutter/material.dart';
import 'package:moi_market/core/exceptions/failure_exception.dart';
import 'package:moi_market/core/exceptions/response_is_null_exception.dart';
import 'package:moi_market/core/exceptions/status_code_exception.dart';
import 'package:moi_market/core/exceptions/unexpected_error_exception.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/utils/ui_tools.dart';
import 'package:moi_market/main.dart';

class ApiServiceExceptionHandler {
  Future<void> apiServiceExceptionHandler({required BuildContext context, required Function code}) async {
    try {
      await code();
    } on ResponseIsNullException catch (e) {
      logger.e('[ApiService] ResponseIsNullException occurred ${e.message}');
      if (!context.mounted) return;
      UiTools.showSnackBar(context: context, message: e.message);
    } on FailureException catch (e) {
      logger.e('[ApiService] FailureException occurred ${e.message}');
      if (!context.mounted) return;
      UiTools.showSnackBar(
          context: context,
          message: e.message,
          backgroundColor: Style.primaryErrorColor,
          color: Style.primaryWhiteColor,
          displayDuration: 3000);
    } on StatusCodeException catch (e) {
      logger.e('[ApiService] StatusCodeException occurred ${e.message}');
      if (!context.mounted) return;
      UiTools.showSnackBar(context: context, message: e.message);
    } on UnexpectedErrorException catch (e) {
      logger.e('[ApiService] UnexpectedErrorException occurred ${e.message}');
    } catch (e) {
      logger.e('[ApiService] Exception occurred $e');
      rethrow;
    }
  }
}
