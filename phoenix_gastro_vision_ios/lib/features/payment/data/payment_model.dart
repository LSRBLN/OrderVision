import 'package:isar/isar.dart';

part 'payment_model.g.dart';

@Collection()
class PaymentModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int tableNumber;

  late DateTime createdAt;

  @Enumerated(EnumType.name)
  late StoredPaymentMethod method;

  @Enumerated(EnumType.name)
  late StoredSplitMode splitMode;

  double totalAmount = 0;
  double paidAmount = 0;
  bool isCompleted = false;

  final parts = IsarLinks<PaymentPartModel>();
}

@Collection()
class PaymentPartModel {
  Id id = Isar.autoIncrement;

  late String label;
  double totalAmount = 0;
  bool isCompleted = false;
}

enum StoredPaymentMethod {
  cash,
  sumup,
  nfc,
  paypal,
  manualCard,
}

enum StoredSplitMode {
  even,
  seat,
  selective,
}
