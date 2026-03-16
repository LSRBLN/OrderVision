// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPaymentModelCollection on Isar {
  IsarCollection<PaymentModel> get paymentModels => this.collection();
}

const PaymentModelSchema = CollectionSchema(
  name: r'PaymentModel',
  id: -5459064031591241697,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isCompleted': PropertySchema(
      id: 1,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'method': PropertySchema(
      id: 2,
      name: r'method',
      type: IsarType.string,
      enumMap: _PaymentModelmethodEnumValueMap,
    ),
    r'paidAmount': PropertySchema(
      id: 3,
      name: r'paidAmount',
      type: IsarType.double,
    ),
    r'splitMode': PropertySchema(
      id: 4,
      name: r'splitMode',
      type: IsarType.string,
      enumMap: _PaymentModelsplitModeEnumValueMap,
    ),
    r'tableNumber': PropertySchema(
      id: 5,
      name: r'tableNumber',
      type: IsarType.long,
    ),
    r'totalAmount': PropertySchema(
      id: 6,
      name: r'totalAmount',
      type: IsarType.double,
    )
  },
  estimateSize: _paymentModelEstimateSize,
  serialize: _paymentModelSerialize,
  deserialize: _paymentModelDeserialize,
  deserializeProp: _paymentModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'tableNumber': IndexSchema(
      id: -3323858932237924188,
      name: r'tableNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tableNumber',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'parts': LinkSchema(
      id: -3470505347232661185,
      name: r'parts',
      target: r'PaymentPartModel',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _paymentModelGetId,
  getLinks: _paymentModelGetLinks,
  attach: _paymentModelAttach,
  version: '3.1.0+1',
);

int _paymentModelEstimateSize(
  PaymentModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.method.name.length * 3;
  bytesCount += 3 + object.splitMode.name.length * 3;
  return bytesCount;
}

void _paymentModelSerialize(
  PaymentModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeBool(offsets[1], object.isCompleted);
  writer.writeString(offsets[2], object.method.name);
  writer.writeDouble(offsets[3], object.paidAmount);
  writer.writeString(offsets[4], object.splitMode.name);
  writer.writeLong(offsets[5], object.tableNumber);
  writer.writeDouble(offsets[6], object.totalAmount);
}

PaymentModel _paymentModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PaymentModel();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[1]);
  object.method =
      _PaymentModelmethodValueEnumMap[reader.readStringOrNull(offsets[2])] ??
          StoredPaymentMethod.cash;
  object.paidAmount = reader.readDouble(offsets[3]);
  object.splitMode =
      _PaymentModelsplitModeValueEnumMap[reader.readStringOrNull(offsets[4])] ??
          StoredSplitMode.even;
  object.tableNumber = reader.readLong(offsets[5]);
  object.totalAmount = reader.readDouble(offsets[6]);
  return object;
}

P _paymentModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (_PaymentModelmethodValueEnumMap[
              reader.readStringOrNull(offset)] ??
          StoredPaymentMethod.cash) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (_PaymentModelsplitModeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          StoredSplitMode.even) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PaymentModelmethodEnumValueMap = {
  r'cash': r'cash',
  r'sumup': r'sumup',
  r'nfc': r'nfc',
  r'paypal': r'paypal',
  r'manualCard': r'manualCard',
};
const _PaymentModelmethodValueEnumMap = {
  r'cash': StoredPaymentMethod.cash,
  r'sumup': StoredPaymentMethod.sumup,
  r'nfc': StoredPaymentMethod.nfc,
  r'paypal': StoredPaymentMethod.paypal,
  r'manualCard': StoredPaymentMethod.manualCard,
};
const _PaymentModelsplitModeEnumValueMap = {
  r'even': r'even',
  r'seat': r'seat',
  r'selective': r'selective',
};
const _PaymentModelsplitModeValueEnumMap = {
  r'even': StoredSplitMode.even,
  r'seat': StoredSplitMode.seat,
  r'selective': StoredSplitMode.selective,
};

Id _paymentModelGetId(PaymentModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _paymentModelGetLinks(PaymentModel object) {
  return [object.parts];
}

void _paymentModelAttach(
    IsarCollection<dynamic> col, Id id, PaymentModel object) {
  object.id = id;
  object.parts
      .attach(col, col.isar.collection<PaymentPartModel>(), r'parts', id);
}

extension PaymentModelQueryWhereSort
    on QueryBuilder<PaymentModel, PaymentModel, QWhere> {
  QueryBuilder<PaymentModel, PaymentModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhere> anyTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'tableNumber'),
      );
    });
  }
}

extension PaymentModelQueryWhere
    on QueryBuilder<PaymentModel, PaymentModel, QWhereClause> {
  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause>
      tableNumberEqualTo(int tableNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tableNumber',
        value: [tableNumber],
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause>
      tableNumberNotEqualTo(int tableNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tableNumber',
              lower: [],
              upper: [tableNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tableNumber',
              lower: [tableNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tableNumber',
              lower: [tableNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tableNumber',
              lower: [],
              upper: [tableNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause>
      tableNumberGreaterThan(
    int tableNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tableNumber',
        lower: [tableNumber],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause>
      tableNumberLessThan(
    int tableNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tableNumber',
        lower: [],
        upper: [tableNumber],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterWhereClause>
      tableNumberBetween(
    int lowerTableNumber,
    int upperTableNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tableNumber',
        lower: [lowerTableNumber],
        includeLower: includeLower,
        upper: [upperTableNumber],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PaymentModelQueryFilter
    on QueryBuilder<PaymentModel, PaymentModel, QFilterCondition> {
  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition> methodEqualTo(
    StoredPaymentMethod value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      methodGreaterThan(
    StoredPaymentMethod value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      methodLessThan(
    StoredPaymentMethod value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition> methodBetween(
    StoredPaymentMethod lower,
    StoredPaymentMethod upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'method',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      methodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      methodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      methodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition> methodMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'method',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      methodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'method',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      methodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'method',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      paidAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      paidAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paidAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      paidAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paidAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      paidAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paidAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeEqualTo(
    StoredSplitMode value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'splitMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeGreaterThan(
    StoredSplitMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'splitMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeLessThan(
    StoredSplitMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'splitMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeBetween(
    StoredSplitMode lower,
    StoredSplitMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'splitMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'splitMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'splitMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'splitMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'splitMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'splitMode',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      splitModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'splitMode',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      tableNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tableNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      tableNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tableNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      tableNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tableNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      tableNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tableNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      totalAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      totalAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      totalAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      totalAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PaymentModelQueryObject
    on QueryBuilder<PaymentModel, PaymentModel, QFilterCondition> {}

extension PaymentModelQueryLinks
    on QueryBuilder<PaymentModel, PaymentModel, QFilterCondition> {
  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition> parts(
      FilterQuery<PaymentPartModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'parts');
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      partsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parts', length, true, length, true);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      partsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parts', 0, true, 0, true);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      partsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parts', 0, false, 999999, true);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      partsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parts', 0, true, length, include);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      partsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'parts', length, include, 999999, true);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterFilterCondition>
      partsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'parts', lower, includeLower, upper, includeUpper);
    });
  }
}

extension PaymentModelQuerySortBy
    on QueryBuilder<PaymentModel, PaymentModel, QSortBy> {
  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortByMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'method', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortByMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'method', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy>
      sortByPaidAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortBySplitMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'splitMode', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortBySplitModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'splitMode', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy>
      sortByTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> sortByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy>
      sortByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension PaymentModelQuerySortThenBy
    on QueryBuilder<PaymentModel, PaymentModel, QSortThenBy> {
  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenByMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'method', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenByMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'method', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy>
      thenByPaidAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenBySplitMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'splitMode', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenBySplitModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'splitMode', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy>
      thenByTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.desc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy> thenByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QAfterSortBy>
      thenByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension PaymentModelQueryWhereDistinct
    on QueryBuilder<PaymentModel, PaymentModel, QDistinct> {
  QueryBuilder<PaymentModel, PaymentModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QDistinct> distinctByMethod(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'method', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QDistinct> distinctByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paidAmount');
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QDistinct> distinctBySplitMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'splitMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QDistinct> distinctByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tableNumber');
    });
  }

  QueryBuilder<PaymentModel, PaymentModel, QDistinct> distinctByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAmount');
    });
  }
}

extension PaymentModelQueryProperty
    on QueryBuilder<PaymentModel, PaymentModel, QQueryProperty> {
  QueryBuilder<PaymentModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PaymentModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PaymentModel, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<PaymentModel, StoredPaymentMethod, QQueryOperations>
      methodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'method');
    });
  }

  QueryBuilder<PaymentModel, double, QQueryOperations> paidAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paidAmount');
    });
  }

  QueryBuilder<PaymentModel, StoredSplitMode, QQueryOperations>
      splitModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'splitMode');
    });
  }

  QueryBuilder<PaymentModel, int, QQueryOperations> tableNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tableNumber');
    });
  }

  QueryBuilder<PaymentModel, double, QQueryOperations> totalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAmount');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPaymentPartModelCollection on Isar {
  IsarCollection<PaymentPartModel> get paymentPartModels => this.collection();
}

const PaymentPartModelSchema = CollectionSchema(
  name: r'PaymentPartModel',
  id: -6727435017208782492,
  properties: {
    r'isCompleted': PropertySchema(
      id: 0,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'label': PropertySchema(
      id: 1,
      name: r'label',
      type: IsarType.string,
    ),
    r'totalAmount': PropertySchema(
      id: 2,
      name: r'totalAmount',
      type: IsarType.double,
    )
  },
  estimateSize: _paymentPartModelEstimateSize,
  serialize: _paymentPartModelSerialize,
  deserialize: _paymentPartModelDeserialize,
  deserializeProp: _paymentPartModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _paymentPartModelGetId,
  getLinks: _paymentPartModelGetLinks,
  attach: _paymentPartModelAttach,
  version: '3.1.0+1',
);

int _paymentPartModelEstimateSize(
  PaymentPartModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.label.length * 3;
  return bytesCount;
}

void _paymentPartModelSerialize(
  PaymentPartModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isCompleted);
  writer.writeString(offsets[1], object.label);
  writer.writeDouble(offsets[2], object.totalAmount);
}

PaymentPartModel _paymentPartModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PaymentPartModel();
  object.id = id;
  object.isCompleted = reader.readBool(offsets[0]);
  object.label = reader.readString(offsets[1]);
  object.totalAmount = reader.readDouble(offsets[2]);
  return object;
}

P _paymentPartModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _paymentPartModelGetId(PaymentPartModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _paymentPartModelGetLinks(PaymentPartModel object) {
  return [];
}

void _paymentPartModelAttach(
    IsarCollection<dynamic> col, Id id, PaymentPartModel object) {
  object.id = id;
}

extension PaymentPartModelQueryWhereSort
    on QueryBuilder<PaymentPartModel, PaymentPartModel, QWhere> {
  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PaymentPartModelQueryWhere
    on QueryBuilder<PaymentPartModel, PaymentPartModel, QWhereClause> {
  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PaymentPartModelQueryFilter
    on QueryBuilder<PaymentPartModel, PaymentPartModel, QFilterCondition> {
  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      totalAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      totalAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      totalAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterFilterCondition>
      totalAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PaymentPartModelQueryObject
    on QueryBuilder<PaymentPartModel, PaymentPartModel, QFilterCondition> {}

extension PaymentPartModelQueryLinks
    on QueryBuilder<PaymentPartModel, PaymentPartModel, QFilterCondition> {}

extension PaymentPartModelQuerySortBy
    on QueryBuilder<PaymentPartModel, PaymentPartModel, QSortBy> {
  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy> sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      sortByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      sortByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension PaymentPartModelQuerySortThenBy
    on QueryBuilder<PaymentPartModel, PaymentPartModel, QSortThenBy> {
  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy> thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      thenByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QAfterSortBy>
      thenByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension PaymentPartModelQueryWhereDistinct
    on QueryBuilder<PaymentPartModel, PaymentPartModel, QDistinct> {
  QueryBuilder<PaymentPartModel, PaymentPartModel, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PaymentPartModel, PaymentPartModel, QDistinct>
      distinctByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAmount');
    });
  }
}

extension PaymentPartModelQueryProperty
    on QueryBuilder<PaymentPartModel, PaymentPartModel, QQueryProperty> {
  QueryBuilder<PaymentPartModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PaymentPartModel, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<PaymentPartModel, String, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }

  QueryBuilder<PaymentPartModel, double, QQueryOperations>
      totalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAmount');
    });
  }
}
