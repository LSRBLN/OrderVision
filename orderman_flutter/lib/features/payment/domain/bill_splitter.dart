class BillSplitItem {
  const BillSplitItem({
    required this.id,
    required this.name,
    required this.total,
    this.seatNumber,
  });

  final String id;
  final String name;
  final double total;
  final int? seatNumber;
}

class BillSplitPart {
  const BillSplitPart({
    required this.label,
    required this.items,
    required this.total,
  });

  final String label;
  final List<BillSplitItem> items;
  final double total;
}

class BillSplitResult {
  const BillSplitResult({
    required this.parts,
  });

  final List<BillSplitPart> parts;
}

class BillSplitter {
  const BillSplitter();

  BillSplitResult splitEvenly({
    required double total,
    required int guests,
  }) {
    if (guests <= 0) {
      return const BillSplitResult(parts: []);
    }

    final share = _round2(total / guests);
    final parts = <BillSplitPart>[];
    double assigned = 0;

    for (var i = 1; i <= guests; i++) {
      final isLast = i == guests;
      final value = isLast ? _round2(total - assigned) : share;
      assigned = _round2(assigned + value);
      parts.add(
        BillSplitPart(
          label: 'Gast $i',
          items: const [],
          total: value,
        ),
      );
    }

    return BillSplitResult(parts: parts);
  }

  BillSplitResult splitBySeat(List<BillSplitItem> items) {
    final grouped = <int, List<BillSplitItem>>{};
    final unassigned = <BillSplitItem>[];

    for (final item in items) {
      final seat = item.seatNumber;
      if (seat == null || seat <= 0) {
        unassigned.add(item);
        continue;
      }
      grouped.putIfAbsent(seat, () => <BillSplitItem>[]).add(item);
    }

    final seats = grouped.keys.toList()..sort();
    final parts = <BillSplitPart>[
      for (final seat in seats)
        BillSplitPart(
          label: 'Sitzplatz $seat',
          items: grouped[seat]!,
          total:
              _round2(grouped[seat]!.fold(0, (sum, item) => sum + item.total)),
        ),
      if (unassigned.isNotEmpty)
        BillSplitPart(
          label: 'Ohne Sitzplatz',
          items: unassigned,
          total: _round2(unassigned.fold(0, (sum, item) => sum + item.total)),
        ),
    ];

    return BillSplitResult(parts: parts);
  }

  BillSplitResult splitSelective({
    required List<BillSplitItem> items,
    required Set<String> selectedItemIds,
  }) {
    final selected = <BillSplitItem>[];
    final remaining = <BillSplitItem>[];

    for (final item in items) {
      if (selectedItemIds.contains(item.id)) {
        selected.add(item);
      } else {
        remaining.add(item);
      }
    }

    return BillSplitResult(
      parts: [
        BillSplitPart(
          label: 'Teilrechnung',
          items: selected,
          total: _round2(selected.fold(0, (sum, item) => sum + item.total)),
        ),
        BillSplitPart(
          label: 'Rest',
          items: remaining,
          total: _round2(remaining.fold(0, (sum, item) => sum + item.total)),
        ),
      ],
    );
  }

  double _round2(double value) => (value * 100).roundToDouble() / 100;
}
