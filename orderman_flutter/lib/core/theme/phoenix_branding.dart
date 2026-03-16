import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';

class PhoenixBranding {
  const PhoenixBranding._();

  static const Color gold = Color(0xFFD4AF37);
  static const Color ember = Color(0xFFB9770E);
  static const Color night = Color(0xFF11131A);
  static const Color surface = Color(0xFF1A1F29);
  static const Color surfaceHigh = Color(0xFF252B36);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB300);
  static const Color danger = Color(0xFFE57373);

  static ThemeData buildTheme({
    required BrandingConfig branding,
    ColorScheme? dynamicLight,
    ColorScheme? dynamicDark,
    Brightness platformBrightness = Brightness.dark,
  }) {
    final fallbackScheme = ColorScheme.fromSeed(
      seedColor: branding.resolvedPrimaryColor,
      primary: branding.resolvedPrimaryColor,
      secondary: branding.resolvedSecondaryColor,
      brightness: Brightness.dark,
      surface: branding.highContrast ? Colors.black : surface,
      error: danger,
    );

    final dynamicScheme =
        platformBrightness == Brightness.dark ? dynamicDark : dynamicLight;

    final colorScheme = (dynamicScheme ?? fallbackScheme).copyWith(
      brightness: Brightness.dark,
      primary: branding.resolvedPrimaryColor,
      secondary: branding.resolvedSecondaryColor,
      surface: branding.highContrast ? Colors.black : surface,
      error: danger,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
    );

    final effectiveScaffold = branding.highContrast ? Colors.black : night;
    final effectiveSurface =
        branding.highContrast ? const Color(0xFF050505) : surface;
    final effectiveSurfaceHigh =
        branding.highContrast ? const Color(0xFF101010) : surfaceHigh;
    final divider = branding.highContrast ? Colors.white38 : Colors.white12;

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: effectiveScaffold,
      cardColor: effectiveSurface,
      dividerColor: divider,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.comfortable,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: effectiveScaffold,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: effectiveSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: divider),
        ),
        margin: const EdgeInsets.all(12),
      ),
      chipTheme: base.chipTheme.copyWith(
        side: BorderSide(color: divider),
        selectedColor: branding.resolvedPrimaryColor.withValues(alpha: 0.22),
        checkmarkColor: branding.resolvedPrimaryColor,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(72, 72),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          backgroundColor: branding.resolvedPrimaryColor,
          foregroundColor: Colors.black,
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
          minimumSize: const Size(72, 72),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          foregroundColor: Colors.white,
          side: BorderSide(color: divider),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(72, 72),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(72, 72),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: effectiveSurfaceHigh,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        hintStyle: const TextStyle(fontSize: 18),
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: branding.resolvedPrimaryColor,
            width: 2,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: effectiveScaffold,
        minWidth: 88,
        minExtendedWidth: 220,
        selectedIconTheme:
            IconThemeData(color: branding.resolvedPrimaryColor, size: 28),
        unselectedIconTheme:
            const IconThemeData(color: Colors.white70, size: 26),
        selectedLabelTextStyle: TextStyle(
          color: branding.resolvedPrimaryColor,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        unselectedLabelTextStyle:
            const TextStyle(color: Colors.white70, fontSize: 18),
      ),
      listTileTheme: const ListTileThemeData(
        minTileHeight: 72,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        iconColor: Colors.white,
        textColor: Colors.white,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(72, 72),
          padding: const EdgeInsets.all(16),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: branding.resolvedPrimaryColor,
        foregroundColor: Colors.black,
        extendedTextStyle:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      textTheme: base.textTheme.copyWith(
        headlineMedium: const TextStyle(
          fontSize: 32,
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
        titleSmall: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        bodyLarge: const TextStyle(fontSize: 18, height: 1.4),
        bodyMedium: const TextStyle(fontSize: 18, height: 1.4),
        bodySmall: const TextStyle(fontSize: 16, height: 1.35),
        labelLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        labelMedium: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: effectiveSurfaceHigh,
        contentTextStyle: const TextStyle(fontSize: 18, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: effectiveSurface,
        modalBackgroundColor: effectiveSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
    );
  }
}
