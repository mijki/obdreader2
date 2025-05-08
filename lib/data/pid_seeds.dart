// lib/data/pid_seeds.dart
import 'package:drift/drift.dart';
import 'app_database.dart';

/// A list of all the PIDs we can use in the app.  This is a “seed” list that will be
/// used to populate the database when it is first created.  It is not meant to be
/// a comprehensive list of all possible PIDs.
final List<PidCatalogCompanion> pidSeeds = [
  PidCatalogCompanion.insert(
    mode: '01',
    pid: '00',
    description: 'PIDs supported [01–20]',
    minValue: null,
    maxValue: null,
    unit: null,
  ),
  PidCatalogCompanion.insert(
    mode: '01',
    pid: '0C',
    description: 'Engine RPM',
    minValue: 0,
    maxValue: 16383.75,
    unit: 'rpm',
  ),
  PidCatalogCompanion.insert(
    mode: '01',
    pid: '0D',
    description: 'Vehicle Speed',
    minValue: 0,
    maxValue: 255,
    unit: 'km/h',
  ),
  // …and so on for every PID you care about…
];
