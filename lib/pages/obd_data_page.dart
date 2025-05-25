// lib/pages/obd_data_page.dart

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show OrderingTerm;

import '../data/app_database.dart';
import '../utils/obd_parser.dart';

/// A simple PID description, now with its DB id.
class PidOption {
  final int id; // DB primary key
  final String code; // e.g. "010C"
  final String name; // e.g. "Engine RPM"
  final String unit; // e.g. "rpm"
  const PidOption(this.id, this.code, this.name, this.unit);
}

class ObdDataPage extends StatefulWidget {
  final BluetoothConnection? connection;
  final bool simulated;
  const ObdDataPage({Key? key, this.connection, this.simulated = false})
      : super(key: key);

  @override
  _ObdDataPageState createState() => _ObdDataPageState();
}

class _ObdDataPageState extends State<ObdDataPage> {
  StreamSubscription<Uint8List>? _subscription;

  List<PidOption> _availablePids = [];
  List<String> _selectedCodes = [];
  Map<String, String> _currentValues = {};

  bool _locked = true;
  String _sortMode = 'none';

  @override
  void initState() {
    super.initState();
    _loadCatalog().then((_) {
      // once catalog is loaded, pull last values for any pre-selections
      _loadCurrentValues();
    });

    if (widget.simulated) {
      _selectedCodes = ['010C', '010D'];
      // seed the map with placeholders; real values come from DB
      _currentValues = {'010C': '--', '010D': '--'};
    } else {
      _startListening();
    }
  }

  /// Load the full PID catalog (with IDs) from the database.
  Future<void> _loadCatalog() async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final rows = await db.getAllPids();
    setState(() {
      _availablePids = rows
          .map((r) =>
              PidOption(r.id, r.mode + r.pid, r.description, r.unit ?? ''))
          .toList();
    });
  }

  /// For each selected code, query the DB for its most recent value.
  Future<void> _loadCurrentValues() async {
    final db = Provider.of<AppDatabase>(context, listen: false);

    for (final code in _selectedCodes) {
      final pidOption = _availablePids.firstWhere((p) => p.code == code);
      final row = await (db.select(db.pidValues)
            ..where((t) => t.pidId.equals(pidOption.id))
            ..orderBy([(t) => OrderingTerm.desc(t.timeStamp)])
            ..limit(1))
          .getSingleOrNull();

      setState(() {
        _currentValues[code] =
            row != null ? row.value.toStringAsFixed(1) : '--';
      });
    }
  }

  void _startListening() {
    final input = widget.connection?.input;
    if (input == null) return;
    _subscription = input.listen((bytes) {
      final chunk = String.fromCharCodes(bytes);
      setState(() {
        for (final code in _selectedCodes) {
          if (chunk.contains(code)) {
            String parsed;
            if (code == '010C') {
              parsed = ObdParser.parseRPM(chunk).toString();
            } else if (code == '010D') {
              parsed = ObdParser.parseSpeed(chunk).toString();
            } else {
              parsed = 'N/A';
            }
            _currentValues[code] = parsed;
          }
        }
      });
    });
    _subscription?.onDone(_disconnect);
  }

  void _disconnect() => widget.connection?.close();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _showPidSelectionDialog() async {
    final temp = List<String>.from(_selectedCodes);

    await showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, dialogSetState) {
            return AlertDialog(
              title: const Text('Select PIDs to display'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _availablePids.map((pid) {
                    return CheckboxListTile(
                      title: Text('${pid.name} (${pid.code})'),
                      subtitle: Text(pid.unit),
                      value: temp.contains(pid.code),
                      onChanged: (checked) {
                        dialogSetState(() {
                          if (checked == true)
                            temp.add(pid.code);
                          else
                            temp.remove(pid.code);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCodes = List.from(temp);
                      for (var code in _selectedCodes) {
                        _currentValues.putIfAbsent(code, () => '--');
                      }
                    });
                    // *now* pull their last values
                    _loadCurrentValues();
                    Navigator.pop(ctx);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPidCard(String code) {
    final pid = _availablePids.firstWhere((p) => p.code == code);
    final val = _currentValues[code] ?? '--';
    return Card(
      key: ValueKey(code),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(pid.name, style: const TextStyle(fontSize: 16)),
            Text('$val ${pid.unit}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show a spinner during initial catalog load
    if (_availablePids.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('OBD-II Data')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('OBD-II Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showPidSelectionDialog,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (mode) {
              setState(() {
                _sortMode = mode;
                if (mode == 'code') {
                  _selectedCodes.sort();
                } else if (mode == 'name') {
                  _selectedCodes.sort((a, b) {
                    final na =
                        _availablePids.firstWhere((p) => p.code == a).name;
                    final nb =
                        _availablePids.firstWhere((p) => p.code == b).name;
                    return na.compareTo(nb);
                  });
                }
              });
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'none', child: Text('No auto-sort')),
              PopupMenuItem(value: 'code', child: Text('Sort by code')),
              PopupMenuItem(value: 'name', child: Text('Sort by name')),
            ],
          ),
          IconButton(
            icon: Icon(_locked ? Icons.lock : Icons.lock_open),
            onPressed: () => setState(() => _locked = !_locked),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.simulated ? 'Simulated Connection' : 'Live Connection',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedCodes.isEmpty) ...[
              const Expanded(
                child: Center(
                    child: Text(
                  'No PIDs selected.\nTap ⚙️ to choose.',
                  textAlign: TextAlign.center,
                )),
              ),
            ] else ...[
              Expanded(
                child: _locked
                    ? ListView(
                        children: _selectedCodes.map(_buildPidCard).toList(),
                      )
                    : ReorderableListView(
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex--;
                            final item = _selectedCodes.removeAt(oldIndex);
                            _selectedCodes.insert(newIndex, item);
                          });
                        },
                        children: _selectedCodes.map(_buildPidCard).toList(),
                      ),
              ),
            ],
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                _subscription?.cancel();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.bluetooth_disabled),
              label: const Text('Disconnect'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
