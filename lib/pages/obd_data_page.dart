import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:obdreader2/utils/obd_parser.dart';

/// OBD Data Page - Displays real-time OBD-II data like RPM and speed.
class ObdDataPage extends StatefulWidget {
  /// The Bluetooth connection; null if in simulation mode.
  final BluetoothConnection? connection;

  /// True if we're running in simulation (debug) mode.
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
  String _connectionStatus = "Connected";
  String _vehicleSpeed = "N/A";
  String _engineRPM = "N/A";
  StreamSubscription<Uint8List>? _subscription;

  @override
  void initState() {
    super.initState();
    // Pre-set status if in simulation mode or no real connection
    if (widget.simulated || widget.connection == null) {
      _connectionStatus = "Simulated Connection";
    } else {
      _startListening();
    }
  }

  /// Listens to incoming OBD-II data and updates the UI accordingly.
  void _startListening() {
    _subscription = widget.connection!.input?.listen((data) {
      final receivedData = String.fromCharCodes(data);
      setState(() {
        if (receivedData.contains("010C")) {
          _engineRPM = "RPM: ${ObdParser.parseRPM(receivedData)}";
        } else if (receivedData.contains("010D")) {
          _vehicleSpeed = "Speed: ${ObdParser.parseSpeed(receivedData)} km/h";
        }
      });
    });

    _subscription?.onDone(() {
      setState(() => _connectionStatus = "Disconnected");
    });
  }

  /// Closes the OBD connection and navigates back.
  void _disconnect() async {
    await widget.connection?.close();
    await _subscription?.cancel();
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasConnection = widget.simulated || widget.connection != null;

    return Scaffold(
      appBar: AppBar(title: const Text("OBD-II Data")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _connectionStatus,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (hasConnection) ...[
              Text(
                _engineRPM,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Text(
                _vehicleSpeed,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _disconnect,
                icon: const Icon(Icons.bluetooth_disabled),
                label: const Text("Disconnect"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ] else ...[
              const Text(
                'No connection established',
                style: TextStyle(fontSize: 18),
              ),
            ]
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
