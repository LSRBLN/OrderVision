import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/app.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BrandingConfig.bootstrap();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  await SystemChrome.setPreferredOrientations(const <DeviceOrientation>[
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  try {
    await IsarService.instance.init().timeout(const Duration(seconds: 8));
  } on TimeoutException {
    debugPrint(
      'Isar init timed out after 8s. Continuing app startup without blocking.',
    );
  } catch (error, stackTrace) {
    debugPrint('Isar init failed during startup: $error');
    debugPrint('$stackTrace');
  }
  runApp(const ProviderScope(child: OrdermanApp()));
}
