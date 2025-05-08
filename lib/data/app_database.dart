// lib/data/app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'pid_catalog.dart';
import 'sessions.dart';
import 'readings.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [PidCatalog, Sessions, Readings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<PidCatalogData>> getAllPids() => select(pidCatalog).get();
  Future<List<Session>> getAllSessions() => select(sessions).get();
  Future<List<Reading>> getReadingsFor(int sessionId) =>
      (select(readings)..where((r) => r.sessionId.equals(sessionId))).get();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final docDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(docDir.path, 'obdreader.sqlite'));
    return NativeDatabase(file);
  });
}
