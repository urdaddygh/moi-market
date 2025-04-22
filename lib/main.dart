import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:moi_market/application.dart';
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

  runApp(
    const Application(),
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