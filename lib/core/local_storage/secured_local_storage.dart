

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'package:moi_market/main.dart';

class SecuredLocalStorage extends LocalStorage {
  final storage = const FlutterSecureStorage();

  static const tokenKey = 'token';
  static const loginKey = 'login';
  static const passwordKey = 'password';
  static const appSettingsKey = 'app_settings';
  static const isMockAccountKey = 'mock_account';

  @override
  Future<String?> fetchToken() async {
    try {
      return await storage.read(key: tokenKey);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
      return null;
    }
  }

  @override
  Future<void> flushToken() async {
    try {
      await storage.delete(key: tokenKey);
    } catch (e) {
      logger.e('[SecuredLocalStorage] $e');
    }
  }

  @override
  Future<void> writeToken(String value) async {
    try {
      await storage.write(key: tokenKey, value: value);
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
