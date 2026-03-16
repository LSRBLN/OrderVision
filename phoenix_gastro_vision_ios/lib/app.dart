import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:go_router/go_router.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/core/demo/demo_mode.dart';
import 'package:orderman_flutter/core/theme/phoenix_branding.dart';
import 'package:orderman_flutter/features/auth/domain/user_model.dart';
import 'package:orderman_flutter/features/auth/presentation/auth_providers.dart';
import 'package:orderman_flutter/features/auth/presentation/auth_screen.dart';
import 'package:orderman_flutter/features/control_panel/presentation/control_panel_screen.dart';
import 'package:orderman_flutter/features/floor_plan/presentation/floor_plan_screen.dart';
import 'package:orderman_flutter/features/menu/presentation/menu_admin_screen.dart';
import 'package:orderman_flutter/features/printer/presentation/printer_settings_screen.dart';

class OrdermanApp extends ConsumerWidget {
  const OrdermanApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final currentUser = authState.currentUser;
    final highContrast = WidgetsBinding
        .instance.platformDispatcher.accessibilityFeatures.highContrast;
    final platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final overlayStyle = platformBrightness == Brightness.dark
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
          )
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
          );

    SystemChrome.setSystemUIOverlayStyle(overlayStyle);

    final router = GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        final isAuthenticated = currentUser != null;
        final isLoginRoute = state.matchedLocation == '/login';
        final requiresAdmin = state.matchedLocation == '/printer-settings' ||
            state.matchedLocation == '/users' ||
            state.matchedLocation == '/system-settings';

        if (!isAuthenticated && !isLoginRoute) {
          return '/login';
        }
        if (isAuthenticated && isLoginRoute) {
          return '/control';
        }
        if (requiresAdmin && currentUser?.isAdmin != true) {
          return '/control';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/control',
          builder: (context, state) => _requireUser(
              currentUser, (user) => ControlPanelScreen(user: user)),
        ),
        GoRoute(
          path: '/floor-plan',
          builder: (context, state) => _requireUser(
            currentUser,
            (user) => FloorPlanScreen(
              user: user,
              onLogout: () {
                ref.read(authControllerProvider.notifier).logout();
                context.go('/login');
              },
            ),
          ),
        ),
        GoRoute(
          path: '/printer-settings',
          builder: (context, state) =>
              _requireUser(currentUser, (_) => const PrinterSettingsScreen()),
        ),
        GoRoute(
          path: '/menu-management',
          builder: (context, state) => _requireUser(
            currentUser,
            (_) => const MenuAdminScreen(),
          ),
        ),
        GoRoute(
          path: '/reports',
          builder: (context, state) => _buildPlaceholder('Reports',
              'Zahlungsübersicht und Reports werden hier gebündelt.'),
        ),
        GoRoute(
          path: '/users',
          builder: (context, state) => _buildPlaceholder(
              'Benutzerverwaltung', 'Benutzer- und Rollenverwaltung folgt.'),
        ),
        GoRoute(
          path: '/system-settings',
          builder: (context, state) => _buildPlaceholder(
            'System-Settings',
            'Training-Modus, Backup und Systemsteuerung folgen.',
          ),
        ),
      ],
    );

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp.router(
          title: PhoenixBranding.appName,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          themeMode: ThemeMode.system,
          builder: (context, child) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: overlayStyle,
              child: Stack(
                children: <Widget>[
                  child ?? const SizedBox.shrink(),
                  const DemoBanner(),
                ],
              ),
            );
          },
          themeAnimationDuration: const Duration(milliseconds: 180),
          theme: PhoenixBranding.buildTheme(
            dynamicLightColorScheme: lightDynamic,
            dynamicDarkColorScheme: darkDynamic,
            brightness: Brightness.light,
            highContrast: highContrast,
          ),
          darkTheme: PhoenixBranding.buildTheme(
            dynamicLightColorScheme: lightDynamic,
            dynamicDarkColorScheme: darkDynamic,
            brightness: Brightness.dark,
            highContrast:
                highContrast || platformBrightness == Brightness.light,
          ),
        );
      },
    );
  }

  Widget _requireUser(
    UserModel? user,
    Widget Function(UserModel user) builder,
  ) {
    if (user == null) {
      return const AuthScreen();
    }
    return builder(user);
  }

  Widget _buildPlaceholder(String title, String message) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${BrandingConfig.current.shortBrandName} • $title'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(
                    BrandingConfig.current.texts.splashTagline,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(message, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
