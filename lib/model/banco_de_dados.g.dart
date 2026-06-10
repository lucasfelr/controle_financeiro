// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banco_de_dados.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGrupoCollection on Isar {
  IsarCollection<Grupo> get grupos => this.collection();
}

const GrupoSchema = CollectionSchema(
  name: r'Grupo',
  id: -6897321016875927792,
  properties: {
    r'nome': PropertySchema(
      id: 0,
      name: r'nome',
      type: IsarType.string,
    )
  },
  estimateSize: _grupoEstimateSize,
  serialize: _grupoSerialize,
  deserialize: _grupoDeserialize,
  deserializeProp: _grupoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _grupoGetId,
  getLinks: _grupoGetLinks,
  attach: _grupoAttach,
  version: '3.1.0+1',
);

int _grupoEstimateSize(
  Grupo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nome.length * 3;
  return bytesCount;
}

void _grupoSerialize(
  Grupo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.nome);
}

Grupo _grupoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Grupo();
  object.id = id;
  object.nome = reader.readString(offsets[0]);
  return object;
}

P _grupoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _grupoGetId(Grupo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _grupoGetLinks(Grupo object) {
  return [];
}

void _grupoAttach(IsarCollection<dynamic> col, Id id, Grupo object) {
  object.id = id;
}

extension GrupoQueryWhereSort on QueryBuilder<Grupo, Grupo, QWhere> {
  QueryBuilder<Grupo, Grupo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GrupoQueryWhere on QueryBuilder<Grupo, Grupo, QWhereClause> {
  QueryBuilder<Grupo, Grupo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Grupo, Grupo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterWhereClause> idBetween(
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

extension GrupoQueryFilter on QueryBuilder<Grupo, Grupo, QFilterCondition> {
  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }
}

extension GrupoQueryObject on QueryBuilder<Grupo, Grupo, QFilterCondition> {}

extension GrupoQueryLinks on QueryBuilder<Grupo, Grupo, QFilterCondition> {}

extension GrupoQuerySortBy on QueryBuilder<Grupo, Grupo, QSortBy> {
  QueryBuilder<Grupo, Grupo, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }
}

extension GrupoQuerySortThenBy on QueryBuilder<Grupo, Grupo, QSortThenBy> {
  QueryBuilder<Grupo, Grupo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Grupo, Grupo, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }
}

extension GrupoQueryWhereDistinct on QueryBuilder<Grupo, Grupo, QDistinct> {
  QueryBuilder<Grupo, Grupo, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }
}

extension GrupoQueryProperty on QueryBuilder<Grupo, Grupo, QQueryProperty> {
  QueryBuilder<Grupo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Grupo, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContaCollection on Isar {
  IsarCollection<Conta> get contas => this.collection();
}

const ContaSchema = CollectionSchema(
  name: r'Conta',
  id: 3292761929756097250,
  properties: {
    r'grupoId': PropertySchema(
      id: 0,
      name: r'grupoId',
      type: IsarType.long,
    ),
    r'isCredito': PropertySchema(
      id: 1,
      name: r'isCredito',
      type: IsarType.bool,
    ),
    r'limiteCredito': PropertySchema(
      id: 2,
      name: r'limiteCredito',
      type: IsarType.double,
    ),
    r'nome': PropertySchema(
      id: 3,
      name: r'nome',
      type: IsarType.string,
    ),
    r'saldoInicial': PropertySchema(
      id: 4,
      name: r'saldoInicial',
      type: IsarType.double,
    )
  },
  estimateSize: _contaEstimateSize,
  serialize: _contaSerialize,
  deserialize: _contaDeserialize,
  deserializeProp: _contaDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _contaGetId,
  getLinks: _contaGetLinks,
  attach: _contaAttach,
  version: '3.1.0+1',
);

int _contaEstimateSize(
  Conta object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nome.length * 3;
  return bytesCount;
}

void _contaSerialize(
  Conta object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.grupoId);
  writer.writeBool(offsets[1], object.isCredito);
  writer.writeDouble(offsets[2], object.limiteCredito);
  writer.writeString(offsets[3], object.nome);
  writer.writeDouble(offsets[4], object.saldoInicial);
}

Conta _contaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Conta();
  object.grupoId = reader.readLong(offsets[0]);
  object.id = id;
  object.isCredito = reader.readBool(offsets[1]);
  object.limiteCredito = reader.readDoubleOrNull(offsets[2]);
  object.nome = reader.readString(offsets[3]);
  object.saldoInicial = reader.readDouble(offsets[4]);
  return object;
}

P _contaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _contaGetId(Conta object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _contaGetLinks(Conta object) {
  return [];
}

void _contaAttach(IsarCollection<dynamic> col, Id id, Conta object) {
  object.id = id;
}

extension ContaQueryWhereSort on QueryBuilder<Conta, Conta, QWhere> {
  QueryBuilder<Conta, Conta, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ContaQueryWhere on QueryBuilder<Conta, Conta, QWhereClause> {
  QueryBuilder<Conta, Conta, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Conta, Conta, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Conta, Conta, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Conta, Conta, QAfterWhereClause> idBetween(
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

extension ContaQueryFilter on QueryBuilder<Conta, Conta, QFilterCondition> {
  QueryBuilder<Conta, Conta, QAfterFilterCondition> grupoIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grupoId',
        value: value,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> grupoIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grupoId',
        value: value,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> grupoIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grupoId',
        value: value,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> grupoIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grupoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Conta, Conta, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Conta, Conta, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Conta, Conta, QAfterFilterCondition> isCreditoEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCredito',
        value: value,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> limiteCreditoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'limiteCredito',
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> limiteCreditoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'limiteCredito',
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> limiteCreditoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'limiteCredito',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> limiteCreditoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'limiteCredito',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> limiteCreditoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'limiteCredito',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> limiteCreditoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'limiteCredito',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> saldoInicialEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'saldoInicial',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> saldoInicialGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'saldoInicial',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> saldoInicialLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'saldoInicial',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Conta, Conta, QAfterFilterCondition> saldoInicialBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'saldoInicial',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ContaQueryObject on QueryBuilder<Conta, Conta, QFilterCondition> {}

extension ContaQueryLinks on QueryBuilder<Conta, Conta, QFilterCondition> {}

extension ContaQuerySortBy on QueryBuilder<Conta, Conta, QSortBy> {
  QueryBuilder<Conta, Conta, QAfterSortBy> sortByGrupoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupoId', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> sortByGrupoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupoId', Sort.desc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> sortByIsCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCredito', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> sortByIsCreditoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCredito', Sort.desc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> sortByLimiteCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limiteCredito', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> sortByLimiteCreditoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limiteCredito', Sort.desc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> sortBySaldoInicial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoInicial', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> sortBySaldoInicialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoInicial', Sort.desc);
    });
  }
}

extension ContaQuerySortThenBy on QueryBuilder<Conta, Conta, QSortThenBy> {
  QueryBuilder<Conta, Conta, QAfterSortBy> thenByGrupoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupoId', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenByGrupoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grupoId', Sort.desc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenByIsCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCredito', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenByIsCreditoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCredito', Sort.desc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenByLimiteCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limiteCredito', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenByLimiteCreditoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limiteCredito', Sort.desc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenBySaldoInicial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoInicial', Sort.asc);
    });
  }

  QueryBuilder<Conta, Conta, QAfterSortBy> thenBySaldoInicialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'saldoInicial', Sort.desc);
    });
  }
}

extension ContaQueryWhereDistinct on QueryBuilder<Conta, Conta, QDistinct> {
  QueryBuilder<Conta, Conta, QDistinct> distinctByGrupoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grupoId');
    });
  }

  QueryBuilder<Conta, Conta, QDistinct> distinctByIsCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCredito');
    });
  }

  QueryBuilder<Conta, Conta, QDistinct> distinctByLimiteCredito() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'limiteCredito');
    });
  }

  QueryBuilder<Conta, Conta, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Conta, Conta, QDistinct> distinctBySaldoInicial() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'saldoInicial');
    });
  }
}

extension ContaQueryProperty on QueryBuilder<Conta, Conta, QQueryProperty> {
  QueryBuilder<Conta, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Conta, int, QQueryOperations> grupoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grupoId');
    });
  }

  QueryBuilder<Conta, bool, QQueryOperations> isCreditoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCredito');
    });
  }

  QueryBuilder<Conta, double?, QQueryOperations> limiteCreditoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'limiteCredito');
    });
  }

  QueryBuilder<Conta, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<Conta, double, QQueryOperations> saldoInicialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saldoInicial');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransacaoCollection on Isar {
  IsarCollection<Transacao> get transacaos => this.collection();
}

const TransacaoSchema = CollectionSchema(
  name: r'Transacao',
  id: -4675131500292607103,
  properties: {
    r'contaId': PropertySchema(
      id: 0,
      name: r'contaId',
      type: IsarType.long,
    ),
    r'data': PropertySchema(
      id: 1,
      name: r'data',
      type: IsarType.dateTime,
    ),
    r'isParcelada': PropertySchema(
      id: 2,
      name: r'isParcelada',
      type: IsarType.bool,
    ),
    r'nome': PropertySchema(
      id: 3,
      name: r'nome',
      type: IsarType.string,
    ),
    r'parcelaAtual': PropertySchema(
      id: 4,
      name: r'parcelaAtual',
      type: IsarType.long,
    ),
    r'tag': PropertySchema(
      id: 5,
      name: r'tag',
      type: IsarType.string,
    ),
    r'tipo': PropertySchema(
      id: 6,
      name: r'tipo',
      type: IsarType.byte,
      enumMap: _TransacaotipoEnumValueMap,
    ),
    r'totalParcelas': PropertySchema(
      id: 7,
      name: r'totalParcelas',
      type: IsarType.long,
    ),
    r'valor': PropertySchema(
      id: 8,
      name: r'valor',
      type: IsarType.double,
    )
  },
  estimateSize: _transacaoEstimateSize,
  serialize: _transacaoSerialize,
  deserialize: _transacaoDeserialize,
  deserializeProp: _transacaoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _transacaoGetId,
  getLinks: _transacaoGetLinks,
  attach: _transacaoAttach,
  version: '3.1.0+1',
);

int _transacaoEstimateSize(
  Transacao object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nome.length * 3;
  bytesCount += 3 + object.tag.length * 3;
  return bytesCount;
}

void _transacaoSerialize(
  Transacao object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.contaId);
  writer.writeDateTime(offsets[1], object.data);
  writer.writeBool(offsets[2], object.isParcelada);
  writer.writeString(offsets[3], object.nome);
  writer.writeLong(offsets[4], object.parcelaAtual);
  writer.writeString(offsets[5], object.tag);
  writer.writeByte(offsets[6], object.tipo.index);
  writer.writeLong(offsets[7], object.totalParcelas);
  writer.writeDouble(offsets[8], object.valor);
}

Transacao _transacaoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Transacao();
  object.contaId = reader.readLong(offsets[0]);
  object.data = reader.readDateTime(offsets[1]);
  object.id = id;
  object.isParcelada = reader.readBool(offsets[2]);
  object.nome = reader.readString(offsets[3]);
  object.parcelaAtual = reader.readLong(offsets[4]);
  object.tag = reader.readString(offsets[5]);
  object.tipo = _TransacaotipoValueEnumMap[reader.readByteOrNull(offsets[6])] ??
      TipoTransacao.deposito;
  object.totalParcelas = reader.readLong(offsets[7]);
  object.valor = reader.readDouble(offsets[8]);
  return object;
}

P _transacaoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (_TransacaotipoValueEnumMap[reader.readByteOrNull(offset)] ??
          TipoTransacao.deposito) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TransacaotipoEnumValueMap = {
  'deposito': 0,
  'gasto': 1,
};
const _TransacaotipoValueEnumMap = {
  0: TipoTransacao.deposito,
  1: TipoTransacao.gasto,
};

Id _transacaoGetId(Transacao object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transacaoGetLinks(Transacao object) {
  return [];
}

void _transacaoAttach(IsarCollection<dynamic> col, Id id, Transacao object) {
  object.id = id;
}

extension TransacaoQueryWhereSort
    on QueryBuilder<Transacao, Transacao, QWhere> {
  QueryBuilder<Transacao, Transacao, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransacaoQueryWhere
    on QueryBuilder<Transacao, Transacao, QWhereClause> {
  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterWhereClause> idBetween(
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

extension TransacaoQueryFilter
    on QueryBuilder<Transacao, Transacao, QFilterCondition> {
  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> contaIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contaId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> contaIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contaId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> contaIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contaId',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> contaIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> dataEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> dataGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'data',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> dataLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'data',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> dataBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'data',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> isParceladaEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isParcelada',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> parcelaAtualEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parcelaAtual',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      parcelaAtualGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parcelaAtual',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      parcelaAtualLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parcelaAtual',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> parcelaAtualBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parcelaAtual',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tag',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tag',
        value: '',
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tipoEqualTo(
      TipoTransacao value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tipoGreaterThan(
    TipoTransacao value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipo',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tipoLessThan(
    TipoTransacao value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipo',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> tipoBetween(
    TipoTransacao lower,
    TipoTransacao upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      totalParcelasEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalParcelas',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      totalParcelasGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalParcelas',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      totalParcelasLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalParcelas',
        value: value,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition>
      totalParcelasBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalParcelas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> valorEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> valorGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> valorLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterFilterCondition> valorBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension TransacaoQueryObject
    on QueryBuilder<Transacao, Transacao, QFilterCondition> {}

extension TransacaoQueryLinks
    on QueryBuilder<Transacao, Transacao, QFilterCondition> {}

extension TransacaoQuerySortBy on QueryBuilder<Transacao, Transacao, QSortBy> {
  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByContaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contaId', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByContaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contaId', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByIsParcelada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isParcelada', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByIsParceladaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isParcelada', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByParcelaAtual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelaAtual', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByParcelaAtualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelaAtual', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByTotalParcelas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalParcelas', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByTotalParcelasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalParcelas', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> sortByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }
}

extension TransacaoQuerySortThenBy
    on QueryBuilder<Transacao, Transacao, QSortThenBy> {
  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByContaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contaId', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByContaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contaId', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByIsParcelada() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isParcelada', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByIsParceladaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isParcelada', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByParcelaAtual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelaAtual', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByParcelaAtualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelaAtual', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByTotalParcelas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalParcelas', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByTotalParcelasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalParcelas', Sort.desc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.asc);
    });
  }

  QueryBuilder<Transacao, Transacao, QAfterSortBy> thenByValorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valor', Sort.desc);
    });
  }
}

extension TransacaoQueryWhereDistinct
    on QueryBuilder<Transacao, Transacao, QDistinct> {
  QueryBuilder<Transacao, Transacao, QDistinct> distinctByContaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contaId');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByIsParcelada() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isParcelada');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByParcelaAtual() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parcelaAtual');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByTag(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tag', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipo');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByTotalParcelas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalParcelas');
    });
  }

  QueryBuilder<Transacao, Transacao, QDistinct> distinctByValor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valor');
    });
  }
}

extension TransacaoQueryProperty
    on QueryBuilder<Transacao, Transacao, QQueryProperty> {
  QueryBuilder<Transacao, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Transacao, int, QQueryOperations> contaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contaId');
    });
  }

  QueryBuilder<Transacao, DateTime, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<Transacao, bool, QQueryOperations> isParceladaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isParcelada');
    });
  }

  QueryBuilder<Transacao, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<Transacao, int, QQueryOperations> parcelaAtualProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parcelaAtual');
    });
  }

  QueryBuilder<Transacao, String, QQueryOperations> tagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tag');
    });
  }

  QueryBuilder<Transacao, TipoTransacao, QQueryOperations> tipoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipo');
    });
  }

  QueryBuilder<Transacao, int, QQueryOperations> totalParcelasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalParcelas');
    });
  }

  QueryBuilder<Transacao, double, QQueryOperations> valorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valor');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRelatorioSalvoCollection on Isar {
  IsarCollection<RelatorioSalvo> get relatorioSalvos => this.collection();
}

const RelatorioSalvoSchema = CollectionSchema(
  name: r'RelatorioSalvo',
  id: 1561549913388615339,
  properties: {
    r'dataCriacao': PropertySchema(
      id: 0,
      name: r'dataCriacao',
      type: IsarType.dateTime,
    ),
    r'dataFinal': PropertySchema(
      id: 1,
      name: r'dataFinal',
      type: IsarType.dateTime,
    ),
    r'dataInicial': PropertySchema(
      id: 2,
      name: r'dataInicial',
      type: IsarType.dateTime,
    ),
    r'gastoTotal': PropertySchema(
      id: 3,
      name: r'gastoTotal',
      type: IsarType.double,
    ),
    r'nome': PropertySchema(
      id: 4,
      name: r'nome',
      type: IsarType.string,
    ),
    r'tagsNomes': PropertySchema(
      id: 5,
      name: r'tagsNomes',
      type: IsarType.stringList,
    ),
    r'tagsValores': PropertySchema(
      id: 6,
      name: r'tagsValores',
      type: IsarType.doubleList,
    )
  },
  estimateSize: _relatorioSalvoEstimateSize,
  serialize: _relatorioSalvoSerialize,
  deserialize: _relatorioSalvoDeserialize,
  deserializeProp: _relatorioSalvoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _relatorioSalvoGetId,
  getLinks: _relatorioSalvoGetLinks,
  attach: _relatorioSalvoAttach,
  version: '3.1.0+1',
);

int _relatorioSalvoEstimateSize(
  RelatorioSalvo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nome.length * 3;
  bytesCount += 3 + object.tagsNomes.length * 3;
  {
    for (var i = 0; i < object.tagsNomes.length; i++) {
      final value = object.tagsNomes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.tagsValores.length * 8;
  return bytesCount;
}

void _relatorioSalvoSerialize(
  RelatorioSalvo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dataCriacao);
  writer.writeDateTime(offsets[1], object.dataFinal);
  writer.writeDateTime(offsets[2], object.dataInicial);
  writer.writeDouble(offsets[3], object.gastoTotal);
  writer.writeString(offsets[4], object.nome);
  writer.writeStringList(offsets[5], object.tagsNomes);
  writer.writeDoubleList(offsets[6], object.tagsValores);
}

RelatorioSalvo _relatorioSalvoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RelatorioSalvo();
  object.dataCriacao = reader.readDateTime(offsets[0]);
  object.dataFinal = reader.readDateTimeOrNull(offsets[1]);
  object.dataInicial = reader.readDateTimeOrNull(offsets[2]);
  object.gastoTotal = reader.readDouble(offsets[3]);
  object.id = id;
  object.nome = reader.readString(offsets[4]);
  object.tagsNomes = reader.readStringList(offsets[5]) ?? [];
  object.tagsValores = reader.readDoubleList(offsets[6]) ?? [];
  return object;
}

P _relatorioSalvoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readDoubleList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _relatorioSalvoGetId(RelatorioSalvo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _relatorioSalvoGetLinks(RelatorioSalvo object) {
  return [];
}

void _relatorioSalvoAttach(
    IsarCollection<dynamic> col, Id id, RelatorioSalvo object) {
  object.id = id;
}

extension RelatorioSalvoQueryWhereSort
    on QueryBuilder<RelatorioSalvo, RelatorioSalvo, QWhere> {
  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RelatorioSalvoQueryWhere
    on QueryBuilder<RelatorioSalvo, RelatorioSalvo, QWhereClause> {
  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterWhereClause> idBetween(
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

extension RelatorioSalvoQueryFilter
    on QueryBuilder<RelatorioSalvo, RelatorioSalvo, QFilterCondition> {
  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataCriacaoEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataCriacaoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataCriacaoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataCriacaoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataCriacao',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataFinalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataFinal',
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataFinalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataFinal',
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataFinalEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataFinal',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataFinalGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataFinal',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataFinalLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataFinal',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataFinalBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataFinal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataInicialIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataInicial',
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataInicialIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataInicial',
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataInicialEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataInicial',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataInicialGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataInicial',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataInicialLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataInicial',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      dataInicialBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataInicial',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      gastoTotalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gastoTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      gastoTotalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gastoTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      gastoTotalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gastoTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      gastoTotalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gastoTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
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

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
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

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagsNomes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagsNomes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagsNomes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagsNomes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagsNomes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagsNomes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagsNomes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagsNomes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagsNomes',
        value: '',
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagsNomes',
        value: '',
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsNomes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsNomes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsNomes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsNomes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsNomes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsNomesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsNomes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagsValores',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagsValores',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagsValores',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagsValores',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsValores',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsValores',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsValores',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsValores',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsValores',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterFilterCondition>
      tagsValoresLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagsValores',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension RelatorioSalvoQueryObject
    on QueryBuilder<RelatorioSalvo, RelatorioSalvo, QFilterCondition> {}

extension RelatorioSalvoQueryLinks
    on QueryBuilder<RelatorioSalvo, RelatorioSalvo, QFilterCondition> {}

extension RelatorioSalvoQuerySortBy
    on QueryBuilder<RelatorioSalvo, RelatorioSalvo, QSortBy> {
  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      sortByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      sortByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy> sortByDataFinal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataFinal', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      sortByDataFinalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataFinal', Sort.desc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      sortByDataInicial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataInicial', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      sortByDataInicialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataInicial', Sort.desc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      sortByGastoTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gastoTotal', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      sortByGastoTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gastoTotal', Sort.desc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }
}

extension RelatorioSalvoQuerySortThenBy
    on QueryBuilder<RelatorioSalvo, RelatorioSalvo, QSortThenBy> {
  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      thenByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      thenByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy> thenByDataFinal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataFinal', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      thenByDataFinalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataFinal', Sort.desc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      thenByDataInicial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataInicial', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      thenByDataInicialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataInicial', Sort.desc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      thenByGastoTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gastoTotal', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy>
      thenByGastoTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gastoTotal', Sort.desc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }
}

extension RelatorioSalvoQueryWhereDistinct
    on QueryBuilder<RelatorioSalvo, RelatorioSalvo, QDistinct> {
  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QDistinct>
      distinctByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataCriacao');
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QDistinct>
      distinctByDataFinal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataFinal');
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QDistinct>
      distinctByDataInicial() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataInicial');
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QDistinct>
      distinctByGastoTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gastoTotal');
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QDistinct>
      distinctByTagsNomes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagsNomes');
    });
  }

  QueryBuilder<RelatorioSalvo, RelatorioSalvo, QDistinct>
      distinctByTagsValores() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagsValores');
    });
  }
}

extension RelatorioSalvoQueryProperty
    on QueryBuilder<RelatorioSalvo, RelatorioSalvo, QQueryProperty> {
  QueryBuilder<RelatorioSalvo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RelatorioSalvo, DateTime, QQueryOperations>
      dataCriacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataCriacao');
    });
  }

  QueryBuilder<RelatorioSalvo, DateTime?, QQueryOperations>
      dataFinalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataFinal');
    });
  }

  QueryBuilder<RelatorioSalvo, DateTime?, QQueryOperations>
      dataInicialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataInicial');
    });
  }

  QueryBuilder<RelatorioSalvo, double, QQueryOperations> gastoTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gastoTotal');
    });
  }

  QueryBuilder<RelatorioSalvo, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<RelatorioSalvo, List<String>, QQueryOperations>
      tagsNomesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagsNomes');
    });
  }

  QueryBuilder<RelatorioSalvo, List<double>, QQueryOperations>
      tagsValoresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagsValores');
    });
  }
}
