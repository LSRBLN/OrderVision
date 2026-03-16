import 'package:flutter/material.dart';

enum WhiteLabelFlavor {
  standard,
  hidden,
}

class BrandingCompanyInfo {
  const BrandingCompanyInfo({
    required this.legalName,
    required this.addressLines,
    required this.phone,
    required this.email,
    required this.website,
    required this.taxId,
  });

  final String legalName;
  final List<String> addressLines;
  final String phone;
  final String email;
  final String website;
  final String taxId;
}

class BrandingTexts {
  const BrandingTexts({
    required this.loginPrompt,
    required this.controlPanelSubtitle,
    required this.statusHeaderLabel,
    required this.splashHeadline,
    required this.splashTagline,
    required this.receiptFooter,
    required this.receiptExchangeRateInfo,
    required this.receiptNoDiscountLabel,
    required this.receiptThanksVisit,
    required this.printerKitchenTitle,
    required this.printerReceiptHeader,
    required this.printerTrainingLabel,
  });

  final String loginPrompt;
  final String controlPanelSubtitle;
  final String statusHeaderLabel;
  final String splashHeadline;
  final String splashTagline;
  final String receiptFooter;
  final String receiptExchangeRateInfo;
  final String receiptNoDiscountLabel;
  final String receiptThanksVisit;
  final String printerKitchenTitle;
  final String printerReceiptHeader;
  final String printerTrainingLabel;
}

class BrandingConfig {
  const BrandingConfig({
    required this.appName,
    required this.shortBrandName,
    required this.fullBrandName,
    required this.logoAssetPng,
    required this.logoAssetJpeg,
    required this.fallbackRestaurantName,
    required this.primaryColor,
    required this.secondaryColor,
    required this.surfaceColor,
    required this.surfaceHighColor,
    required this.successColor,
    required this.warningColor,
    required this.dangerColor,
    required this.company,
    required this.texts,
  });

  static const String _modeKey = 'WHITE_LABEL_MODE';
  static const String _flavorKey = 'WHITE_LABEL_FLAVOR';
  static const bool isWhiteLabelMode =
      bool.fromEnvironment(_modeKey, defaultValue: false);
  static const String configuredFlavor =
      String.fromEnvironment(_flavorKey, defaultValue: 'standard');

  static BrandingConfig current = _standard;
  static WhiteLabelFlavor activeFlavor = WhiteLabelFlavor.standard;

  final String appName;
  final String shortBrandName;
  final String fullBrandName;
  final String logoAssetPng;
  final String logoAssetJpeg;
  final String fallbackRestaurantName;
  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;
  final Color surfaceHighColor;
  final Color successColor;
  final Color warningColor;
  final Color dangerColor;
  final BrandingCompanyInfo company;
  final BrandingTexts texts;

  static void bootstrap() {
    activeFlavor = _resolveFlavor();
    current = switch (activeFlavor) {
      WhiteLabelFlavor.hidden => _hiddenWhiteLabel,
      WhiteLabelFlavor.standard => _standard,
    };
  }

  static WhiteLabelFlavor _resolveFlavor() {
    if (!isWhiteLabelMode) {
      return WhiteLabelFlavor.standard;
    }

    return switch (configuredFlavor.toLowerCase()) {
      'hidden' => WhiteLabelFlavor.hidden,
      _ => WhiteLabelFlavor.hidden,
    };
  }

  static const BrandingConfig _standard = BrandingConfig(
    appName: 'Phoenix Gastro Vision',
    shortBrandName: 'Phoenix',
    fullBrandName: 'Phoenix Gastro Vision',
    logoAssetPng: 'assets/images/gastrovision.png',
    logoAssetJpeg: 'assets/images/gastrovision.jpeg',
    fallbackRestaurantName: 'Phoenix Gastro Vision',
    primaryColor: Color(0xFFD4AF37),
    secondaryColor: Color(0xFFB9770E),
    surfaceColor: Color(0xFF11131A),
    surfaceHighColor: Color(0xFF252B36),
    successColor: Color(0xFF4CAF50),
    warningColor: Color(0xFFFFB300),
    dangerColor: Color(0xFFE57373),
    company: BrandingCompanyInfo(
      legalName: 'Phoenix Gastro Vision GmbH',
      addressLines: <String>[
        'Hospitality Campus 7',
        '50667 Cologne',
        'Germany',
      ],
      phone: '+49 221 555 0190',
      email: 'support@phoenix-gastro-vision.local',
      website: 'phoenix-gastro-vision.local',
      taxId: 'DE-PGV-2026',
    ),
    texts: BrandingTexts(
      loginPrompt: 'Bitte 4-stelligen PIN eingeben',
      controlPanelSubtitle: 'Tablet-first operations',
      statusHeaderLabel: 'Phoenix Operations',
      splashHeadline: 'Phoenix Gastro Vision',
      splashTagline: 'Tablet POS for fast table service',
      receiptFooter: 'Vielen Dank für Ihren Besuch im Phoenix Gastro Vision.',
      receiptExchangeRateInfo: 'Basiswährung EUR',
      receiptNoDiscountLabel: 'Keine globalen Rabatte',
      receiptThanksVisit: 'Danke für Ihren Besuch!',
      printerKitchenTitle: 'KÜCHENBON',
      printerReceiptHeader: 'Phoenix Gastro Vision',
      printerTrainingLabel: 'TRAINING MODE',
    ),
  );

  static const BrandingConfig _hiddenWhiteLabel = BrandingConfig(
    appName: 'Service OS',
    shortBrandName: 'Service OS',
    fullBrandName: 'Service OS Hospitality Suite',
    logoAssetPng: 'assets/images/gastrovision.png',
    logoAssetJpeg: 'assets/images/gastrovision.jpeg',
    fallbackRestaurantName: 'Service OS Venue',
    primaryColor: Color(0xFF5BC0EB),
    secondaryColor: Color(0xFF2563EB),
    surfaceColor: Color(0xFF0F172A),
    surfaceHighColor: Color(0xFF1E293B),
    successColor: Color(0xFF22C55E),
    warningColor: Color(0xFFF59E0B),
    dangerColor: Color(0xFFEF4444),
    company: BrandingCompanyInfo(
      legalName: 'Service OS Hospitality Systems GmbH',
      addressLines: <String>[
        'Dockside Plaza 12',
        '20457 Hamburg',
        'Germany',
      ],
      phone: '+49 40 987 600 11',
      email: 'ops@service-os.local',
      website: 'service-os.local',
      taxId: 'DE-SOS-2026',
    ),
    texts: BrandingTexts(
      loginPrompt: 'Please enter your 4-digit staff PIN',
      controlPanelSubtitle: 'White-label service console',
      statusHeaderLabel: 'Service Operations',
      splashHeadline: 'Service OS',
      splashTagline: 'Operational tablet suite for hospitality teams',
      receiptFooter: 'Thank you for choosing Service OS Hospitality Suite.',
      receiptExchangeRateInfo: 'Base currency EUR',
      receiptNoDiscountLabel: 'No global discounts applied',
      receiptThanksVisit: 'Thank you for your visit!',
      printerKitchenTitle: 'KITCHEN TICKET',
      printerReceiptHeader: 'Service OS Hospitality Suite',
      printerTrainingLabel: 'TRAINING MODE',
    ),
  );
}
