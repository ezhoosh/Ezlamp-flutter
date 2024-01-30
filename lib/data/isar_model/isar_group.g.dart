// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_group.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarGroupCollection on Isar {
  IsarCollection<IsarGroup> get isarGroups => this.collection();
}

const IsarGroupSchema = CollectionSchema(
  name: r'IsarGroup',
  id: -249249756886492951,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _isarGroupEstimateSize,
  serialize: _isarGroupSerialize,
  deserialize: _isarGroupDeserialize,
  deserializeProp: _isarGroupDeserializeProp,
  idName: r'idDb',
  indexes: {},
  links: {
    r'owner': LinkSchema(
      id: -5259202259244068613,
      name: r'owner',
      target: r'IsarOwner',
      single: true,
    ),
    r'lamps': LinkSchema(
      id: 2579652246558123846,
      name: r'lamps',
      target: r'IsarLamp',
      single: false,
      linkName: r'group',
    ),
    r'command': LinkSchema(
      id: 295816511362452783,
      name: r'command',
      target: r'IsarCommand',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _isarGroupGetId,
  getLinks: _isarGroupGetLinks,
  attach: _isarGroupAttach,
  version: '3.1.0+1',
);

int _isarGroupEstimateSize(
  IsarGroup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarGroupSerialize(
  IsarGroup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeLong(offsets[1], object.id);
  writer.writeString(offsets[2], object.name);
}

IsarGroup _isarGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarGroup(
    description: reader.readStringOrNull(offsets[0]),
    id: reader.readLongOrNull(offsets[1]),
    name: reader.readStringOrNull(offsets[2]),
  );
  object.idDb = id;
  return object;
}

P _isarGroupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarGroupGetId(IsarGroup object) {
  return object.idDb;
}

List<IsarLinkBase<dynamic>> _isarGroupGetLinks(IsarGroup object) {
  return [object.owner, object.lamps, object.command];
}

void _isarGroupAttach(IsarCollection<dynamic> col, Id id, IsarGroup object) {
  object.idDb = id;
  object.owner.attach(col, col.isar.collection<IsarOwner>(), r'owner', id);
  object.lamps.attach(col, col.isar.collection<IsarLamp>(), r'lamps', id);
  object.command
      .attach(col, col.isar.collection<IsarCommand>(), r'command', id);
}

extension IsarGroupQueryWhereSort
    on QueryBuilder<IsarGroup, IsarGroup, QWhere> {
  QueryBuilder<IsarGroup, IsarGroup, QAfterWhere> anyIdDb() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarGroupQueryWhere
    on QueryBuilder<IsarGroup, IsarGroup, QWhereClause> {
  QueryBuilder<IsarGroup, IsarGroup, QAfterWhereClause> idDbEqualTo(Id idDb) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idDb,
        upper: idDb,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterWhereClause> idDbNotEqualTo(
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterWhereClause> idDbGreaterThan(Id idDb,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idDb, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterWhereClause> idDbLessThan(Id idDb,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idDb, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterWhereClause> idDbBetween(
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

extension IsarGroupQueryFilter
    on QueryBuilder<IsarGroup, IsarGroup, QFilterCondition> {
  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idGreaterThan(
    int? value, {
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idLessThan(
    int? value, {
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idDbEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idDb',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idDbGreaterThan(
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idDbLessThan(
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> idDbBetween(
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameEqualTo(
    String? value, {
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameGreaterThan(
    String? value, {
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameLessThan(
    String? value, {
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension IsarGroupQueryObject
    on QueryBuilder<IsarGroup, IsarGroup, QFilterCondition> {}

extension IsarGroupQueryLinks
    on QueryBuilder<IsarGroup, IsarGroup, QFilterCondition> {
  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> owner(
      FilterQuery<IsarOwner> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'owner');
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> ownerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'owner', 0, true, 0, true);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> lamps(
      FilterQuery<IsarLamp> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'lamps');
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> lampsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamps', length, true, length, true);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> lampsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamps', 0, true, 0, true);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> lampsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamps', 0, false, 999999, true);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> lampsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamps', 0, true, length, include);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition>
      lampsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'lamps', length, include, 999999, true);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> lampsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'lamps', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> command(
      FilterQuery<IsarCommand> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'command');
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterFilterCondition> commandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'command', 0, true, 0, true);
    });
  }
}

extension IsarGroupQuerySortBy on QueryBuilder<IsarGroup, IsarGroup, QSortBy> {
  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension IsarGroupQuerySortThenBy
    on QueryBuilder<IsarGroup, IsarGroup, QSortThenBy> {
  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> thenByIdDb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idDb', Sort.asc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> thenByIdDbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idDb', Sort.desc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension IsarGroupQueryWhereDistinct
    on QueryBuilder<IsarGroup, IsarGroup, QDistinct> {
  QueryBuilder<IsarGroup, IsarGroup, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QDistinct> distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<IsarGroup, IsarGroup, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension IsarGroupQueryProperty
    on QueryBuilder<IsarGroup, IsarGroup, QQueryProperty> {
  QueryBuilder<IsarGroup, int, QQueryOperations> idDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idDb');
    });
  }

  QueryBuilder<IsarGroup, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<IsarGroup, int?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarGroup, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
