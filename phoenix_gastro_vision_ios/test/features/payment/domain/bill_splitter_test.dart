import 'package:flutter_test/flutter_test.dart';
import 'package:orderman_flutter/features/payment/domain/bill_splitter.dart';

void main() {
  group('BillSplitter', () {
    const splitter = BillSplitter();

    test('splitEvenly teilt Betrag rundungssicher auf Gäste auf', () {
      final result = splitter.splitEvenly(total: 10, guests: 3);

      expect(result.parts, hasLength(3));
      expect(result.parts[0].label, 'Gast 1');
      expect(result.parts[0].total, 3.33);
      expect(result.parts[1].total, 3.33);
      expect(result.parts[2].total, 3.34);
    });

    test('splitEvenly gibt leer zurück bei ungültiger Gästezahl', () {
      final result = splitter.splitEvenly(total: 10, guests: 0);

      expect(result.parts, isEmpty);
    });

    test(
        'splitBySeat gruppiert nach Sitzplatz und separiert nicht zugewiesene Items',
        () {
      final result = splitter.splitBySeat(const [
        BillSplitItem(id: 'a', name: 'Cola', total: 3.0, seatNumber: 1),
        BillSplitItem(id: 'b', name: 'Pasta', total: 12.4, seatNumber: 2),
        BillSplitItem(id: 'c', name: 'Wasser', total: 2.5),
      ]);

      expect(result.parts, hasLength(3));
      expect(result.parts[0].label, 'Sitzplatz 1');
      expect(result.parts[0].total, 3.0);
      expect(result.parts[1].label, 'Sitzplatz 2');
      expect(result.parts[1].total, 12.4);
      expect(result.parts[2].label, 'Ohne Sitzplatz');
      expect(result.parts[2].total, 2.5);
    });

    test('splitSelective erstellt Teilrechnung und Rest korrekt', () {
      const items = [
        BillSplitItem(id: 'a', name: 'Cola', total: 3.0),
        BillSplitItem(id: 'b', name: 'Burger', total: 13.9),
        BillSplitItem(id: 'c', name: 'Kaffee', total: 2.8),
      ];

      final result = splitter.splitSelective(
        items: items,
        selectedItemIds: {'a', 'c'},
      );

      expect(result.parts, hasLength(2));
      expect(result.parts[0].label, 'Teilrechnung');
      expect(result.parts[0].items.map((item) => item.id), ['a', 'c']);
      expect(result.parts[0].total, 5.8);
      expect(result.parts[1].label, 'Rest');
      expect(result.parts[1].items.map((item) => item.id), ['b']);
      expect(result.parts[1].total, 13.9);
    });
  });
}
