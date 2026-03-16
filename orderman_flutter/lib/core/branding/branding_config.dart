import 'package:flutter/material.dart';

class BrandingConfig {
  const BrandingConfig({
    required this.appName,
    required this.fallbackRestaurantName,
    required this.logoAssetJpeg,
    required this.logoAssetPng,
    required this.primaryColor,
    required this.secondaryColor,
    required this.highContrast,
    required this.whiteLabelMode,
  });

  static const String _defaultAppName = 'Phoenix Gastro Vision';
  static const String _defaultRestaurantName = 'Phoenix Gastro Vision';
  static const String _defaultLogoAssetJpeg = 'assets/images/gastrovision.jpeg';
  static const String _defaultLogoAssetPng = 'assets/images/gastrovision.png';
  static const Color _defaultPrimaryColor = Color(0xFFD4AF37);
  static const Color _defaultSecondaryColor = Color(0xFFB9770E);

  static const String _appNameDefine = String.fromEnvironment(
    'WHITE_LABEL_APP_NAME',
    defaultValue: _defaultAppName,
  );
  static const String _restaurantNameDefine = String.fromEnvironment(
    'WHITE_LABEL_RESTAURANT_NAME',
    defaultValue: _defaultRestaurantName,
  );
  static const String _logoJpegDefine = String.fromEnvironment(
    'WHITE_LABEL_LOGO_JPEG',
    defaultValue: _defaultLogoAssetJpeg,
  );
  static const String _logoPngDefine = String.fromEnvironment(
    'WHITE_LABEL_LOGO_PNG',
    defaultValue: _defaultLogoAssetPng,
  );
  static const String _primaryColorDefine = String.fromEnvironment(
    'WHITE_LABEL_PRIMARY_COLOR',
    defaultValue: '#D4AF37',
  );
  static const String _secondaryColorDefine = String.fromEnvironment(
    'WHITE_LABEL_SECONDARY_COLOR',
    defaultValue: '#B9770E',
  );
  static const bool _highContrastDefine = bool.fromEnvironment(
    'WHITE_LABEL_HIGH_CONTRAST',
    defaultValue: false,
  );
  static const bool _whiteLabelModeDefine = bool.fromEnvironment(
    'WHITE_LABEL_MODE',
    defaultValue: false,
  );

  final String appName;
  final String fallbackRestaurantName;
  final String logoAssetJpeg;
  final String logoAssetPng;
  final Color primaryColor;
  final Color secondaryColor;
  final bool highContrast;
  final bool whiteLabelMode;

  static const BrandingConfig current = BrandingConfig(
    appName: _appNameDefine,
    fallbackRestaurantName: _restaurantNameDefine,
    logoAssetJpeg: _logoJpegDefine,
    logoAssetPng: _logoPngDefine,
    primaryColor: _defaultPrimaryColor,
    secondaryColor: _defaultSecondaryColor,
    highContrast: _highContrastDefine,
    whiteLabelMode: _whiteLabelModeDefine,
  );

  Color get resolvedPrimaryColor => _parseHexColor(
        _primaryColorDefine,
        fallback: _defaultPrimaryColor,
      );

  Color get resolvedSecondaryColor => _parseHexColor(
        _secondaryColorDefine,
        fallback: _defaultSecondaryColor,
      );

  static Color _parseHexColor(String rawHex, {required Color fallback}) {
    final sanitized = rawHex.trim().replaceAll('#', '');
    if (sanitized.length != 6 && sanitized.length != 8) {
      return fallback;
    }

    final normalized = sanitized.length == 6 ? 'FF$sanitized' : sanitized;
    final value = int.tryParse(normalized, radix: 16);
    if (value == null) {
      return fallback;
    }

    return Color(value);
  }
}
