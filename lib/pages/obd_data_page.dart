import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:obdreader2/utils/obd_parser.dart';

/// A simple PID description.
class PidOption {
  final String code;
  final String name;
  final String unit;
  const PidOption(this.code, this.name, this.unit);
}

class ObdDataPage extends StatefulWidget {
  /// May be null in debug/simulated mode.
  final BluetoothConnection? connection;

  /// If true, we’ll skip the live‐bluetooth listener entirely.
  final bool simulated;

  const ObdDataPage({
    Key? key,
    this.connection,
    this.simulated = false,
  }) : super(key: key);

  @override
  _ObdDataPageState createState() => _ObdDataPageState();
}

class _ObdDataPageState extends State<ObdDataPage> {
  StreamSubscription<Uint8List>? _subscription;

  /// The set of available PIDs you can choose from.
  final List<PidOption> _availablePids = const [
    PidOption('010C', 'Engine RPM', 'rpm'),
    PidOption('010D', 'Vehicle Speed', 'km/h'),
    // → feel free to add more here
  ];

  /// The codes the user has currently selected.
  Set<String> _selectedCodes = {};

  /// Maps a code → the last known value string.
  Map<String, String> _currentValues = {};

  @override
  void initState() {
    super.initState();

    // In simulation mode, pre‐select a couple:
    if (widget.simulated) {
      _selectedCodes = {'010C', '010D'};
      _currentValues = {
        '010C': '--',
        '010D': '--',
      };
    } else {
      _startListening();
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
            // parse only the codes we care about:
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

  void _disconnect() {
    widget.connection?.close();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _showPidSelectionDialog() async {
    final temp = Set<String>.from(_selectedCodes);

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select PIDs to display'),
        content: SingleChildScrollView(
          child: Column(
            children: _availablePids.map((pid) {
              return CheckboxListTile(
                title: Text('${pid.name} (${pid.code})'),
                subtitle: Text(pid.unit),
                value: temp.contains(pid.code),
                onChanged: (on) {
                  setState(() {
                    if (on == true)
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
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCodes = temp;
                // initialize any missing currentValues
                for (var code in _selectedCodes) {
                  _currentValues.putIfAbsent(code, () => '--');
                }
              });
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasConnection = widget.simulated || widget.connection != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('OBD-II Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showPidSelectionDialog,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Show whether we're simulated or live
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.simulated ? 'Simulated Connection' : 'Live Connection',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // If no PIDs chosen, prompt the user
            if (_selectedCodes.isEmpty) ...[
              const Center(
                  child: Text('No PIDs selected.\nTap ⚙️ to choose.',
                      textAlign: TextAlign.center)),
            ] else ...[
              // Otherwise show one card per selected PID
              Expanded(
                child: ListView(
                  children: _selectedCodes.map((code) {
                    final pid =
                        _availablePids.firstWhere((p) => p.code == code);
                    final val = _currentValues[code] ?? '--';
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(pid.name,
                                style: const TextStyle(fontSize: 16)),
                            Text('$val ${pid.unit}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            // Always show a disconnect button at the bottom
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:obdreader2/utils/obd_parser.dart';

// /// OBD Data Page - Displays real-time OBD-II data like RPM and speed.
// class ObdDataPage extends StatefulWidget {
//   /// The Bluetooth connection; null if in simulation mode.
//   final BluetoothConnection? connection;

//   /// True if we're running in simulation (debug) mode.
//   final bool simulated;

//   const ObdDataPage({
//     Key? key,
//     required this.connection,
//     required this.simulated,
//   }) : super(key: key);

//   @override
//   _ObdDataPageState createState() => _ObdDataPageState();
// }

// class _ObdDataPageState extends State<ObdDataPage> {
//   String _connectionStatus = "Connected";
//   String _vehicleSpeed = "N/A";
//   String _engineRPM = "N/A";

//   @override
//   void initState() {
//     super.initState();
//     // Pre-set status if in simulation mode
//     if (widget.simulated) {
//       _connectionStatus = "Simulated Connection";
//     } else {
//       _startListening();
//     }
//   }

//   /// Listens to incoming OBD-II data and updates the UI accordingly.
//   void _startListening() {
//     widget.connection?.input?.listen((data) {
//       String receivedData = String.fromCharCodes(data);
//       setState(() {
//         if (receivedData.contains("010C")) {
//           _engineRPM = "RPM: ${ObdParser.parseRPM(receivedData)}";
//         } else if (receivedData.contains("010D")) {
//           _vehicleSpeed = "Speed: ${ObdParser.parseSpeed(receivedData)} km/h";
//         }
//       });
//     }).onDone(() {
//       setState(() {
//         _connectionStatus = "Disconnected";
//       });
//     });
//   }

//   /// Closes the OBD connection and navigates back.
//   void _disconnect() async {
//     await widget.connection?.close();
//     if (mounted) Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hasConnection = widget.connection != null || widget.simulated;

//     return Scaffold(
//       appBar: AppBar(title: const Text("OBD-II Data")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               _connectionStatus,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             if (hasConnection) ...[
//               Text(
//                 _engineRPM,
//                 style:
//                     const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 _vehicleSpeed,
//                 style:
//                     const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton.icon(
//                 onPressed: _disconnect,
//                 icon: const Icon(Icons.bluetooth_disabled),
//                 label: const Text("Disconnect"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 ),
//               ),
//             ] else ...[
//               const Text(
//                 'No connection established',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:obdreader2/utils/obd_parser.dart';

// /// OBD Data Page - Displays real-time OBD-II data like RPM and speed.
// class ObdDataPage extends StatefulWidget {
//   final BluetoothConnection connection;

//   const ObdDataPage({super.key, required this.connection});

//   @override
//   _ObdDataPageState createState() => _ObdDataPageState();
// }

// class _ObdDataPageState extends State<ObdDataPage> {
//   String _connectionStatus = "Connected";
//   String _vehicleSpeed = "N/A";
//   String _engineRPM = "N/A";

//   @override
//   void initState() {
//     super.initState();
//     _startListening();
//   }

//   /// Listens to incoming OBD-II data and updates the UI accordingly.
//   void _startListening() {
//     widget.connection.input?.listen((data) {
//       String receivedData = String.fromCharCodes(data);

//       setState(() {
//         if (receivedData.contains("010C")) {
//           _engineRPM = "RPM: ${ObdParser.parseRPM(receivedData)}";
//         } else if (receivedData.contains("010D")) {
//           _vehicleSpeed = "Speed: ${ObdParser.parseSpeed(receivedData)} km/h";
//         }
//       });
//     }).onDone(() {
//       setState(() {
//         _connectionStatus = "Disconnected";
//       });
//     });
//   }

//   /// Closes the OBD connection and navigates back.
//   void _disconnect() async {
//     await widget.connection.close();
//     if (mounted) {
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("OBD-II Data")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(_connectionStatus,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             Text(_engineRPM,
//                 style:
//                     const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
//             const SizedBox(height: 20),
//             Text(_vehicleSpeed,
//                 style:
//                     const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
//             const SizedBox(height: 30),
//             ElevatedButton.icon(
//               onPressed: _disconnect,
//               icon: const Icon(Icons.bluetooth_disabled),
//               label: const Text("Disconnect"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
