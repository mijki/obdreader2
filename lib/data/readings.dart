import 'package:drift/drift.dart';

/// Each “reading” ties back to both a session and a PID definition,
/// and holds a numeric value (or null if it failed).
class Readings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId =>
      integer().customConstraint('REFERENCES sessions(id)')();
  IntColumn get pidCatalogId =>
      integer().customConstraint('REFERENCES pid_catalog(id)')();
  RealColumn get value => real().nullable()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}
