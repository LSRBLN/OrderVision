import 'package:flutter/material.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';

class PhoenixBranding {
  const PhoenixBranding._();

  static const Color phoenixGoldSeed = Color(0xFFD4A017);

  static String get appName => BrandingConfig.current.appName;
  static String get shortBrandName => BrandingConfig.current.shortBrandName;
  static String get fullBrandName => BrandingConfig.current.fullBrandName;
  static String get logoAssetJpeg => BrandingConfig.current.logoAssetJpeg;
  static String get logoAssetPng => BrandingConfig.current.logoAssetPng;
  static String get fallbackRestaurantName =>
      BrandingConfig.current.fallbackRestaurantName;

  static Color get gold => BrandingConfig.current.primaryColor;
  static Color get ember => BrandingConfig.current.secondaryColor;
  static Color get night => BrandingConfig.current.surfaceColor;
  static Color get surface => BrandingConfig.current.surfaceColor;
  static Color get surfaceHigh => BrandingConfig.current.surfaceHighColor;
  static Color get success => BrandingConfig.current.successColor;
  static Color get warning => BrandingConfig.current.warningColor;
  static Color get danger => BrandingConfig.current.dangerColor;
  static const double minTouchTarget = 72;

  static ThemeData buildTheme({
    ColorScheme? dynamicLightColorScheme,
    ColorScheme? dynamicDarkColorScheme,
    bool highContrast = false,
    Brightness brightness = Brightness.dark,
  }) {
    final seedScheme = ColorScheme.fromSeed(
      seedColor: phoenixGoldSeed,
      brightness: brightness,
    );

    final fallbackSeedScheme = seedScheme.copyWith(
      primary: gold,
      secondary: ember,
      tertiary: warning,
      error: danger,
    );

    final dynamicScheme = brightness == Brightness.dark
        ? (dynamicDarkColorScheme ?? fallbackSeedScheme)
        : (dynamicLightColorScheme ?? fallbackSeedScheme);

    final sourceScheme = dynamicScheme.copyWith(
      primary: _blend(dynamicScheme.primary, gold, 0.72),
      primaryContainer: _blend(
        dynamicScheme.primaryContainer,
        seedScheme.primaryContainer,
        0.58,
      ),
      secondary: _blend(dynamicScheme.secondary, ember, 0.42),
      secondaryContainer: _blend(
        dynamicScheme.secondaryContainer,
        seedScheme.secondaryContainer,
        0.40,
      ),
      tertiary: _blend(dynamicScheme.tertiary, warning, 0.35),
      surfaceTint: gold,
    );

    final colorScheme = _buildAdaptiveColorScheme(
      sourceScheme: sourceScheme,
      brightness: brightness,
      highContrast: highContrast,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      cardColor: colorScheme.surfaceContainerLow,
      dividerColor: colorScheme.outlineVariant,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      canvasColor: colorScheme.surface,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 24,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        side: BorderSide(color: colorScheme.outlineVariant),
        selectedColor: colorScheme.primaryContainer,
        checkmarkColor: colorScheme.primary,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(minTouchTarget, minTouchTarget),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          foregroundColor: colorScheme.primary,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(minTouchTarget, minTouchTarget),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(minTouchTarget, minTouchTarget),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(color: colorScheme.outline),
          textStyle: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(minTouchTarget, minTouchTarget),
          padding: const EdgeInsets.all(20),
          foregroundColor: colorScheme.onSurface,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.surfaceContainerHighest,
        contentTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surface,
        selectedIconTheme: IconThemeData(color: colorScheme.primary),
        selectedLabelTextStyle: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 18,
        ),
      ),
      textTheme: base.textTheme.copyWith(
        displaySmall: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
        ),
        headlineSmall: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        titleLarge: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: const TextStyle(
          fontSize: 18,
          height: 1.45,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: const TextStyle(
          fontSize: 18,
          height: 1.4,
        ),
        bodySmall: const TextStyle(
          fontSize: 16,
          height: 1.35,
        ),
        labelLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      listTileTheme: const ListTileThemeData(
        minVerticalPadding: 14,
        minTileHeight: minTouchTarget,
        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      ),
    );
  }

  static ColorScheme _buildAdaptiveColorScheme({
    required ColorScheme sourceScheme,
    required Brightness brightness,
    required bool highContrast,
  }) {
    final sunlightMode = highContrast && brightness == Brightness.light;
    final baseSurface = switch ((brightness, sunlightMode)) {
      (Brightness.dark, _) => night,
      (_, true) => const Color(0xFFFFFBF2),
      _ => Colors.white,
    };
    final baseSurfaceHigh = switch ((brightness, sunlightMode)) {
      (Brightness.dark, _) => surfaceHigh,
      (_, true) => const Color(0xFFFFF2C2),
      _ => const Color(0xFFF5EFD8),
    };

    final tunedPrimary = highContrast
        ? (brightness == Brightness.dark
            ? const Color(0xFFFFD95A)
            : const Color(0xFF7A4A00))
        : sourceScheme.primary;
    final tunedOnPrimary = highContrast && brightness == Brightness.light
        ? Colors.white
        : (brightness == Brightness.dark ? Colors.black : Colors.white);

    return sourceScheme.copyWith(
      primary: tunedPrimary,
      secondary: highContrast ? ember : sourceScheme.secondary,
      tertiary: warning,
      error: danger,
      surface: baseSurface,
      onSurface:
          sunlightMode ? const Color(0xFF111111) : sourceScheme.onSurface,
      onSurfaceVariant: sunlightMode
          ? const Color(0xFF2F2A1F)
          : sourceScheme.onSurfaceVariant,
      surfaceContainerLow: baseSurfaceHigh,
      surfaceContainerHighest: highContrast
          ? baseSurfaceHigh.withValues(alpha: 0.96)
          : baseSurfaceHigh,
      outline: highContrast
          ? tunedPrimary.withValues(alpha: 0.9)
          : sourceScheme.outline,
      outlineVariant: highContrast
          ? tunedPrimary.withValues(alpha: 0.48)
          : sourceScheme.outlineVariant,
      onPrimary: tunedOnPrimary,
      onSecondary: tunedOnPrimary,
    );
  }

  static Color _blend(Color base, Color overlay, double overlayOpacity) {
    return Color.alphaBlend(overlay.withValues(alpha: overlayOpacity), base);
  }
}
