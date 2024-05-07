// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_command.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarCommandCollection on Isar {
  IsarCollection<IsarCommand> get isarCommands => this.collection();
}

final IsarCommandSchema = CollectionSchema(
  name: r'IsarCommand',
  id: int.parse(dotenv.env['ID_ISAR_COMMAND'] ?? ""),
  properties: {
    r'b': PropertySchema(
      id: 0,
      name: r'b',
      type: IsarType.long,
    ),
    r'c': PropertySchema(
      id: 1,
      name: r'c',
      type: IsarType.long,
    ),
    r'g': PropertySchema(
      id: 2,
      name: r'g',
      type: IsarType.long,
    ),
    r'gid': PropertySchema(
      id: 3,
      name: r'gid',
      type: IsarType.long,
    ),
    r'lampsIds': PropertySchema(
      id: 4,
      name: r'lampsIds',
      type: IsarType.longList,
    ),
    r'pir': PropertySchema(
      id: 5,
      name: r'pir',
      type: IsarType.bool,
    ),
    r'r': PropertySchema(
      id: 6,
      name: r'r',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.string,
    ),
    r'w': PropertySchema(
      id: 8,
      name: r'w',
      type: IsarType.long,
    ),
    r'y': PropertySchema(
      id: 9,
      name: r'y',
      type: IsarType.long,
    )
  },
  estimateSize: _isarCommandEstimateSize,
  serialize: _isarCommandSerialize,
  deserialize: _isarCommandDeserialize,
  deserializeProp: _isarCommandDeserializeProp,
  idName: r'idDb',
  indexes: {},
  links: {
    r'lamp': LinkSchema(
      id: int.parse(dotenv.env["ID_LAMP_COMMAND"] ?? ""),
      name: r'lamp',
      target: r'IsarLamp',
      single: false,
      linkName: r'command',
    ),
    r'groups': LinkSchema(
      id: int.parse(dotenv.env["ID_GROUPS_COMMAND"] ?? ""),
      name: r'groups',
      target: r'IsarGroup',
      single: false,
      linkName: r'command',
    )
  },
  embeddedSchemas: {},
  getId: _isarCommandGetId,
  getLinks: _isarCommandGetLinks,
  attach: _isarCommandAttach,
  version: '3.1.0+1',
);

int _isarCommandEstimateSize(
  IsarCommand object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lampsIds;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarCommandSerialize(
  IsarCommand object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.b);
  writer.writeLong(offsets[1], object.c);
  writer.writeLong(offsets[2], object.g);
  writer.writeLong(offsets[3], object.gid);
  writer.writeLongList(offsets[4], object.lampsIds);
  writer.writeBool(offsets[5], object.pir);
  writer.writeLong(offsets[6], object.r);
  writer.writeString(offsets[7], object.type);
  writer.writeLong(offsets[8], object.w);
  writer.writeLong(offsets[9], object.y);
}

IsarCommand _isarCommandDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarCommand(
    b: reader.readLongOrNull(offsets[0]),
    c: reader.readLongOrNull(offsets[1]),
    g: reader.readLongOrNull(offsets[2]),
    gid: reader.readLongOrNull(offsets[3]),
    lampsIds: reader.readLongList(offsets[4]),
    pir: reader.readBoolOrNull(offsets[5]),
    r: reader.readLongOrNull(offsets[6]),
    type: reader.readStringOrNull(offsets[7]),
    w: reader.readLongOrNull(offsets[8]),
    y: reader.readLongOrNull(offsets[9]),
  );
  object.idDb = id;
  return object;
}

P _isarCommandDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongList(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarCommandGetId(IsarCommand object) {
  return object.idDb;
}

List<IsarLinkBase<dynamic>> _isarCommandGetLinks(IsarCommand object) {
  return [object.lamp, object.groups];
}

void _isarCommandAttach(
    IsarCollection<dynamic> col, Id id, IsarCommand object) {
  object.idDb = id;
  object.lamp.attach(col, col.isar.collection<IsarLamp>(), r'lamp', id);
  object.groups.attach(col, col.isar.collection<IsarGroup>(), r'groups', id);
}

extension IsarCommandQueryWhereSort
    on QueryBuilder<IsarCommand, IsarCommand, QWhere> {
  QueryBuilder<IsarCommand, IsarCommand, QAfterWhere> anyIdDb() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarCommandQueryWhere
    on QueryBuilder<IsarCommand, IsarCommand, QWhereClause> {
  QueryBuilder<IsarCommand, IsarCommand, QAfterWhereClause> idDbEqualTo(
      Id idDb) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idDb,
        upper: idDb,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterWhereClause> idDbNotEqualTo(
      Id idDb) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idDb, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idDb, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idDb, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idDb, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterWhereClause> idDbGreaterThan(
      Id idDb,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idDb, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterWhereClause> idDbLessThan(
      Id idDb,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idDb, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterWhereClause> idDbBetween(
    Id lowerIdDb,
    Id upperIdDb, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdDb,
        includeLower: includeLower,
        upper: upperIdDb,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarCommandQueryFilter
    on QueryBuilder<IsarCommand, IsarCommand, QFilterCondition> {
  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> bIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'b',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> bIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'b',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> bEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'b',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> bGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'b',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> bLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'b',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> bBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'b',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> cIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'c',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> cIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'c',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> cEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'c',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> cGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'c',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> cLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'c',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> cBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'c',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'g',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'g',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'g',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'g',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'g',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'g',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gid',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gid',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gidEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gid',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gidGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gid',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gidLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gid',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> gidBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> idDbEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idDb',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> idDbGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idDb',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> idDbLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idDb',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> idDbBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idDb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lampsIds',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lampsIds',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lampsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lampsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lampsIds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lampsIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lampsIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lampsIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lampsIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lampsIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lampsIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampsIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lampsIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> pirIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pir',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> pirIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pir',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> pirEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pir',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> rIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'r',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> rIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'r',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> rEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'r',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> rGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'r',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> rLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'r',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> rBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'r',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> wIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'w',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> wIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'w',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> wEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'w',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> wGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'w',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> wLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'w',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> wBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'w',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> yIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'y',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> yIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'y',
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> yEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'y',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> yGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'y',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> yLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'y',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> yBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'y',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarCommandQueryObject
    on QueryBuilder<IsarCommand, IsarCommand, QFilterCondition> {}

extension IsarCommandQueryLinks
    on QueryBuilder<IsarCommand, IsarCommand, QFilterCondition> {
  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> lamp(
      FilterQuery<IsarLamp> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'lamp');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamp', length, true, length, true);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> lampIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamp', 0, true, 0, true);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamp', 0, false, 999999, true);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamp', 0, true, length, include);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamp', length, include, 999999, true);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      lampLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'lamp', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition> groups(
      FilterQuery<IsarGroup> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'groups');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      groupsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', length, true, length, true);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      groupsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', 0, true, 0, true);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      groupsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', 0, false, 999999, true);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      groupsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', 0, true, length, include);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      groupsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', length, include, 999999, true);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterFilterCondition>
      groupsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'groups', lower, includeLower, upper, includeUpper);
    });
  }
}

extension IsarCommandQuerySortBy
    on QueryBuilder<IsarCommand, IsarCommand, QSortBy> {
  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'b', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'b', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'c', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'c', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'g', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'g', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByGid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gid', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByGidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gid', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByPir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pir', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByPirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pir', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByR() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'r', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByRDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'r', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByW() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'w', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByWDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'w', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'y', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> sortByYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'y', Sort.desc);
    });
  }
}

extension IsarCommandQuerySortThenBy
    on QueryBuilder<IsarCommand, IsarCommand, QSortThenBy> {
  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'b', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'b', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'c', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'c', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByG() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'g', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByGDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'g', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByGid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gid', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByGidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gid', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByIdDb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idDb', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByIdDbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idDb', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByPir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pir', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByPirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pir', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByR() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'r', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByRDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'r', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByW() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'w', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByWDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'w', Sort.desc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'y', Sort.asc);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QAfterSortBy> thenByYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'y', Sort.desc);
    });
  }
}

extension IsarCommandQueryWhereDistinct
    on QueryBuilder<IsarCommand, IsarCommand, QDistinct> {
  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByB() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'b');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByC() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'c');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByG() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'g');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByGid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gid');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByLampsIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lampsIds');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByPir() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pir');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByR() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'r');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByW() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'w');
    });
  }

  QueryBuilder<IsarCommand, IsarCommand, QDistinct> distinctByY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'y');
    });
  }
}

extension IsarCommandQueryProperty
    on QueryBuilder<IsarCommand, IsarCommand, QQueryProperty> {
  QueryBuilder<IsarCommand, int, QQueryOperations> idDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idDb');
    });
  }

  QueryBuilder<IsarCommand, int?, QQueryOperations> bProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'b');
    });
  }

  QueryBuilder<IsarCommand, int?, QQueryOperations> cProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'c');
    });
  }

  QueryBuilder<IsarCommand, int?, QQueryOperations> gProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'g');
    });
  }

  QueryBuilder<IsarCommand, int?, QQueryOperations> gidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gid');
    });
  }

  QueryBuilder<IsarCommand, List<int>?, QQueryOperations> lampsIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lampsIds');
    });
  }

  QueryBuilder<IsarCommand, bool?, QQueryOperations> pirProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pir');
    });
  }

  QueryBuilder<IsarCommand, int?, QQueryOperations> rProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'r');
    });
  }

  QueryBuilder<IsarCommand, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<IsarCommand, int?, QQueryOperations> wProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'w');
    });
  }

  QueryBuilder<IsarCommand, int?, QQueryOperations> yProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'y');
    });
  }
}
