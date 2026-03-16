import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/app.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  final overlayStyle = brightness == Brightness.dark
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    overlayStyle.copyWith(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      statusBarIconBrightness:
          brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness:
          brightness == Brightness.dark ? Brightness.light : Brightness.dark,
    ),
  );
  await SystemChrome.setPreferredOrientations(const <DeviceOrientation>[
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await IsarService.instance.init();
  runApp(
    const ProviderScope(
      child: OrdermanApp(
        branding: BrandingConfig.current,
      ),
    ),
  );
}
