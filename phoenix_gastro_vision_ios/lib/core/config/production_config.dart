class ProductionConfig {
  const ProductionConfig._();

  static const bool trainingModeDefault = false;
  static const String buildFlavor = String.fromEnvironment(
    'BUILD_FLAVOR',
    defaultValue: 'production',
  );
  static const bool releaseModeEnabled = bool.fromEnvironment(
    'RELEASE_MODE_ENABLED',
    defaultValue: true,
  );

  static const String sumUpAffiliateKey = String.fromEnvironment(
    'SUMUP_AFFILIATE_KEY',
    defaultValue: '',
  );

  static const String paypalClientId = String.fromEnvironment(
    'PAYPAL_CLIENT_ID',
    defaultValue: '',
  );

  static const String paypalSecret = String.fromEnvironment(
    'PAYPAL_SECRET',
    defaultValue: '',
  );

  static const bool paypalSandbox = bool.fromEnvironment(
    'PAYPAL_SANDBOX',
    defaultValue: true,
  );

  static const String fiskaltrustBaseUrl = String.fromEnvironment(
    'FISKALTRUST_BASE_URL',
    defaultValue: '',
  );

  static const String fiskaltrustApiKey = String.fromEnvironment(
    'FISKALTRUST_API_KEY',
    defaultValue: '',
  );

  static const String fiskaltrustCashboxId = String.fromEnvironment(
    'FISKALTRUST_CASHBOX_ID',
    defaultValue: '',
  );

  static bool get hasSumUpConfig => sumUpAffiliateKey.isNotEmpty;
  static bool get hasPaypalConfig =>
      paypalClientId.isNotEmpty && paypalSecret.isNotEmpty;
  static bool get hasFiskaltrustConfig =>
      fiskaltrustBaseUrl.isNotEmpty &&
      fiskaltrustApiKey.isNotEmpty &&
      fiskaltrustCashboxId.isNotEmpty;

  static bool get isProductionMode =>
      releaseModeEnabled && !trainingModeDefault && buildFlavor == 'production';
}
