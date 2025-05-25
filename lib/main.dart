// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/app_database.dart';
import 'data/pid_seeds.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();

  // seed if empty
  await db.transaction(() async {
    // 1) check via the same `db`
    final existing = await db.select(db.pidCatalog).get();
    if (existing.isEmpty) {
      // 2) do a batch insert via the same `db`
      await db.batch((batch) {
        batch.insertAll(db.pidCatalog, pidSeeds);
      });
    }
  });

  runApp(
    Provider<AppDatabase>.value(
      value: db,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBD-II Connection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'OBD-II Connection'),
    );
  }
}
