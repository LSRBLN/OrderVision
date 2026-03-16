// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_profile_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPrinterProfileModelCollection on Isar {
  IsarCollection<PrinterProfileModel> get printerProfileModels =>
      this.collection();
}

const PrinterProfileModelSchema = CollectionSchema(
  name: r'PrinterProfileModel',
  id: -437328905351504277,
  properties: {
    r'autoCut': PropertySchema(
      id: 0,
      name: r'autoCut',
      type: IsarType.bool,
    ),
    r'bluetoothAddress': PropertySchema(
      id: 1,
      name: r'bluetoothAddress',
      type: IsarType.string,
    ),
    r'charactersPerLine': PropertySchema(
      id: 2,
      name: r'charactersPerLine',
      type: IsarType.long,
    ),
    r'connectionType': PropertySchema(
      id: 3,
      name: r'connectionType',
      type: IsarType.string,
      enumMap: _PrinterProfileModelconnectionTypeEnumValueMap,
    ),
    r'dpi': PropertySchema(
      id: 4,
      name: r'dpi',
      type: IsarType.long,
    ),
    r'ipAddress': PropertySchema(
      id: 5,
      name: r'ipAddress',
      type: IsarType.string,
    ),
    r'isDefault': PropertySchema(
      id: 6,
      name: r'isDefault',
      type: IsarType.bool,
    ),
    r'isKitchenPrinter': PropertySchema(
      id: 7,
      name: r'isKitchenPrinter',
      type: IsarType.bool,
    ),
    r'isReceiptPrinter': PropertySchema(
      id: 8,
      name: r'isReceiptPrinter',
      type: IsarType.bool,
    ),
    r'logoUrl': PropertySchema(
      id: 9,
      name: r'logoUrl',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 10,
      name: r'name',
      type: IsarType.string,
    ),
    r'openCashDrawer': PropertySchema(
      id: 11,
      name: r'openCashDrawer',
      type: IsarType.bool,
    ),
    r'paperWidthMm': PropertySchema(
      id: 12,
      name: r'paperWidthMm',
      type: IsarType.long,
    ),
    r'port': PropertySchema(
      id: 13,
      name: r'port',
      type: IsarType.long,
    ),
    r'profileId': PropertySchema(
      id: 14,
      name: r'profileId',
      type: IsarType.string,
    ),
    r'timeoutMs': PropertySchema(
      id: 15,
      name: r'timeoutMs',
      type: IsarType.long,
    )
  },
  estimateSize: _printerProfileModelEstimateSize,
  serialize: _printerProfileModelSerialize,
  deserialize: _printerProfileModelDeserialize,
  deserializeProp: _printerProfileModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'profileId': IndexSchema(
      id: 6052971939042612300,
      name: r'profileId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'profileId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _printerProfileModelGetId,
  getLinks: _printerProfileModelGetLinks,
  attach: _printerProfileModelAttach,
  version: '3.1.0+1',
);

int _printerProfileModelEstimateSize(
  PrinterProfileModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bluetoothAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.connectionType.name.length * 3;
  {
    final value = object.ipAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.logoUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.profileId.length * 3;
  return bytesCount;
}

void _printerProfileModelSerialize(
  PrinterProfileModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.autoCut);
  writer.writeString(offsets[1], object.bluetoothAddress);
  writer.writeLong(offsets[2], object.charactersPerLine);
  writer.writeString(offsets[3], object.connectionType.name);
  writer.writeLong(offsets[4], object.dpi);
  writer.writeString(offsets[5], object.ipAddress);
  writer.writeBool(offsets[6], object.isDefault);
  writer.writeBool(offsets[7], object.isKitchenPrinter);
  writer.writeBool(offsets[8], object.isReceiptPrinter);
  writer.writeString(offsets[9], object.logoUrl);
  writer.writeString(offsets[10], object.name);
  writer.writeBool(offsets[11], object.openCashDrawer);
  writer.writeLong(offsets[12], object.paperWidthMm);
  writer.writeLong(offsets[13], object.port);
  writer.writeString(offsets[14], object.profileId);
  writer.writeLong(offsets[15], object.timeoutMs);
}

PrinterProfileModel _printerProfileModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PrinterProfileModel();
  object.autoCut = reader.readBool(offsets[0]);
  object.bluetoothAddress = reader.readStringOrNull(offsets[1]);
  object.charactersPerLine = reader.readLong(offsets[2]);
  object.connectionType = _PrinterProfileModelconnectionTypeValueEnumMap[
          reader.readStringOrNull(offsets[3])] ??
      PrinterConnectionType.bluetooth;
  object.dpi = reader.readLong(offsets[4]);
  object.id = id;
  object.ipAddress = reader.readStringOrNull(offsets[5]);
  object.isDefault = reader.readBool(offsets[6]);
  object.isKitchenPrinter = reader.readBool(offsets[7]);
  object.isReceiptPrinter = reader.readBool(offsets[8]);
  object.logoUrl = reader.readStringOrNull(offsets[9]);
  object.name = reader.readString(offsets[10]);
  object.openCashDrawer = reader.readBool(offsets[11]);
  object.paperWidthMm = reader.readLong(offsets[12]);
  object.port = reader.readLong(offsets[13]);
  object.profileId = reader.readString(offsets[14]);
  object.timeoutMs = reader.readLong(offsets[15]);
  return object;
}

P _printerProfileModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (_PrinterProfileModelconnectionTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          PrinterConnectionType.bluetooth) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PrinterProfileModelconnectionTypeEnumValueMap = {
  r'bluetooth': r'bluetooth',
  r'network': r'network',
};
const _PrinterProfileModelconnectionTypeValueEnumMap = {
  r'bluetooth': PrinterConnectionType.bluetooth,
  r'network': PrinterConnectionType.network,
};

Id _printerProfileModelGetId(PrinterProfileModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _printerProfileModelGetLinks(
    PrinterProfileModel object) {
  return [];
}

void _printerProfileModelAttach(
    IsarCollection<dynamic> col, Id id, PrinterProfileModel object) {
  object.id = id;
}

extension PrinterProfileModelByIndex on IsarCollection<PrinterProfileModel> {
  Future<PrinterProfileModel?> getByProfileId(String profileId) {
    return getByIndex(r'profileId', [profileId]);
  }

  PrinterProfileModel? getByProfileIdSync(String profileId) {
    return getByIndexSync(r'profileId', [profileId]);
  }

  Future<bool> deleteByProfileId(String profileId) {
    return deleteByIndex(r'profileId', [profileId]);
  }

  bool deleteByProfileIdSync(String profileId) {
    return deleteByIndexSync(r'profileId', [profileId]);
  }

  Future<List<PrinterProfileModel?>> getAllByProfileId(
      List<String> profileIdValues) {
    final values = profileIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'profileId', values);
  }

  List<PrinterProfileModel?> getAllByProfileIdSync(
      List<String> profileIdValues) {
    final values = profileIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'profileId', values);
  }

  Future<int> deleteAllByProfileId(List<String> profileIdValues) {
    final values = profileIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'profileId', values);
  }

  int deleteAllByProfileIdSync(List<String> profileIdValues) {
    final values = profileIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'profileId', values);
  }

  Future<Id> putByProfileId(PrinterProfileModel object) {
    return putByIndex(r'profileId', object);
  }

  Id putByProfileIdSync(PrinterProfileModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'profileId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByProfileId(List<PrinterProfileModel> objects) {
    return putAllByIndex(r'profileId', objects);
  }

  List<Id> putAllByProfileIdSync(List<PrinterProfileModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'profileId', objects, saveLinks: saveLinks);
  }
}

extension PrinterProfileModelQueryWhereSort
    on QueryBuilder<PrinterProfileModel, PrinterProfileModel, QWhere> {
  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PrinterProfileModelQueryWhere
    on QueryBuilder<PrinterProfileModel, PrinterProfileModel, QWhereClause> {
  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterWhereClause>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterWhereClause>
      profileIdEqualTo(String profileId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'profileId',
        value: [profileId],
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterWhereClause>
      profileIdNotEqualTo(String profileId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileId',
              lower: [],
              upper: [profileId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileId',
              lower: [profileId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileId',
              lower: [profileId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'profileId',
              lower: [],
              upper: [profileId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PrinterProfileModelQueryFilter on QueryBuilder<PrinterProfileModel,
    PrinterProfileModel, QFilterCondition> {
  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      autoCutEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoCut',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bluetoothAddress',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bluetoothAddress',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bluetoothAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bluetoothAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bluetoothAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bluetoothAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bluetoothAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bluetoothAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bluetoothAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bluetoothAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bluetoothAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      bluetoothAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bluetoothAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      charactersPerLineEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'charactersPerLine',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      charactersPerLineGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'charactersPerLine',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      charactersPerLineLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'charactersPerLine',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      charactersPerLineBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'charactersPerLine',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeEqualTo(
    PrinterConnectionType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeGreaterThan(
    PrinterConnectionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeLessThan(
    PrinterConnectionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeBetween(
    PrinterConnectionType lower,
    PrinterConnectionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'connectionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'connectionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'connectionType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'connectionType',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      connectionTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'connectionType',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      dpiEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dpi',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      dpiGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dpi',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      dpiLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dpi',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      dpiBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dpi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ipAddress',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ipAddress',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ipAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ipAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ipAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ipAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      ipAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ipAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      isDefaultEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDefault',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      isKitchenPrinterEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isKitchenPrinter',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      isReceiptPrinterEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isReceiptPrinter',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logoUrl',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logoUrl',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logoUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logoUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      logoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
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

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      openCashDrawerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openCashDrawer',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      paperWidthMmEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paperWidthMm',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      paperWidthMmGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paperWidthMm',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      paperWidthMmLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paperWidthMm',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      paperWidthMmBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paperWidthMm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      portEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      portGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      portLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      portBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'port',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profileId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profileId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileId',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      profileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profileId',
        value: '',
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      timeoutMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeoutMs',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      timeoutMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeoutMs',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      timeoutMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeoutMs',
        value: value,
      ));
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterFilterCondition>
      timeoutMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeoutMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PrinterProfileModelQueryObject on QueryBuilder<PrinterProfileModel,
    PrinterProfileModel, QFilterCondition> {}

extension PrinterProfileModelQueryLinks on QueryBuilder<PrinterProfileModel,
    PrinterProfileModel, QFilterCondition> {}

extension PrinterProfileModelQuerySortBy
    on QueryBuilder<PrinterProfileModel, PrinterProfileModel, QSortBy> {
  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByAutoCut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoCut', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByAutoCutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoCut', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByBluetoothAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bluetoothAddress', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByBluetoothAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bluetoothAddress', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByCharactersPerLine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charactersPerLine', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByCharactersPerLineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charactersPerLine', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByConnectionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionType', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByConnectionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionType', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByDpi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpi', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByDpiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpi', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByIpAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByIpAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByIsKitchenPrinter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isKitchenPrinter', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByIsKitchenPrinterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isKitchenPrinter', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByIsReceiptPrinter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReceiptPrinter', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByIsReceiptPrinterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReceiptPrinter', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByLogoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByLogoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByOpenCashDrawer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openCashDrawer', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByOpenCashDrawerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openCashDrawer', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByPaperWidthMm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paperWidthMm', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByPaperWidthMmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paperWidthMm', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByTimeoutMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeoutMs', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      sortByTimeoutMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeoutMs', Sort.desc);
    });
  }
}

extension PrinterProfileModelQuerySortThenBy
    on QueryBuilder<PrinterProfileModel, PrinterProfileModel, QSortThenBy> {
  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByAutoCut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoCut', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByAutoCutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoCut', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByBluetoothAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bluetoothAddress', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByBluetoothAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bluetoothAddress', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByCharactersPerLine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charactersPerLine', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByCharactersPerLineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'charactersPerLine', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByConnectionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionType', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByConnectionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'connectionType', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByDpi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpi', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByDpiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dpi', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByIpAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByIpAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ipAddress', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByIsDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDefault', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByIsKitchenPrinter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isKitchenPrinter', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByIsKitchenPrinterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isKitchenPrinter', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByIsReceiptPrinter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReceiptPrinter', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByIsReceiptPrinterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReceiptPrinter', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByLogoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByLogoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoUrl', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByOpenCashDrawer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openCashDrawer', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByOpenCashDrawerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openCashDrawer', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByPaperWidthMm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paperWidthMm', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByPaperWidthMmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paperWidthMm', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByTimeoutMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeoutMs', Sort.asc);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QAfterSortBy>
      thenByTimeoutMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeoutMs', Sort.desc);
    });
  }
}

extension PrinterProfileModelQueryWhereDistinct
    on QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct> {
  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByAutoCut() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoCut');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByBluetoothAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bluetoothAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByCharactersPerLine() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'charactersPerLine');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByConnectionType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'connectionType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByDpi() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dpi');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByIpAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ipAddress', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByIsDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDefault');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByIsKitchenPrinter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isKitchenPrinter');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByIsReceiptPrinter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isReceiptPrinter');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByLogoUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logoUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByOpenCashDrawer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openCashDrawer');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByPaperWidthMm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paperWidthMm');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'port');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByProfileId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterProfileModel, QDistinct>
      distinctByTimeoutMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeoutMs');
    });
  }
}

extension PrinterProfileModelQueryProperty
    on QueryBuilder<PrinterProfileModel, PrinterProfileModel, QQueryProperty> {
  QueryBuilder<PrinterProfileModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PrinterProfileModel, bool, QQueryOperations> autoCutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoCut');
    });
  }

  QueryBuilder<PrinterProfileModel, String?, QQueryOperations>
      bluetoothAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bluetoothAddress');
    });
  }

  QueryBuilder<PrinterProfileModel, int, QQueryOperations>
      charactersPerLineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'charactersPerLine');
    });
  }

  QueryBuilder<PrinterProfileModel, PrinterConnectionType, QQueryOperations>
      connectionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'connectionType');
    });
  }

  QueryBuilder<PrinterProfileModel, int, QQueryOperations> dpiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dpi');
    });
  }

  QueryBuilder<PrinterProfileModel, String?, QQueryOperations>
      ipAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ipAddress');
    });
  }

  QueryBuilder<PrinterProfileModel, bool, QQueryOperations>
      isDefaultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDefault');
    });
  }

  QueryBuilder<PrinterProfileModel, bool, QQueryOperations>
      isKitchenPrinterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isKitchenPrinter');
    });
  }

  QueryBuilder<PrinterProfileModel, bool, QQueryOperations>
      isReceiptPrinterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isReceiptPrinter');
    });
  }

  QueryBuilder<PrinterProfileModel, String?, QQueryOperations>
      logoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logoUrl');
    });
  }

  QueryBuilder<PrinterProfileModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PrinterProfileModel, bool, QQueryOperations>
      openCashDrawerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openCashDrawer');
    });
  }

  QueryBuilder<PrinterProfileModel, int, QQueryOperations>
      paperWidthMmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paperWidthMm');
    });
  }

  QueryBuilder<PrinterProfileModel, int, QQueryOperations> portProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'port');
    });
  }

  QueryBuilder<PrinterProfileModel, String, QQueryOperations>
      profileIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileId');
    });
  }

  QueryBuilder<PrinterProfileModel, int, QQueryOperations> timeoutMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeoutMs');
    });
  }
}
