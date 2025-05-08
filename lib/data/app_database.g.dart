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
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
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
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumn<String> units = GeneratedColumn<String>(
      'units', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _formulaMeta =
      const VerificationMeta('formula');
  @override
  late final GeneratedColumn<String> formula = GeneratedColumn<String>(
      'formula', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, mode, pid, description, minValue, maxValue, units, formula];
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
    if (data.containsKey('units')) {
      context.handle(
          _unitsMeta, units.isAcceptableOrUnknown(data['units']!, _unitsMeta));
    }
    if (data.containsKey('formula')) {
      context.handle(_formulaMeta,
          formula.isAcceptableOrUnknown(data['formula']!, _formulaMeta));
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
      units: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}units']),
      formula: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}formula']),
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
  final String? units;
  final String? formula;
  const PidCatalogData(
      {required this.id,
      required this.mode,
      required this.pid,
      required this.description,
      this.minValue,
      this.maxValue,
      this.units,
      this.formula});
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
    if (!nullToAbsent || units != null) {
      map['units'] = Variable<String>(units);
    }
    if (!nullToAbsent || formula != null) {
      map['formula'] = Variable<String>(formula);
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
      units:
          units == null && nullToAbsent ? const Value.absent() : Value(units),
      formula: formula == null && nullToAbsent
          ? const Value.absent()
          : Value(formula),
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
      units: serializer.fromJson<String?>(json['units']),
      formula: serializer.fromJson<String?>(json['formula']),
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
      'units': serializer.toJson<String?>(units),
      'formula': serializer.toJson<String?>(formula),
    };
  }

  PidCatalogData copyWith(
          {int? id,
          String? mode,
          String? pid,
          String? description,
          Value<double?> minValue = const Value.absent(),
          Value<double?> maxValue = const Value.absent(),
          Value<String?> units = const Value.absent(),
          Value<String?> formula = const Value.absent()}) =>
      PidCatalogData(
        id: id ?? this.id,
        mode: mode ?? this.mode,
        pid: pid ?? this.pid,
        description: description ?? this.description,
        minValue: minValue.present ? minValue.value : this.minValue,
        maxValue: maxValue.present ? maxValue.value : this.maxValue,
        units: units.present ? units.value : this.units,
        formula: formula.present ? formula.value : this.formula,
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
      units: data.units.present ? data.units.value : this.units,
      formula: data.formula.present ? data.formula.value : this.formula,
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
          ..write('units: $units, ')
          ..write('formula: $formula')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, mode, pid, description, minValue, maxValue, units, formula);
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
          other.units == this.units &&
          other.formula == this.formula);
}

class PidCatalogCompanion extends UpdateCompanion<PidCatalogData> {
  final Value<int> id;
  final Value<String> mode;
  final Value<String> pid;
  final Value<String> description;
  final Value<double?> minValue;
  final Value<double?> maxValue;
  final Value<String?> units;
  final Value<String?> formula;
  const PidCatalogCompanion({
    this.id = const Value.absent(),
    this.mode = const Value.absent(),
    this.pid = const Value.absent(),
    this.description = const Value.absent(),
    this.minValue = const Value.absent(),
    this.maxValue = const Value.absent(),
    this.units = const Value.absent(),
    this.formula = const Value.absent(),
  });
  PidCatalogCompanion.insert({
    this.id = const Value.absent(),
    required String mode,
    required String pid,
    required String description,
    this.minValue = const Value.absent(),
    this.maxValue = const Value.absent(),
    this.units = const Value.absent(),
    this.formula = const Value.absent(),
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
    Expression<String>? units,
    Expression<String>? formula,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mode != null) 'mode': mode,
      if (pid != null) 'pid': pid,
      if (description != null) 'description': description,
      if (minValue != null) 'min_value': minValue,
      if (maxValue != null) 'max_value': maxValue,
      if (units != null) 'units': units,
      if (formula != null) 'formula': formula,
    });
  }

  PidCatalogCompanion copyWith(
      {Value<int>? id,
      Value<String>? mode,
      Value<String>? pid,
      Value<String>? description,
      Value<double?>? minValue,
      Value<double?>? maxValue,
      Value<String?>? units,
      Value<String?>? formula}) {
    return PidCatalogCompanion(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      pid: pid ?? this.pid,
      description: description ?? this.description,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      units: units ?? this.units,
      formula: formula ?? this.formula,
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
    if (units.present) {
      map['units'] = Variable<String>(units.value);
    }
    if (formula.present) {
      map['formula'] = Variable<String>(formula.value);
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
          ..write('units: $units, ')
          ..write('formula: $formula')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, startedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<Session> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final int id;
  final DateTime startedAt;
  const Session({required this.id, required this.startedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
    );
  }

  factory Session.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<int>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
    };
  }

  Session copyWith({int? id, DateTime? startedAt}) => Session(
        id: id ?? this.id,
        startedAt: startedAt ?? this.startedAt,
      );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.startedAt == this.startedAt);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<int> id;
  final Value<DateTime> startedAt;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
  });
  static Insertable<Session> custom({
    Expression<int>? id,
    Expression<DateTime>? startedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
    });
  }

  SessionsCompanion copyWith({Value<int>? id, Value<DateTime>? startedAt}) {
    return SessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt')
          ..write(')'))
        .toString();
  }
}

class $ReadingsTable extends Readings with TableInfo<$ReadingsTable, Reading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
      'session_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES sessions(id)');
  static const VerificationMeta _pidCatalogIdMeta =
      const VerificationMeta('pidCatalogId');
  @override
  late final GeneratedColumn<int> pidCatalogId = GeneratedColumn<int>(
      'pid_catalog_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES pid_catalog(id)');
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessionId, pidCatalogId, value, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'readings';
  @override
  VerificationContext validateIntegrity(Insertable<Reading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('pid_catalog_id')) {
      context.handle(
          _pidCatalogIdMeta,
          pidCatalogId.isAcceptableOrUnknown(
              data['pid_catalog_id']!, _pidCatalogIdMeta));
    } else if (isInserting) {
      context.missing(_pidCatalogIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_id'])!,
      pidCatalogId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pid_catalog_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ReadingsTable createAlias(String alias) {
    return $ReadingsTable(attachedDatabase, alias);
  }
}

class Reading extends DataClass implements Insertable<Reading> {
  final int id;
  final int sessionId;
  final int pidCatalogId;
  final double? value;
  final DateTime timestamp;
  const Reading(
      {required this.id,
      required this.sessionId,
      required this.pidCatalogId,
      this.value,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['pid_catalog_id'] = Variable<int>(pidCatalogId);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  ReadingsCompanion toCompanion(bool nullToAbsent) {
    return ReadingsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      pidCatalogId: Value(pidCatalogId),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      timestamp: Value(timestamp),
    );
  }

  factory Reading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reading(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      pidCatalogId: serializer.fromJson<int>(json['pidCatalogId']),
      value: serializer.fromJson<double?>(json['value']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'pidCatalogId': serializer.toJson<int>(pidCatalogId),
      'value': serializer.toJson<double?>(value),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  Reading copyWith(
          {int? id,
          int? sessionId,
          int? pidCatalogId,
          Value<double?> value = const Value.absent(),
          DateTime? timestamp}) =>
      Reading(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        pidCatalogId: pidCatalogId ?? this.pidCatalogId,
        value: value.present ? value.value : this.value,
        timestamp: timestamp ?? this.timestamp,
      );
  Reading copyWithCompanion(ReadingsCompanion data) {
    return Reading(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      pidCatalogId: data.pidCatalogId.present
          ? data.pidCatalogId.value
          : this.pidCatalogId,
      value: data.value.present ? data.value.value : this.value,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reading(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('pidCatalogId: $pidCatalogId, ')
          ..write('value: $value, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, pidCatalogId, value, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reading &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.pidCatalogId == this.pidCatalogId &&
          other.value == this.value &&
          other.timestamp == this.timestamp);
}

class ReadingsCompanion extends UpdateCompanion<Reading> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> pidCatalogId;
  final Value<double?> value;
  final Value<DateTime> timestamp;
  const ReadingsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.pidCatalogId = const Value.absent(),
    this.value = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  ReadingsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int pidCatalogId,
    this.value = const Value.absent(),
    this.timestamp = const Value.absent(),
  })  : sessionId = Value(sessionId),
        pidCatalogId = Value(pidCatalogId);
  static Insertable<Reading> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? pidCatalogId,
    Expression<double>? value,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (pidCatalogId != null) 'pid_catalog_id': pidCatalogId,
      if (value != null) 'value': value,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  ReadingsCompanion copyWith(
      {Value<int>? id,
      Value<int>? sessionId,
      Value<int>? pidCatalogId,
      Value<double?>? value,
      Value<DateTime>? timestamp}) {
    return ReadingsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      pidCatalogId: pidCatalogId ?? this.pidCatalogId,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (pidCatalogId.present) {
      map['pid_catalog_id'] = Variable<int>(pidCatalogId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('pidCatalogId: $pidCatalogId, ')
          ..write('value: $value, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PidCatalogTable pidCatalog = $PidCatalogTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $ReadingsTable readings = $ReadingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [pidCatalog, sessions, readings];
}

typedef $$PidCatalogTableCreateCompanionBuilder = PidCatalogCompanion Function({
  Value<int> id,
  required String mode,
  required String pid,
  required String description,
  Value<double?> minValue,
  Value<double?> maxValue,
  Value<String?> units,
  Value<String?> formula,
});
typedef $$PidCatalogTableUpdateCompanionBuilder = PidCatalogCompanion Function({
  Value<int> id,
  Value<String> mode,
  Value<String> pid,
  Value<String> description,
  Value<double?> minValue,
  Value<double?> maxValue,
  Value<String?> units,
  Value<String?> formula,
});

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

  ColumnFilters<String> get units => $composableBuilder(
      column: $table.units, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formula => $composableBuilder(
      column: $table.formula, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get units => $composableBuilder(
      column: $table.units, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formula => $composableBuilder(
      column: $table.formula, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get units =>
      $composableBuilder(column: $table.units, builder: (column) => column);

  GeneratedColumn<String> get formula =>
      $composableBuilder(column: $table.formula, builder: (column) => column);
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
    (
      PidCatalogData,
      BaseReferences<_$AppDatabase, $PidCatalogTable, PidCatalogData>
    ),
    PidCatalogData,
    PrefetchHooks Function()> {
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
            Value<String?> units = const Value.absent(),
            Value<String?> formula = const Value.absent(),
          }) =>
              PidCatalogCompanion(
            id: id,
            mode: mode,
            pid: pid,
            description: description,
            minValue: minValue,
            maxValue: maxValue,
            units: units,
            formula: formula,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String mode,
            required String pid,
            required String description,
            Value<double?> minValue = const Value.absent(),
            Value<double?> maxValue = const Value.absent(),
            Value<String?> units = const Value.absent(),
            Value<String?> formula = const Value.absent(),
          }) =>
              PidCatalogCompanion.insert(
            id: id,
            mode: mode,
            pid: pid,
            description: description,
            minValue: minValue,
            maxValue: maxValue,
            units: units,
            formula: formula,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (
      PidCatalogData,
      BaseReferences<_$AppDatabase, $PidCatalogTable, PidCatalogData>
    ),
    PidCatalogData,
    PrefetchHooks Function()>;
typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  Value<int> id,
  Value<DateTime> startedAt,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<int> id,
  Value<DateTime> startedAt,
});

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);
}

class $$SessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessionsTable,
    Session,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (Session, BaseReferences<_$AppDatabase, $SessionsTable, Session>),
    Session,
    PrefetchHooks Function()> {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
          }) =>
              SessionsCompanion(
            id: id,
            startedAt: startedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
          }) =>
              SessionsCompanion.insert(
            id: id,
            startedAt: startedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SessionsTable,
    Session,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (Session, BaseReferences<_$AppDatabase, $SessionsTable, Session>),
    Session,
    PrefetchHooks Function()>;
typedef $$ReadingsTableCreateCompanionBuilder = ReadingsCompanion Function({
  Value<int> id,
  required int sessionId,
  required int pidCatalogId,
  Value<double?> value,
  Value<DateTime> timestamp,
});
typedef $$ReadingsTableUpdateCompanionBuilder = ReadingsCompanion Function({
  Value<int> id,
  Value<int> sessionId,
  Value<int> pidCatalogId,
  Value<double?> value,
  Value<DateTime> timestamp,
});

class $$ReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingsTable> {
  $$ReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pidCatalogId => $composableBuilder(
      column: $table.pidCatalogId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$ReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingsTable> {
  $$ReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pidCatalogId => $composableBuilder(
      column: $table.pidCatalogId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$ReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingsTable> {
  $$ReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get pidCatalogId => $composableBuilder(
      column: $table.pidCatalogId, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$ReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReadingsTable,
    Reading,
    $$ReadingsTableFilterComposer,
    $$ReadingsTableOrderingComposer,
    $$ReadingsTableAnnotationComposer,
    $$ReadingsTableCreateCompanionBuilder,
    $$ReadingsTableUpdateCompanionBuilder,
    (Reading, BaseReferences<_$AppDatabase, $ReadingsTable, Reading>),
    Reading,
    PrefetchHooks Function()> {
  $$ReadingsTableTableManager(_$AppDatabase db, $ReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sessionId = const Value.absent(),
            Value<int> pidCatalogId = const Value.absent(),
            Value<double?> value = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              ReadingsCompanion(
            id: id,
            sessionId: sessionId,
            pidCatalogId: pidCatalogId,
            value: value,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sessionId,
            required int pidCatalogId,
            Value<double?> value = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              ReadingsCompanion.insert(
            id: id,
            sessionId: sessionId,
            pidCatalogId: pidCatalogId,
            value: value,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReadingsTable,
    Reading,
    $$ReadingsTableFilterComposer,
    $$ReadingsTableOrderingComposer,
    $$ReadingsTableAnnotationComposer,
    $$ReadingsTableCreateCompanionBuilder,
    $$ReadingsTableUpdateCompanionBuilder,
    (Reading, BaseReferences<_$AppDatabase, $ReadingsTable, Reading>),
    Reading,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PidCatalogTableTableManager get pidCatalog =>
      $$PidCatalogTableTableManager(_db, _db.pidCatalog);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$ReadingsTableTableManager get readings =>
      $$ReadingsTableTableManager(_db, _db.readings);
}
