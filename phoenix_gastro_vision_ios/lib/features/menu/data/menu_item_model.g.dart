// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMenuItemModelCollection on Isar {
  IsarCollection<MenuItemModel> get menuItemModels => this.collection();
}

const MenuItemModelSchema = CollectionSchema(
  name: r'MenuItemModel',
  id: 7014635700844098072,
  properties: {
    r'allergens': PropertySchema(
      id: 0,
      name: r'allergens',
      type: IsarType.string,
    ),
    r'autoDiscountPercent': PropertySchema(
      id: 1,
      name: r'autoDiscountPercent',
      type: IsarType.double,
    ),
    r'autoDiscountThreshold': PropertySchema(
      id: 2,
      name: r'autoDiscountThreshold',
      type: IsarType.long,
    ),
    r'categoryId': PropertySchema(
      id: 3,
      name: r'categoryId',
      type: IsarType.string,
    ),
    r'discountEligible': PropertySchema(
      id: 4,
      name: r'discountEligible',
      type: IsarType.bool,
    ),
    r'happyHourPrice': PropertySchema(
      id: 5,
      name: r'happyHourPrice',
      type: IsarType.double,
    ),
    r'isActive': PropertySchema(
      id: 6,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'itemId': PropertySchema(
      id: 7,
      name: r'itemId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'premiumPrice': PropertySchema(
      id: 9,
      name: r'premiumPrice',
      type: IsarType.double,
    ),
    r'price': PropertySchema(
      id: 10,
      name: r'price',
      type: IsarType.double,
    ),
    r'priceLevels': PropertySchema(
      id: 11,
      name: r'priceLevels',
      type: IsarType.string,
    ),
    r'sortOrder': PropertySchema(
      id: 12,
      name: r'sortOrder',
      type: IsarType.long,
    )
  },
  estimateSize: _menuItemModelEstimateSize,
  serialize: _menuItemModelSerialize,
  deserialize: _menuItemModelDeserialize,
  deserializeProp: _menuItemModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'itemId': IndexSchema(
      id: -5342806140158601489,
      name: r'itemId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'itemId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _menuItemModelGetId,
  getLinks: _menuItemModelGetLinks,
  attach: _menuItemModelAttach,
  version: '3.1.0+1',
);

int _menuItemModelEstimateSize(
  MenuItemModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.allergens.length * 3;
  bytesCount += 3 + object.categoryId.length * 3;
  bytesCount += 3 + object.itemId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.priceLevels.length * 3;
  return bytesCount;
}

void _menuItemModelSerialize(
  MenuItemModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.allergens);
  writer.writeDouble(offsets[1], object.autoDiscountPercent);
  writer.writeLong(offsets[2], object.autoDiscountThreshold);
  writer.writeString(offsets[3], object.categoryId);
  writer.writeBool(offsets[4], object.discountEligible);
  writer.writeDouble(offsets[5], object.happyHourPrice);
  writer.writeBool(offsets[6], object.isActive);
  writer.writeString(offsets[7], object.itemId);
  writer.writeString(offsets[8], object.name);
  writer.writeDouble(offsets[9], object.premiumPrice);
  writer.writeDouble(offsets[10], object.price);
  writer.writeString(offsets[11], object.priceLevels);
  writer.writeLong(offsets[12], object.sortOrder);
}

MenuItemModel _menuItemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MenuItemModel();
  object.allergens = reader.readString(offsets[0]);
  object.autoDiscountPercent = reader.readDouble(offsets[1]);
  object.autoDiscountThreshold = reader.readLong(offsets[2]);
  object.categoryId = reader.readString(offsets[3]);
  object.discountEligible = reader.readBool(offsets[4]);
  object.happyHourPrice = reader.readDoubleOrNull(offsets[5]);
  object.id = id;
  object.isActive = reader.readBool(offsets[6]);
  object.itemId = reader.readString(offsets[7]);
  object.name = reader.readString(offsets[8]);
  object.premiumPrice = reader.readDoubleOrNull(offsets[9]);
  object.price = reader.readDouble(offsets[10]);
  object.priceLevels = reader.readString(offsets[11]);
  object.sortOrder = reader.readLong(offsets[12]);
  return object;
}

P _menuItemModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _menuItemModelGetId(MenuItemModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _menuItemModelGetLinks(MenuItemModel object) {
  return [];
}

void _menuItemModelAttach(
    IsarCollection<dynamic> col, Id id, MenuItemModel object) {
  object.id = id;
}

extension MenuItemModelByIndex on IsarCollection<MenuItemModel> {
  Future<MenuItemModel?> getByItemId(String itemId) {
    return getByIndex(r'itemId', [itemId]);
  }

  MenuItemModel? getByItemIdSync(String itemId) {
    return getByIndexSync(r'itemId', [itemId]);
  }

  Future<bool> deleteByItemId(String itemId) {
    return deleteByIndex(r'itemId', [itemId]);
  }

  bool deleteByItemIdSync(String itemId) {
    return deleteByIndexSync(r'itemId', [itemId]);
  }

  Future<List<MenuItemModel?>> getAllByItemId(List<String> itemIdValues) {
    final values = itemIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'itemId', values);
  }

  List<MenuItemModel?> getAllByItemIdSync(List<String> itemIdValues) {
    final values = itemIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'itemId', values);
  }

  Future<int> deleteAllByItemId(List<String> itemIdValues) {
    final values = itemIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'itemId', values);
  }

  int deleteAllByItemIdSync(List<String> itemIdValues) {
    final values = itemIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'itemId', values);
  }

  Future<Id> putByItemId(MenuItemModel object) {
    return putByIndex(r'itemId', object);
  }

  Id putByItemIdSync(MenuItemModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'itemId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByItemId(List<MenuItemModel> objects) {
    return putAllByIndex(r'itemId', objects);
  }

  List<Id> putAllByItemIdSync(List<MenuItemModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'itemId', objects, saveLinks: saveLinks);
  }
}

extension MenuItemModelQueryWhereSort
    on QueryBuilder<MenuItemModel, MenuItemModel, QWhere> {
  QueryBuilder<MenuItemModel, MenuItemModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MenuItemModelQueryWhere
    on QueryBuilder<MenuItemModel, MenuItemModel, QWhereClause> {
  QueryBuilder<MenuItemModel, MenuItemModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterWhereClause> itemIdEqualTo(
      String itemId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'itemId',
        value: [itemId],
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterWhereClause>
      itemIdNotEqualTo(String itemId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'itemId',
              lower: [],
              upper: [itemId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'itemId',
              lower: [itemId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'itemId',
              lower: [itemId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'itemId',
              lower: [],
              upper: [itemId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MenuItemModelQueryFilter
    on QueryBuilder<MenuItemModel, MenuItemModel, QFilterCondition> {
  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allergens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allergens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allergens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allergens',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'allergens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'allergens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'allergens',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'allergens',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allergens',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      allergensIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'allergens',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      autoDiscountThresholdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoDiscountThreshold',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      autoDiscountThresholdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'autoDiscountThreshold',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      autoDiscountThresholdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'autoDiscountThreshold',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      autoDiscountThresholdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'autoDiscountThreshold',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      categoryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      discountEligibleEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discountEligible',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      happyHourPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'happyHourPrice',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      happyHourPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'happyHourPrice',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      happyHourPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'happyHourPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      happyHourPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'happyHourPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      happyHourPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'happyHourPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      happyHourPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'happyHourPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'itemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'itemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'itemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'itemId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      itemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'itemId',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      premiumPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'premiumPrice',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      premiumPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'premiumPrice',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      premiumPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'premiumPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      premiumPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'premiumPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      premiumPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'premiumPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      premiumPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'premiumPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
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

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priceLevels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priceLevels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priceLevels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priceLevels',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'priceLevels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'priceLevels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'priceLevels',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'priceLevels',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priceLevels',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      priceLevelsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'priceLevels',
        value: '',
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      sortOrderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      sortOrderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      sortOrderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterFilterCondition>
      sortOrderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sortOrder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MenuItemModelQueryObject
    on QueryBuilder<MenuItemModel, MenuItemModel, QFilterCondition> {}

extension MenuItemModelQueryLinks
    on QueryBuilder<MenuItemModel, MenuItemModel, QFilterCondition> {}

extension MenuItemModelQuerySortBy
    on QueryBuilder<MenuItemModel, MenuItemModel, QSortBy> {
  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByAllergens() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergens', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByAllergensDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergens', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByAutoDiscountPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountPercent', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByAutoDiscountPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountPercent', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByAutoDiscountThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountThreshold', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByAutoDiscountThresholdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountThreshold', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByDiscountEligible() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountEligible', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByDiscountEligibleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountEligible', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByHappyHourPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'happyHourPrice', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByHappyHourPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'happyHourPrice', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByPremiumPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumPrice', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByPremiumPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumPrice', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortByPriceLevels() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceLevels', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortByPriceLevelsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceLevels', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> sortBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      sortBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }
}

extension MenuItemModelQuerySortThenBy
    on QueryBuilder<MenuItemModel, MenuItemModel, QSortThenBy> {
  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByAllergens() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergens', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByAllergensDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergens', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByAutoDiscountPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountPercent', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByAutoDiscountPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountPercent', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByAutoDiscountThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountThreshold', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByAutoDiscountThresholdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoDiscountThreshold', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByDiscountEligible() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountEligible', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByDiscountEligibleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountEligible', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByHappyHourPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'happyHourPrice', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByHappyHourPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'happyHourPrice', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByPremiumPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumPrice', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByPremiumPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'premiumPrice', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenByPriceLevels() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceLevels', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenByPriceLevelsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceLevels', Sort.desc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy> thenBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QAfterSortBy>
      thenBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }
}

extension MenuItemModelQueryWhereDistinct
    on QueryBuilder<MenuItemModel, MenuItemModel, QDistinct> {
  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct> distinctByAllergens(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allergens', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct>
      distinctByAutoDiscountPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoDiscountPercent');
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct>
      distinctByAutoDiscountThreshold() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoDiscountThreshold');
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct> distinctByCategoryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct>
      distinctByDiscountEligible() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'discountEligible');
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct>
      distinctByHappyHourPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'happyHourPrice');
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct> distinctByItemId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct>
      distinctByPremiumPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'premiumPrice');
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct> distinctByPriceLevels(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priceLevels', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MenuItemModel, MenuItemModel, QDistinct> distinctBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortOrder');
    });
  }
}

extension MenuItemModelQueryProperty
    on QueryBuilder<MenuItemModel, MenuItemModel, QQueryProperty> {
  QueryBuilder<MenuItemModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MenuItemModel, String, QQueryOperations> allergensProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allergens');
    });
  }

  QueryBuilder<MenuItemModel, double, QQueryOperations>
      autoDiscountPercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoDiscountPercent');
    });
  }

  QueryBuilder<MenuItemModel, int, QQueryOperations>
      autoDiscountThresholdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoDiscountThreshold');
    });
  }

  QueryBuilder<MenuItemModel, String, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<MenuItemModel, bool, QQueryOperations>
      discountEligibleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'discountEligible');
    });
  }

  QueryBuilder<MenuItemModel, double?, QQueryOperations>
      happyHourPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'happyHourPrice');
    });
  }

  QueryBuilder<MenuItemModel, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<MenuItemModel, String, QQueryOperations> itemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemId');
    });
  }

  QueryBuilder<MenuItemModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MenuItemModel, double?, QQueryOperations>
      premiumPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'premiumPrice');
    });
  }

  QueryBuilder<MenuItemModel, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<MenuItemModel, String, QQueryOperations> priceLevelsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priceLevels');
    });
  }

  QueryBuilder<MenuItemModel, int, QQueryOperations> sortOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortOrder');
    });
  }
}
