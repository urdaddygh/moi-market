import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:moi_market/application.dart';
import 'package:moi_market/core/cubit/language/language_state.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'package:moi_market/di/service_locator.dart';

final logger = Logger(
  printer: SimplePrinter(
    printTime: true,
    colors: true,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initCertificateForOldAndroids();
  await ServiceLocator().initModules();
  final language = await _fetchLanguageLocal();

  runApp(
    Application(lang: language),
  );
}

Future _initCertificateForOldAndroids() async {
  ByteData isr = await PlatformAssetBundle().load('assets/ca/isrgrootx1.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(isr.buffer.asUint8List());
  ByteData etsEncryptR3 = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(etsEncryptR3.buffer.asUint8List());
}


void initSystemUiMode() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}
Future<Language?> _fetchLanguageLocal() async {
  try {
    switch (await GetIt.I.get<LocalStorage>().readLanguageCode()) {
      case 'ru':
        return Language.ru;
      case 'ky':
        return Language.ky;
      default:
        return null;
    }
  } catch (e) {
    logger.e(e);
  }
  return null;
}