
import 'package:moi_market/features/auth/data/models/success_login.dart';

abstract class LocalStorage {
  Future<bool> readIsTestAccount();
  Future<void> writeIsTestAccount(String value);
  Future<void> flushIsTestAccount();

  Future<SuccessLogin?> fetchAccount();
  Future<void> flushAccount();
  Future<void> writeAccount(SuccessLogin value);

  Future<String?> fetchLogin();
  Future<void> flushLogin();
  Future<void> writeLogin(String value);

  Future<String?> fetchPassword();
  Future<void> flushPassword();
  Future<void> writePassword(String value);

  Future<void> writeLanguageCode(String languageCode);
  Future<String?> readLanguageCode();
  Future<void> flushLanguageCode();
}