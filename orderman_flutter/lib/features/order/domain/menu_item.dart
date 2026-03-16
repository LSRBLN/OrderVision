class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.sortOrder = 0,
    this.happyHourPrice,
    this.premiumPrice,
    this.allergens = const <String>[],
    this.discountEligible = true,
    this.isActive = true,
    this.autoDiscountThreshold = 0,
    this.autoDiscountPercent = 0,
    this.priceLevels = const <String, double>{},
  });

  final String id;
  final String name;
  final double price;
  final String category;
  final int sortOrder;
  final double? happyHourPrice;
  final double? premiumPrice;
  final List<String> allergens;
  final bool discountEligible;
  final bool isActive;
  final int autoDiscountThreshold;
  final double autoDiscountPercent;
  final Map<String, double> priceLevels;

  MenuItem copyWith({
    String? id,
    String? name,
    double? price,
    String? category,
    int? sortOrder,
    double? happyHourPrice,
    double? premiumPrice,
    List<String>? allergens,
    bool? discountEligible,
    bool? isActive,
    int? autoDiscountThreshold,
    double? autoDiscountPercent,
    Map<String, double>? priceLevels,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      sortOrder: sortOrder ?? this.sortOrder,
      happyHourPrice: happyHourPrice ?? this.happyHourPrice,
      premiumPrice: premiumPrice ?? this.premiumPrice,
      allergens: allergens ?? this.allergens,
      discountEligible: discountEligible ?? this.discountEligible,
      isActive: isActive ?? this.isActive,
      autoDiscountThreshold:
          autoDiscountThreshold ?? this.autoDiscountThreshold,
      autoDiscountPercent: autoDiscountPercent ?? this.autoDiscountPercent,
      priceLevels: priceLevels ?? this.priceLevels,
    );
  }

  double priceForLevel(String level) {
    return priceLevels[level] ?? price;
  }
}
