

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'package:moi_market/features/auth/data/models/success_login.dart';
import 'package:moi_market/main.dart';

class SecuredLocalStorage extends LocalStorage {
  final storage = const FlutterSecureStorage();

  static const accountKey = 'account';
  static const loginKey = 'login';
  static const passwordKey = 'password';
  static const appSettingsKey = 'app_settings';
  static const isMockAccountKey = 'mock_account';

  @override
  Future<SuccessLogin?> fetchAccount() async {
    try {
      var account = await storage.read(key: accountKey);
      return SuccessLogin.fromJson(jsonDecode(account ?? ''));
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
      return null;
    }
  }

  @override
  Future<void> flushAccount() async {
    try {
      await storage.delete(key: accountKey);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
    }
  }

  @override
  Future<void> writeAccount(SuccessLogin value) async {
    try {
      await storage.write(key: accountKey, value: jsonEncode(value.toJson()));
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
    }
  }

  @override
  Future<String?> fetchLogin() async {
    try {
      return await storage.read(key: loginKey);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
      return null;
    }
  }

  @override
  Future<void> flushLogin() async {
    try {
      await storage.delete(key: loginKey);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
    }
  }

  @override
  Future<void> writeLogin(String value) async {
    try {
      await storage.write(key: loginKey, value: value);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
    }
  }

  @override
  Future<String?> fetchPassword() async {
    try {
      return await storage.read(key: passwordKey);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
      return null;
    }
  }

  @override
  Future<void> flushPassword() async {
    try {
      await storage.delete(key: passwordKey);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
    }
  }

  @override
  Future<void> writePassword(String value) async {
    try {
      await storage.write(key: passwordKey, value: value);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
    }
  }

  @override
  Future<void> flushIsTestAccount() async {
    try {
      await storage.delete(key: isMockAccountKey);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
    }
  }

  @override
  Future<bool> readIsTestAccount() async {
    try {
      return await storage.read(key: isMockAccountKey) == 'true';
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
      return false;
    }
  }

  @override
  Future<void> writeIsTestAccount(String value) async {
    try {
      await storage.write(key: isMockAccountKey, value: value);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
    }
  }

}
