// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTableModelCollection on Isar {
  IsarCollection<TableModel> get tableModels => this.collection();
}

const TableModelSchema = CollectionSchema(
  name: r'TableModel',
  id: 3157658449793411318,
  properties: {
    r'assignedWaiterId': PropertySchema(
      id: 0,
      name: r'assignedWaiterId',
      type: IsarType.string,
    ),
    r'openedAt': PropertySchema(
      id: 1,
      name: r'openedAt',
      type: IsarType.dateTime,
    ),
    r'posX': PropertySchema(
      id: 2,
      name: r'posX',
      type: IsarType.double,
    ),
    r'posY': PropertySchema(
      id: 3,
      name: r'posY',
      type: IsarType.double,
    ),
    r'seats': PropertySchema(
      id: 4,
      name: r'seats',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.string,
      enumMap: _TableModelstatusEnumValueMap,
    ),
    r'tableNumber': PropertySchema(
      id: 6,
      name: r'tableNumber',
      type: IsarType.long,
    )
  },
  estimateSize: _tableModelEstimateSize,
  serialize: _tableModelSerialize,
  deserialize: _tableModelDeserialize,
  deserializeProp: _tableModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'tableNumber': IndexSchema(
      id: -3323858932237924188,
      name: r'tableNumber',
      unique: true,
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
    r'orders': LinkSchema(
      id: -7359891780955444010,
      name: r'orders',
      target: r'OrderModel',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _tableModelGetId,
  getLinks: _tableModelGetLinks,
  attach: _tableModelAttach,
  version: '3.1.0+1',
);

int _tableModelEstimateSize(
  TableModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.assignedWaiterId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.name.length * 3;
  return bytesCount;
}

void _tableModelSerialize(
  TableModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.assignedWaiterId);
  writer.writeDateTime(offsets[1], object.openedAt);
  writer.writeDouble(offsets[2], object.posX);
  writer.writeDouble(offsets[3], object.posY);
  writer.writeLong(offsets[4], object.seats);
  writer.writeString(offsets[5], object.status.name);
  writer.writeLong(offsets[6], object.tableNumber);
}

TableModel _tableModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TableModel();
  object.assignedWaiterId = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.openedAt = reader.readDateTimeOrNull(offsets[1]);
  object.posX = reader.readDouble(offsets[2]);
  object.posY = reader.readDouble(offsets[3]);
  object.seats = reader.readLong(offsets[4]);
  object.status =
      _TableModelstatusValueEnumMap[reader.readStringOrNull(offsets[5])] ??
          TableStatus.free;
  object.tableNumber = reader.readLong(offsets[6]);
  return object;
}

P _tableModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (_TableModelstatusValueEnumMap[reader.readStringOrNull(offset)] ??
          TableStatus.free) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TableModelstatusEnumValueMap = {
  r'free': r'free',
  r'occupied': r'occupied',
  r'ordered': r'ordered',
  r'preparing': r'preparing',
  r'ready': r'ready',
  r'payment': r'payment',
};
const _TableModelstatusValueEnumMap = {
  r'free': TableStatus.free,
  r'occupied': TableStatus.occupied,
  r'ordered': TableStatus.ordered,
  r'preparing': TableStatus.preparing,
  r'ready': TableStatus.ready,
  r'payment': TableStatus.payment,
};

Id _tableModelGetId(TableModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tableModelGetLinks(TableModel object) {
  return [object.orders];
}

void _tableModelAttach(IsarCollection<dynamic> col, Id id, TableModel object) {
  object.id = id;
  object.orders.attach(col, col.isar.collection<OrderModel>(), r'orders', id);
}

extension TableModelByIndex on IsarCollection<TableModel> {
  Future<TableModel?> getByTableNumber(int tableNumber) {
    return getByIndex(r'tableNumber', [tableNumber]);
  }

  TableModel? getByTableNumberSync(int tableNumber) {
    return getByIndexSync(r'tableNumber', [tableNumber]);
  }

  Future<bool> deleteByTableNumber(int tableNumber) {
    return deleteByIndex(r'tableNumber', [tableNumber]);
  }

  bool deleteByTableNumberSync(int tableNumber) {
    return deleteByIndexSync(r'tableNumber', [tableNumber]);
  }

  Future<List<TableModel?>> getAllByTableNumber(List<int> tableNumberValues) {
    final values = tableNumberValues.map((e) => [e]).toList();
    return getAllByIndex(r'tableNumber', values);
  }

  List<TableModel?> getAllByTableNumberSync(List<int> tableNumberValues) {
    final values = tableNumberValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'tableNumber', values);
  }

  Future<int> deleteAllByTableNumber(List<int> tableNumberValues) {
    final values = tableNumberValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'tableNumber', values);
  }

  int deleteAllByTableNumberSync(List<int> tableNumberValues) {
    final values = tableNumberValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'tableNumber', values);
  }

  Future<Id> putByTableNumber(TableModel object) {
    return putByIndex(r'tableNumber', object);
  }

  Id putByTableNumberSync(TableModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'tableNumber', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTableNumber(List<TableModel> objects) {
    return putAllByIndex(r'tableNumber', objects);
  }

  List<Id> putAllByTableNumberSync(List<TableModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'tableNumber', objects, saveLinks: saveLinks);
  }
}

extension TableModelQueryWhereSort
    on QueryBuilder<TableModel, TableModel, QWhere> {
  QueryBuilder<TableModel, TableModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterWhere> anyTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'tableNumber'),
      );
    });
  }
}

extension TableModelQueryWhere
    on QueryBuilder<TableModel, TableModel, QWhereClause> {
  QueryBuilder<TableModel, TableModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TableModel, TableModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<TableModel, TableModel, QAfterWhereClause> tableNumberEqualTo(
      int tableNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tableNumber',
        value: [tableNumber],
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterWhereClause> tableNumberNotEqualTo(
      int tableNumber) {
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

  QueryBuilder<TableModel, TableModel, QAfterWhereClause>
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

  QueryBuilder<TableModel, TableModel, QAfterWhereClause> tableNumberLessThan(
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

  QueryBuilder<TableModel, TableModel, QAfterWhereClause> tableNumberBetween(
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

extension TableModelQueryFilter
    on QueryBuilder<TableModel, TableModel, QFilterCondition> {
  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'assignedWaiterId',
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'assignedWaiterId',
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedWaiterId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assignedWaiterId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assignedWaiterId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assignedWaiterId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assignedWaiterId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assignedWaiterId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assignedWaiterId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assignedWaiterId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedWaiterId',
        value: '',
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      assignedWaiterIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assignedWaiterId',
        value: '',
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> openedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'openedAt',
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      openedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'openedAt',
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> openedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      openedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> openedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> openedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> posXEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'posX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> posXGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'posX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> posXLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'posX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> posXBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'posX',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> posYEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'posY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> posYGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'posY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> posYLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'posY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> posYBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'posY',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> seatsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seats',
        value: value,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> seatsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seats',
        value: value,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> seatsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seats',
        value: value,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> seatsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seats',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> statusEqualTo(
    TableStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> statusGreaterThan(
    TableStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> statusLessThan(
    TableStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> statusBetween(
    TableStatus lower,
    TableStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      tableNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tableNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
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

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
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

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
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
}

extension TableModelQueryObject
    on QueryBuilder<TableModel, TableModel, QFilterCondition> {}

extension TableModelQueryLinks
    on QueryBuilder<TableModel, TableModel, QFilterCondition> {
  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> orders(
      FilterQuery<OrderModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'orders');
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      ordersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', length, true, length, true);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition> ordersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, true, 0, true);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      ordersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, false, 999999, true);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      ordersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', 0, true, length, include);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      ordersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'orders', length, include, 999999, true);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterFilterCondition>
      ordersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'orders', lower, includeLower, upper, includeUpper);
    });
  }
}

extension TableModelQuerySortBy
    on QueryBuilder<TableModel, TableModel, QSortBy> {
  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByAssignedWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedWaiterId', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy>
      sortByAssignedWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedWaiterId', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openedAt', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openedAt', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByPosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posX', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByPosXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posX', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByPosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posY', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByPosYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posY', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortBySeats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seats', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortBySeatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seats', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> sortByTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.desc);
    });
  }
}

extension TableModelQuerySortThenBy
    on QueryBuilder<TableModel, TableModel, QSortThenBy> {
  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByAssignedWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedWaiterId', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy>
      thenByAssignedWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedWaiterId', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openedAt', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openedAt', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByPosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posX', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByPosXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posX', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByPosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posY', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByPosYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posY', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenBySeats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seats', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenBySeatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seats', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.asc);
    });
  }

  QueryBuilder<TableModel, TableModel, QAfterSortBy> thenByTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.desc);
    });
  }
}

extension TableModelQueryWhereDistinct
    on QueryBuilder<TableModel, TableModel, QDistinct> {
  QueryBuilder<TableModel, TableModel, QDistinct> distinctByAssignedWaiterId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assignedWaiterId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TableModel, TableModel, QDistinct> distinctByOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openedAt');
    });
  }

  QueryBuilder<TableModel, TableModel, QDistinct> distinctByPosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'posX');
    });
  }

  QueryBuilder<TableModel, TableModel, QDistinct> distinctByPosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'posY');
    });
  }

  QueryBuilder<TableModel, TableModel, QDistinct> distinctBySeats() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seats');
    });
  }

  QueryBuilder<TableModel, TableModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TableModel, TableModel, QDistinct> distinctByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tableNumber');
    });
  }
}

extension TableModelQueryProperty
    on QueryBuilder<TableModel, TableModel, QQueryProperty> {
  QueryBuilder<TableModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TableModel, String?, QQueryOperations>
      assignedWaiterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assignedWaiterId');
    });
  }

  QueryBuilder<TableModel, DateTime?, QQueryOperations> openedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openedAt');
    });
  }

  QueryBuilder<TableModel, double, QQueryOperations> posXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'posX');
    });
  }

  QueryBuilder<TableModel, double, QQueryOperations> posYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'posY');
    });
  }

  QueryBuilder<TableModel, int, QQueryOperations> seatsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seats');
    });
  }

  QueryBuilder<TableModel, TableStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<TableModel, int, QQueryOperations> tableNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tableNumber');
    });
  }
}
