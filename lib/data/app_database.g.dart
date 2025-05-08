// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PidCatalogTable extends PidCatalog
    with TableInfo<$PidCatalogTable, PidCatalogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PidCatalogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
      'mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pidMeta = const VerificationMeta('pid');
  @override
  late final GeneratedColumn<String> pid = GeneratedColumn<String>(
      'pid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _minValueMeta =
      const VerificationMeta('minValue');
  @override
  late final GeneratedColumn<double> minValue = GeneratedColumn<double>(
      'min_value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _maxValueMeta =
      const VerificationMeta('maxValue');
  @override
  late final GeneratedColumn<double> maxValue = GeneratedColumn<double>(
      'max_value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, mode, pid, description, minValue, maxValue, unit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pid_catalog';
  @override
  VerificationContext validateIntegrity(Insertable<PidCatalogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('pid')) {
      context.handle(
          _pidMeta, pid.isAcceptableOrUnknown(data['pid']!, _pidMeta));
    } else if (isInserting) {
      context.missing(_pidMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('min_value')) {
      context.handle(_minValueMeta,
          minValue.isAcceptableOrUnknown(data['min_value']!, _minValueMeta));
    }
    if (data.containsKey('max_value')) {
      context.handle(_maxValueMeta,
          maxValue.isAcceptableOrUnknown(data['max_value']!, _maxValueMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PidCatalogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PidCatalogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mode'])!,
      pid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pid'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      minValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}min_value']),
      maxValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}max_value']),
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
    );
  }

  @override
  $PidCatalogTable createAlias(String alias) {
    return $PidCatalogTable(attachedDatabase, alias);
  }
}

class PidCatalogData extends DataClass implements Insertable<PidCatalogData> {
  final int id;
  final String mode;
  final String pid;
  final String description;
  final double? minValue;
  final double? maxValue;
  final String? unit;
  const PidCatalogData(
      {required this.id,
      required this.mode,
      required this.pid,
      required this.description,
      this.minValue,
      this.maxValue,
      this.unit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mode'] = Variable<String>(mode);
    map['pid'] = Variable<String>(pid);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || minValue != null) {
      map['min_value'] = Variable<double>(minValue);
    }
    if (!nullToAbsent || maxValue != null) {
      map['max_value'] = Variable<double>(maxValue);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    return map;
  }

  PidCatalogCompanion toCompanion(bool nullToAbsent) {
    return PidCatalogCompanion(
      id: Value(id),
      mode: Value(mode),
      pid: Value(pid),
      description: Value(description),
      minValue: minValue == null && nullToAbsent
          ? const Value.absent()
          : Value(minValue),
      maxValue: maxValue == null && nullToAbsent
          ? const Value.absent()
          : Value(maxValue),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
    );
  }

  factory PidCatalogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PidCatalogData(
      id: serializer.fromJson<int>(json['id']),
      mode: serializer.fromJson<String>(json['mode']),
      pid: serializer.fromJson<String>(json['pid']),
      description: serializer.fromJson<String>(json['description']),
      minValue: serializer.fromJson<double?>(json['minValue']),
      maxValue: serializer.fromJson<double?>(json['maxValue']),
      unit: serializer.fromJson<String?>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mode': serializer.toJson<String>(mode),
      'pid': serializer.toJson<String>(pid),
      'description': serializer.toJson<String>(description),
      'minValue': serializer.toJson<double?>(minValue),
      'maxValue': serializer.toJson<double?>(maxValue),
      'unit': serializer.toJson<String?>(unit),
    };
  }

  PidCatalogData copyWith(
          {int? id,
          String? mode,
          String? pid,
          String? description,
          Value<double?> minValue = const Value.absent(),
          Value<double?> maxValue = const Value.absent(),
          Value<String?> unit = const Value.absent()}) =>
      PidCatalogData(
        id: id ?? this.id,
        mode: mode ?? this.mode,
        pid: pid ?? this.pid,
        description: description ?? this.description,
        minValue: minValue.present ? minValue.value : this.minValue,
        maxValue: maxValue.present ? maxValue.value : this.maxValue,
        unit: unit.present ? unit.value : this.unit,
      );
  PidCatalogData copyWithCompanion(PidCatalogCompanion data) {
    return PidCatalogData(
      id: data.id.present ? data.id.value : this.id,
      mode: data.mode.present ? data.mode.value : this.mode,
      pid: data.pid.present ? data.pid.value : this.pid,
      description:
          data.description.present ? data.description.value : this.description,
      minValue: data.minValue.present ? data.minValue.value : this.minValue,
      maxValue: data.maxValue.present ? data.maxValue.value : this.maxValue,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PidCatalogData(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('pid: $pid, ')
          ..write('description: $description, ')
          ..write('minValue: $minValue, ')
          ..write('maxValue: $maxValue, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, mode, pid, description, minValue, maxValue, unit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PidCatalogData &&
          other.id == this.id &&
          other.mode == this.mode &&
          other.pid == this.pid &&
          other.description == this.description &&
          other.minValue == this.minValue &&
          other.maxValue == this.maxValue &&
          other.unit == this.unit);
}

class PidCatalogCompanion extends UpdateCompanion<PidCatalogData> {
  final Value<int> id;
  final Value<String> mode;
  final Value<String> pid;
  final Value<String> description;
  final Value<double?> minValue;
  final Value<double?> maxValue;
  final Value<String?> unit;
  const PidCatalogCompanion({
    this.id = const Value.absent(),
    this.mode = const Value.absent(),
    this.pid = const Value.absent(),
    this.description = const Value.absent(),
    this.minValue = const Value.absent(),
    this.maxValue = const Value.absent(),
    this.unit = const Value.absent(),
  });
  PidCatalogCompanion.insert({
    this.id = const Value.absent(),
    required String mode,
    required String pid,
    required String description,
    this.minValue = const Value.absent(),
    this.maxValue = const Value.absent(),
    this.unit = const Value.absent(),
  })  : mode = Value(mode),
        pid = Value(pid),
        description = Value(description);
  static Insertable<PidCatalogData> custom({
    Expression<int>? id,
    Expression<String>? mode,
    Expression<String>? pid,
    Expression<String>? description,
    Expression<double>? minValue,
    Expression<double>? maxValue,
    Expression<String>? unit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mode != null) 'mode': mode,
      if (pid != null) 'pid': pid,
      if (description != null) 'description': description,
      if (minValue != null) 'min_value': minValue,
      if (maxValue != null) 'max_value': maxValue,
      if (unit != null) 'unit': unit,
    });
  }

  PidCatalogCompanion copyWith(
      {Value<int>? id,
      Value<String>? mode,
      Value<String>? pid,
      Value<String>? description,
      Value<double?>? minValue,
      Value<double?>? maxValue,
      Value<String?>? unit}) {
    return PidCatalogCompanion(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      pid: pid ?? this.pid,
      description: description ?? this.description,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      unit: unit ?? this.unit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (pid.present) {
      map['pid'] = Variable<String>(pid.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (minValue.present) {
      map['min_value'] = Variable<double>(minValue.value);
    }
    if (maxValue.present) {
      map['max_value'] = Variable<double>(maxValue.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PidCatalogCompanion(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('pid: $pid, ')
          ..write('description: $description, ')
          ..write('minValue: $minValue, ')
          ..write('maxValue: $maxValue, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }
}

class $PidValuesTable extends PidValues
    with TableInfo<$PidValuesTable, PidValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PidValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pidIdMeta = const VerificationMeta('pidId');
  @override
  late final GeneratedColumn<int> pidId = GeneratedColumn<int>(
      'pid_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES pid_catalog(id)');
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _timeStampMeta =
      const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<DateTime> timeStamp = GeneratedColumn<DateTime>(
      'time_stamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, pidId, value, timeStamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pid_values';
  @override
  VerificationContext validateIntegrity(Insertable<PidValue> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pid_id')) {
      context.handle(
          _pidIdMeta, pidId.isAcceptableOrUnknown(data['pid_id']!, _pidIdMeta));
    } else if (isInserting) {
      context.missing(_pidIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PidValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PidValue(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pidId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pid_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      timeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_stamp'])!,
    );
  }

  @override
  $PidValuesTable createAlias(String alias) {
    return $PidValuesTable(attachedDatabase, alias);
  }
}

class PidValue extends DataClass implements Insertable<PidValue> {
  final int id;
  final int pidId;
  final double value;
  final DateTime timeStamp;
  const PidValue(
      {required this.id,
      required this.pidId,
      required this.value,
      required this.timeStamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pid_id'] = Variable<int>(pidId);
    map['value'] = Variable<double>(value);
    map['time_stamp'] = Variable<DateTime>(timeStamp);
    return map;
  }

  PidValuesCompanion toCompanion(bool nullToAbsent) {
    return PidValuesCompanion(
      id: Value(id),
      pidId: Value(pidId),
      value: Value(value),
      timeStamp: Value(timeStamp),
    );
  }

  factory PidValue.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PidValue(
      id: serializer.fromJson<int>(json['id']),
      pidId: serializer.fromJson<int>(json['pidId']),
      value: serializer.fromJson<double>(json['value']),
      timeStamp: serializer.fromJson<DateTime>(json['timeStamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pidId': serializer.toJson<int>(pidId),
      'value': serializer.toJson<double>(value),
      'timeStamp': serializer.toJson<DateTime>(timeStamp),
    };
  }

  PidValue copyWith(
          {int? id, int? pidId, double? value, DateTime? timeStamp}) =>
      PidValue(
        id: id ?? this.id,
        pidId: pidId ?? this.pidId,
        value: value ?? this.value,
        timeStamp: timeStamp ?? this.timeStamp,
      );
  PidValue copyWithCompanion(PidValuesCompanion data) {
    return PidValue(
      id: data.id.present ? data.id.value : this.id,
      pidId: data.pidId.present ? data.pidId.value : this.pidId,
      value: data.value.present ? data.value.value : this.value,
      timeStamp: data.timeStamp.present ? data.timeStamp.value : this.timeStamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PidValue(')
          ..write('id: $id, ')
          ..write('pidId: $pidId, ')
          ..write('value: $value, ')
          ..write('timeStamp: $timeStamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pidId, value, timeStamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PidValue &&
          other.id == this.id &&
          other.pidId == this.pidId &&
          other.value == this.value &&
          other.timeStamp == this.timeStamp);
}

class PidValuesCompanion extends UpdateCompanion<PidValue> {
  final Value<int> id;
  final Value<int> pidId;
  final Value<double> value;
  final Value<DateTime> timeStamp;
  const PidValuesCompanion({
    this.id = const Value.absent(),
    this.pidId = const Value.absent(),
    this.value = const Value.absent(),
    this.timeStamp = const Value.absent(),
  });
  PidValuesCompanion.insert({
    this.id = const Value.absent(),
    required int pidId,
    required double value,
    this.timeStamp = const Value.absent(),
  })  : pidId = Value(pidId),
        value = Value(value);
  static Insertable<PidValue> custom({
    Expression<int>? id,
    Expression<int>? pidId,
    Expression<double>? value,
    Expression<DateTime>? timeStamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pidId != null) 'pid_id': pidId,
      if (value != null) 'value': value,
      if (timeStamp != null) 'time_stamp': timeStamp,
    });
  }

  PidValuesCompanion copyWith(
      {Value<int>? id,
      Value<int>? pidId,
      Value<double>? value,
      Value<DateTime>? timeStamp}) {
    return PidValuesCompanion(
      id: id ?? this.id,
      pidId: pidId ?? this.pidId,
      value: value ?? this.value,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pidId.present) {
      map['pid_id'] = Variable<int>(pidId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (timeStamp.present) {
      map['time_stamp'] = Variable<DateTime>(timeStamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PidValuesCompanion(')
          ..write('id: $id, ')
          ..write('pidId: $pidId, ')
          ..write('value: $value, ')
          ..write('timeStamp: $timeStamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PidCatalogTable pidCatalog = $PidCatalogTable(this);
  late final $PidValuesTable pidValues = $PidValuesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pidCatalog, pidValues];
}

typedef $$PidCatalogTableCreateCompanionBuilder = PidCatalogCompanion Function({
  Value<int> id,
  required String mode,
  required String pid,
  required String description,
  Value<double?> minValue,
  Value<double?> maxValue,
  Value<String?> unit,
});
typedef $$PidCatalogTableUpdateCompanionBuilder = PidCatalogCompanion Function({
  Value<int> id,
  Value<String> mode,
  Value<String> pid,
  Value<String> description,
  Value<double?> minValue,
  Value<double?> maxValue,
  Value<String?> unit,
});

final class $$PidCatalogTableReferences
    extends BaseReferences<_$AppDatabase, $PidCatalogTable, PidCatalogData> {
  $$PidCatalogTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PidValuesTable, List<PidValue>>
      _pidValuesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pidValues,
              aliasName:
                  $_aliasNameGenerator(db.pidCatalog.id, db.pidValues.pidId));

  $$PidValuesTableProcessedTableManager get pidValuesRefs {
    final manager = $$PidValuesTableTableManager($_db, $_db.pidValues)
        .filter((f) => f.pidId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pidValuesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PidCatalogTableFilterComposer
    extends Composer<_$AppDatabase, $PidCatalogTable> {
  $$PidCatalogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mode => $composableBuilder(
      column: $table.mode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pid => $composableBuilder(
      column: $table.pid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minValue => $composableBuilder(
      column: $table.minValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxValue => $composableBuilder(
      column: $table.maxValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  Expression<bool> pidValuesRefs(
      Expression<bool> Function($$PidValuesTableFilterComposer f) f) {
    final $$PidValuesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pidValues,
        getReferencedColumn: (t) => t.pidId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PidValuesTableFilterComposer(
              $db: $db,
              $table: $db.pidValues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PidCatalogTableOrderingComposer
    extends Composer<_$AppDatabase, $PidCatalogTable> {
  $$PidCatalogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mode => $composableBuilder(
      column: $table.mode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pid => $composableBuilder(
      column: $table.pid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minValue => $composableBuilder(
      column: $table.minValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxValue => $composableBuilder(
      column: $table.maxValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));
}

class $$PidCatalogTableAnnotationComposer
    extends Composer<_$AppDatabase, $PidCatalogTable> {
  $$PidCatalogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get pid =>
      $composableBuilder(column: $table.pid, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get minValue =>
      $composableBuilder(column: $table.minValue, builder: (column) => column);

  GeneratedColumn<double> get maxValue =>
      $composableBuilder(column: $table.maxValue, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  Expression<T> pidValuesRefs<T extends Object>(
      Expression<T> Function($$PidValuesTableAnnotationComposer a) f) {
    final $$PidValuesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pidValues,
        getReferencedColumn: (t) => t.pidId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PidValuesTableAnnotationComposer(
              $db: $db,
              $table: $db.pidValues,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PidCatalogTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PidCatalogTable,
    PidCatalogData,
    $$PidCatalogTableFilterComposer,
    $$PidCatalogTableOrderingComposer,
    $$PidCatalogTableAnnotationComposer,
    $$PidCatalogTableCreateCompanionBuilder,
    $$PidCatalogTableUpdateCompanionBuilder,
    (PidCatalogData, $$PidCatalogTableReferences),
    PidCatalogData,
    PrefetchHooks Function({bool pidValuesRefs})> {
  $$PidCatalogTableTableManager(_$AppDatabase db, $PidCatalogTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PidCatalogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PidCatalogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PidCatalogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> mode = const Value.absent(),
            Value<String> pid = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double?> minValue = const Value.absent(),
            Value<double?> maxValue = const Value.absent(),
            Value<String?> unit = const Value.absent(),
          }) =>
              PidCatalogCompanion(
            id: id,
            mode: mode,
            pid: pid,
            description: description,
            minValue: minValue,
            maxValue: maxValue,
            unit: unit,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String mode,
            required String pid,
            required String description,
            Value<double?> minValue = const Value.absent(),
            Value<double?> maxValue = const Value.absent(),
            Value<String?> unit = const Value.absent(),
          }) =>
              PidCatalogCompanion.insert(
            id: id,
            mode: mode,
            pid: pid,
            description: description,
            minValue: minValue,
            maxValue: maxValue,
            unit: unit,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PidCatalogTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pidValuesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pidValuesRefs) db.pidValues],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pidValuesRefs)
                    await $_getPrefetchedData<PidCatalogData, $PidCatalogTable,
                            PidValue>(
                        currentTable: table,
                        referencedTable:
                            $$PidCatalogTableReferences._pidValuesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PidCatalogTableReferences(db, table, p0)
                                .pidValuesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.pidId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PidCatalogTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PidCatalogTable,
    PidCatalogData,
    $$PidCatalogTableFilterComposer,
    $$PidCatalogTableOrderingComposer,
    $$PidCatalogTableAnnotationComposer,
    $$PidCatalogTableCreateCompanionBuilder,
    $$PidCatalogTableUpdateCompanionBuilder,
    (PidCatalogData, $$PidCatalogTableReferences),
    PidCatalogData,
    PrefetchHooks Function({bool pidValuesRefs})>;
typedef $$PidValuesTableCreateCompanionBuilder = PidValuesCompanion Function({
  Value<int> id,
  required int pidId,
  required double value,
  Value<DateTime> timeStamp,
});
typedef $$PidValuesTableUpdateCompanionBuilder = PidValuesCompanion Function({
  Value<int> id,
  Value<int> pidId,
  Value<double> value,
  Value<DateTime> timeStamp,
});

final class $$PidValuesTableReferences
    extends BaseReferences<_$AppDatabase, $PidValuesTable, PidValue> {
  $$PidValuesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PidCatalogTable _pidIdTable(_$AppDatabase db) => db.pidCatalog
      .createAlias($_aliasNameGenerator(db.pidValues.pidId, db.pidCatalog.id));

  $$PidCatalogTableProcessedTableManager get pidId {
    final $_column = $_itemColumn<int>('pid_id')!;

    final manager = $$PidCatalogTableTableManager($_db, $_db.pidCatalog)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pidIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PidValuesTableFilterComposer
    extends Composer<_$AppDatabase, $PidValuesTable> {
  $$PidValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnFilters(column));

  $$PidCatalogTableFilterComposer get pidId {
    final $$PidCatalogTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pidId,
        referencedTable: $db.pidCatalog,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PidCatalogTableFilterComposer(
              $db: $db,
              $table: $db.pidCatalog,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PidValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $PidValuesTable> {
  $$PidValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnOrderings(column));

  $$PidCatalogTableOrderingComposer get pidId {
    final $$PidCatalogTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pidId,
        referencedTable: $db.pidCatalog,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PidCatalogTableOrderingComposer(
              $db: $db,
              $table: $db.pidCatalog,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PidValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PidValuesTable> {
  $$PidValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get timeStamp =>
      $composableBuilder(column: $table.timeStamp, builder: (column) => column);

  $$PidCatalogTableAnnotationComposer get pidId {
    final $$PidCatalogTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pidId,
        referencedTable: $db.pidCatalog,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PidCatalogTableAnnotationComposer(
              $db: $db,
              $table: $db.pidCatalog,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PidValuesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PidValuesTable,
    PidValue,
    $$PidValuesTableFilterComposer,
    $$PidValuesTableOrderingComposer,
    $$PidValuesTableAnnotationComposer,
    $$PidValuesTableCreateCompanionBuilder,
    $$PidValuesTableUpdateCompanionBuilder,
    (PidValue, $$PidValuesTableReferences),
    PidValue,
    PrefetchHooks Function({bool pidId})> {
  $$PidValuesTableTableManager(_$AppDatabase db, $PidValuesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PidValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PidValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PidValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> pidId = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<DateTime> timeStamp = const Value.absent(),
          }) =>
              PidValuesCompanion(
            id: id,
            pidId: pidId,
            value: value,
            timeStamp: timeStamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int pidId,
            required double value,
            Value<DateTime> timeStamp = const Value.absent(),
          }) =>
              PidValuesCompanion.insert(
            id: id,
            pidId: pidId,
            value: value,
            timeStamp: timeStamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PidValuesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pidId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pidId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pidId,
                    referencedTable: $$PidValuesTableReferences._pidIdTable(db),
                    referencedColumn:
                        $$PidValuesTableReferences._pidIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PidValuesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PidValuesTable,
    PidValue,
    $$PidValuesTableFilterComposer,
    $$PidValuesTableOrderingComposer,
    $$PidValuesTableAnnotationComposer,
    $$PidValuesTableCreateCompanionBuilder,
    $$PidValuesTableUpdateCompanionBuilder,
    (PidValue, $$PidValuesTableReferences),
    PidValue,
    PrefetchHooks Function({bool pidId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PidCatalogTableTableManager get pidCatalog =>
      $$PidCatalogTableTableManager(_db, _db.pidCatalog);
  $$PidValuesTableTableManager get pidValues =>
      $$PidValuesTableTableManager(_db, _db.pidValues);
}
