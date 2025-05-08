// lib/data/app_database.dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'app_database.g.dart';

class PidCatalog extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mode => text()(); // e.g. "01"
  TextColumn get pid => text()(); // e.g. "0C"
  TextColumn get description => text()();
  RealColumn get minValue => real().nullable()();
  RealColumn get maxValue => real().nullable()();
  TextColumn get unit => text().nullable()();
}

class PidValues extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pidId =>
      integer().customConstraint('REFERENCES pid_catalog(id)')();
  RealColumn get value => real()();
  DateTimeColumn get timeStamp => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [PidCatalog, PidValues])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Catalog CRUD
  Future<List<PidCatalogData>> getAllPids() => select(pidCatalog).get();
  Future insertCatalog(PidCatalogCompanion p) => into(pidCatalog).insert(p);

  // Values CRUD
  Future insertValue(PidValuesCompanion v) => into(pidValues).insert(v);

  // Stream last N values for a given PID
  Stream<List<PidValue>> watchValuesForPid(int pidId, {int limit = 50}) {
    return (select(pidValues)
          ..where((tbl) => tbl.pidId.equals(pidId))
          ..orderBy([(t) => OrderingTerm.desc(t.timeStamp)])
          ..limit(limit))
        .watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'obdreader.sqlite'));
    return NativeDatabase(file);
  });
}
