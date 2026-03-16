# OrderFlutter

Professioneller Orderman-inspirierter POS-Prototyp für Android-Tablets auf
Basis von Flutter, Riverpod und Isar.

## Aktueller Projektstatus

Der Stand ist aktuell ein **stabiler MVP-/Prototyp-Build** mit funktionierenden
Kernbereichen für Gastronomie-POS-Workflows:

- PIN-Login mit Rollen und Tischbereichen
- interaktiver Tischplan mit Statusfarben und Edit Mode
- Bestellaufnahme im Split-Layout für Tablets
- Warenkorb mit Modifiern, Mengensteuerung und Multiplikatoren
- Sitzplatz-Zuordnung pro Bestellposition
- Küchendruck-Basis mit `PrinterService` und Fehler-/Result-Handling
- Payment-/Split-Flow mit:
  - gleichmäßigem Split
  - Split nach Sitzplatz
  - selektivem Split
  - auswählbaren Teilrechnungen
  - Zahlungsarten (Bar, Karte, Gutschein)
  - Zahlungsstatus pro Teilrechnung
  - Summenübersicht für bezahlt/offen

## Technologie-Stack

- **Flutter 3.24+**
- **Riverpod 2.x**
- **Isar 3.x**
- **Material 3**
- vorbereitete Drucker-Basis für spätere ESC/POS-Integration

## Projektstruktur

```text
lib/
├── app.dart
├── main.dart
├── core/
│   ├── constants/
│   ├── database/
│   ├── network/
│   ├── router/
│   └── theme/
└── features/
    ├── auth/
    ├── floor_plan/
    ├── order/
    ├── payment/
    ├── printer/
    └── reports/
```

## Bereits implementierte Features

### 1. Auth

- PIN-Pad Login
- In-Memory User-/Rollenmodell
- Territory-/Tischzuordnung pro Benutzer

### 2. Floor Plan

- Tischübersicht
- Drag & Drop im Edit Mode
- Long-Press-Kontextaktionen
- Navigation vom Tisch direkt in die Bestellung

### 3. Ordering

- Kategorien und Menüitems
- Warenkorb links / Menü rechts
- Modifier-Dialog
- Storno
- Menge +/-
- Multiplikatoren `x2` / `x3`
- Sitzplatz-Auswahl und Sitzplatz-Zuweisung

### 4. Printer

- `PrinterService`-Abstraktion
- `PrintResult` + `PrinterFailure`
- Küchensenden mit UI-Feedback

### 5. Payment

- `BillSplitter` für drei Split-Modi
- PaymentController mit State-Handling
- auswählbare Teilrechnungen
- Zahlungsarten-Auswahl
- Teilrechnungen als bezahlt markieren
- Überblick über offenen und bezahlten Betrag

## Tests

Aktuell vorhandene Tests:

- `test/widget_test.dart`
- `test/features/order/presentation/order_controller_test.dart`
- `test/features/payment/domain/bill_splitter_test.dart`
- `test/features/payment/presentation/payment_controller_test.dart`
- `test/features/payment/presentation/payment_screen_test.dart`

Der Code wird regelmäßig validiert mit:

```bash
flutter analyze
flutter test
```

## Lokales Starten

### Dependencies laden

```bash
flutter pub get
```

### App starten

```bash
flutter run
```

### Tests ausführen

```bash
flutter test
```

## Nächste sinnvolle Schritte

- echte Isar-Persistenz für Orders, Payments und Tische
- echte Druckeranbindung via ESC/POS / Bluetooth
- Payment-Provider / NFC / Terminal-Anbindung
- Rabatt-, Storno- und Buchungslogik weiter ausbauen
- Offline-First Synchronisation vorbereiten

## Hinweis

Dieses Repository ist aktuell **kein fertiges Kassensystem**, sondern ein sehr
weit ausgebauter, testgesicherter Prototyp mit klarer Architektur und bereits
starkem Fokus auf echte POS-Workflows für Tablets.
