// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOrderItemModelCollection on Isar {
  IsarCollection<OrderItemModel> get orderItemModels => this.collection();
}

const OrderItemModelSchema = CollectionSchema(
  name: r'OrderItemModel',
  id: 3320497907544385651,
  properties: {
    r'autoDiscountPercent': PropertySchema(
      id: 0,
      name: r'autoDiscountPercent',
      type: IsarType.double,
    ),
    r'isPrinted': PropertySchema(
      id: 1,
      name: r'isPrinted',
      type: IsarType.bool,
    ),
    r'isVoided': PropertySchema(
      id: 2,
      name: r'isVoided',
      type: IsarType.bool,
    ),
    r'manualDiscountPercent': PropertySchema(
      id: 3,
      name: r'manualDiscountPercent',
      type: IsarType.double,
    ),
    r'menuItemId': PropertySchema(
      id: 4,
      name: r'menuItemId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'note': PropertySchema(
      id: 6,
      name: r'note',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 7,
      name: r'price',
      type: IsarType.double,
    ),
    r'quantity': PropertySchema(
      id: 8,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'seatNumber': PropertySchema(
      id: 9,
      name: r'seatNumber',
      type: IsarType.long,
    ),
    r'voidNote': PropertySchema(
      id: 10,
      name: r'voidNote',
      type: IsarType.string,
    ),
    r'voidReason': PropertySchema(
      id: 11,
      name: r'voidReason',
      type: IsarType.string,
    )
  },
  estimateSize: _orderItemModelEstimateSize,
  serialize: _orderItemModelSerialize,
  deserialize: _orderItemModelDeserialize,
  deserializeProp: _orderItemModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _orderItemModelGetId,
  getLinks: _orderItemModelGetLinks,
  attach: _orderItemModelAttach,
  version: '3.1.0+1',
);

int _orderItemModelEstimateSize(
  OrderItemModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.menuItemId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.voidNote;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.voidReason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _orderItemModelSerialize(
  OrderItemModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.autoDiscountPercent);
  writer.writeBool(offsets[1], object.isPrinted);
  writer.writeBool(offsets[2], object.isVoided);
  writer.writeDouble(offsets[3], object.manualDiscountPercent);
  writer.writeString(offsets[4], object.menuItemId);
  writer.writeString(offsets[5], object.name);
  writer.writeString(offsets[6], object.note);
  writer.writeDouble(offsets[7], object.price);
  writer.writeLong(offsets[8], object.quantity);
  writer.writeLong(offsets[9], object.seatNumber);
  writer.writeString(offsets[10], object.voidNote);
  writer.writeString(offsets[11], object.voidReason);
}

OrderItemModel _orderItemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OrderItemModel();
  object.autoDiscountPercent = reader.readDouble(offsets[0]);
  object.id = id;
  object.isPrinted = reader.readBool(offsets[1]);
  object.isVoided = reader.readBool(offsets[2]);
  object.manualDiscountPercent = reader.readDouble(offsets[3]);
  object.menuItemId = reader.readString(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.note = reader.readStringOrNull(offsets[6]);
  object.price = reader.readDouble(offsets[7]);
  object.quantity = reader.readLong(offsets[8]);
  object.seatNumber = reader.readLongOrNull(offsets[9]);
  object.voidNote = reader.readStringOrNull(offsets[10]);
  object.voidReason = reader.readStringOrNull(offsets[11]);
  return object;
}

P _orderItemModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _orderItemModelGetId(OrderItemModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _orderItemModelGetLinks(OrderItemModel object) {
  return [];
}

void _orderItemModelAttach(
    IsarCollection<dynamic> col, Id id, OrderItemModel object) {
  object.id = id;
}

extension OrderItemModelQueryWhereSort
    on QueryBuilder<OrderItemModel, OrderItemModel, QWhere> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OrderItemModelQueryWhere
    on QueryBuilder<OrderItemModel, OrderItemModel, QWhereClause> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idBetween(
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

extension OrderItemModelQueryFilter
    on QueryBuilder<OrderItemModel, OrderItemModel, QFilterCondition> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      autoDiscountPercentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoDiscountPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      autoDiscountPercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'autoDiscountPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      autoDiscountPercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'autoDiscountPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      autoDiscountPercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'autoDiscountPercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      isPrintedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPrinted',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      isVoidedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVoided',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      manualDiscountPercentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manualDiscountPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      manualDiscountPercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'manualDiscountPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      manualDiscountPercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'manualDiscountPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      manualDiscountPercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'manualDiscountPercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'menuItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'menuItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'menuItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'menuItemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'menuItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'menuItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'menuItemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'menuItemId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'menuItemId',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      menuItemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'menuItemId',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      seatNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'seatNumber',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      seatNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'seatNumber',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      seatNumberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seatNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      seatNumberGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seatNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      seatNumberLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seatNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      seatNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seatNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'voidNote',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'voidNote',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voidNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voidNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voidNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voidNote',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'voidNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'voidNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'voidNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'voidNote',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voidNote',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidNoteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'voidNote',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'voidReason',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'voidReason',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voidReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voidReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voidReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voidReason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'voidReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'voidReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'voidReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'voidReason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voidReason',
        value: '',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      voidReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'voidReason',
        value: '',
      ));
    });
  }
}

extension OrderItemModelQueryObject
    on QueryBuilder<OrderItemModel, OrderItemModel, QFilterCondition> {}

extension OrderItemModelQueryLinks
    on QueryBuilder<OrderItemModel, OrderItemModel, QFilterCondition> {}

extension OrderItemModelQuerySortBy
    on QueryBuilder<OrderItemModel, OrderItemModel, QSortBy> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByAutoDiscountPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountPercent', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByAutoDiscountPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountPercent', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByIsPrinted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrinted', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByIsPrintedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrinted', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByIsVoided() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVoided', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByIsVoidedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVoided', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByManualDiscountPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualDiscountPercent', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByManualDiscountPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualDiscountPercent', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByMenuItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuItemId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByMenuItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuItemId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortBySeatNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seatNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortBySeatNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seatNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByVoidNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voidNote', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByVoidNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voidNote', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByVoidReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voidReason', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByVoidReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voidReason', Sort.desc);
    });
  }
}

extension OrderItemModelQuerySortThenBy
    on QueryBuilder<OrderItemModel, OrderItemModel, QSortThenBy> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByAutoDiscountPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountPercent', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByAutoDiscountPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountPercent', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByIsPrinted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrinted', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByIsPrintedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPrinted', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByIsVoided() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVoided', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByIsVoidedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVoided', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByManualDiscountPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualDiscountPercent', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByManualDiscountPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualDiscountPercent', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByMenuItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuItemId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByMenuItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuItemId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenBySeatNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seatNumber', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenBySeatNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seatNumber', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByVoidNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voidNote', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByVoidNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voidNote', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByVoidReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voidReason', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByVoidReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voidReason', Sort.desc);
    });
  }
}

extension OrderItemModelQueryWhereDistinct
    on QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> {
  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByAutoDiscountPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoDiscountPercent');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByIsPrinted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPrinted');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByIsVoided() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isVoided');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByManualDiscountPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manualDiscountPercent');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByMenuItemId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'menuItemId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctBySeatNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seatNumber');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByVoidNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voidNote', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByVoidReason(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voidReason', caseSensitive: caseSensitive);
    });
  }
}

extension OrderItemModelQueryProperty
    on QueryBuilder<OrderItemModel, OrderItemModel, QQueryProperty> {
  QueryBuilder<OrderItemModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OrderItemModel, double, QQueryOperations>
      autoDiscountPercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoDiscountPercent');
    });
  }

  QueryBuilder<OrderItemModel, bool, QQueryOperations> isPrintedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPrinted');
    });
  }

  QueryBuilder<OrderItemModel, bool, QQueryOperations> isVoidedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVoided');
    });
  }

  QueryBuilder<OrderItemModel, double, QQueryOperations>
      manualDiscountPercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manualDiscountPercent');
    });
  }

  QueryBuilder<OrderItemModel, String, QQueryOperations> menuItemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'menuItemId');
    });
  }

  QueryBuilder<OrderItemModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<OrderItemModel, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<OrderItemModel, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<OrderItemModel, int, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<OrderItemModel, int?, QQueryOperations> seatNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seatNumber');
    });
  }

  QueryBuilder<OrderItemModel, String?, QQueryOperations> voidNoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voidNote');
    });
  }

  QueryBuilder<OrderItemModel, String?, QQueryOperations> voidReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voidReason');
    });
  }
}
