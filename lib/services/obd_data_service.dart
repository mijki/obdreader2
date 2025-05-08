// lib/services/obd_data_service.dart
import 'dart:async';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../data/app_database.dart';

class ObdDataService {
  final BluetoothConnection? connection;
  final AppDatabase _db;

  Timer? _pollTimer;
  List<PidCatalogData>? _catalog;
  final Map<int, StreamController<double>> _controllers = {};
  final Map<int, List<double>> _history = {};

  ObdDataService(this.connection, this._db);

  /// Call this once you have an active connection (or just after construction
  /// in simulate mode).  It will fetch the PID catalog and then start polling
  /// every second.
  Future<void> startAllPolling() async {
    _catalog = await _db.getAllPids(); // <-- async load
    _pollTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        for (final pid in _catalog!) {
          _pollPid(pid);
        }
      },
    );
  }

  /// Stops the timer and closes all streams
  void stopAllPolling() {
    _pollTimer?.cancel();
    for (final ctrl in _controllers.values) {
      ctrl.close();
    }
    _controllers.clear();
    _history.clear();
  }

  /// Returns a live stream of the most recent value for `pidId`.
  Stream<double> currentStream(int pidId) {
    return _controllerFor(pidId).stream;
  }

  /// Returns a live stream of a rolling list of the last ~30 values.
  Stream<List<double>> historyStream(int pidId) {
    return _controllerFor(pidId).stream.transform(_HistoryTransformer());
  }

  //// INTERNALS ////

  StreamController<double> _controllerFor(int pidId) {
    return _controllers.putIfAbsent(pidId, () {
      _history[pidId] = [];
      return StreamController<double>.broadcast();
    });
  }

  void _pollPid(PidCatalogData pid) {
    // TODO: replace this with your real OBD command + parse logic
    final fakeValue = (pid.id * DateTime.now().second) % 200 / 1.0;

    final ctrl = _controllerFor(pid.id);
    final hist = _history[pid.id]!;

    hist.add(fakeValue);
    if (hist.length > 30) hist.removeAt(0);

    ctrl.add(fakeValue);
  }
}

/// Accumulates up to 30 points in memory, emitting the full list on each tick.
class _HistoryTransformer extends StreamTransformerBase<double, List<double>> {
  final List<double> _acc = [];

  @override
  Stream<List<double>> bind(Stream<double> stream) {
    return stream.map((val) {
      _acc.add(val);
      if (_acc.length > 30) _acc.removeAt(0);
      // always emit a NEW list to avoid outside mutation
      return List<double>.from(_acc);
    });
  }
}
