import 'package:drift/drift.dart';

/// When you press “Connect”, you start a new session.
/// We record its timestamp so you can view historical runs later.
class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startedAt => dateTime().withDefault(currentDateAndTime)();
}
