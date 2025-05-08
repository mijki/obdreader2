// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'data/app_database.dart';
import 'data/pid_seeds.dart';
import 'services/bluetooth_service.dart';
import 'pages/home_page.dart';
import 'pages/obd_data_page.dart';

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

// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'services/bluetooth_service.dart';
// import 'pages/obd_data_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'OBD-II Connection',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'OBD-II Connection'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
//   bool _isDiscovering = false;
//   List<BluetoothDiscoveryResult> _devicesList = [];
//   String _connectionStatus = "Disconnected";
//   BluetoothConnection? _connection;
//   bool _simulateOBDConnection = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkBluetoothState();
//   }

//   Future<void> _checkBluetoothState() async {
//     _bluetoothState = await BluetoothService.getBluetoothState();
//     setState(() {});
//   }

//   Future<void> _searchAndConnectOBD() async {
//     // 🔥 If Debug Mode is enabled, skip Bluetooth scanning and go directly to OBD Data Page
//     if (_simulateOBDConnection) {
//       setState(() {
//         _connectionStatus = "Connected to OBD (Simulated)";
//       });

//       await Future.delayed(const Duration(seconds: 1)); // Simulate delay
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ObdDataPage(
//               connection: null, // No actual connection in debug mode
//               simulated: true,
//             ),
//           ),
//         );
//       }
//       return; // Exit the function
//     }

//     // 🔵 Normal Bluetooth scanning starts here (only if NOT in Debug Mode)
//     bool permissionsGranted = await BluetoothService.requestPermissions();
//     if (!permissionsGranted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Bluetooth permissions not granted')),
//       );
//       return;
//     }

//     _bluetoothState = await BluetoothService.getBluetoothState();
//     if (_bluetoothState == BluetoothState.STATE_OFF) {
//       bool? enabled = await BluetoothService.enableBluetooth();
//       if (enabled == true) {
//         setState(() => _bluetoothState = BluetoothState.STATE_ON);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to enable Bluetooth')),
//         );
//         return;
//       }
//     }

//     _isDiscovering = true;
//     _devicesList.clear();
//     setState(() {});

//     BluetoothService.startDiscovery(
//       onDeviceFound: (device) async {
//         if (!_devicesList.contains(device)) {
//           _devicesList.add(device);
//         }

//         if (device.device.name != null && device.device.name!.contains("OBD")) {
//           _isDiscovering = false;
//           setState(() {});
//           await _connectToDevice(device.device);
//         }
//       },
//       onDiscoveryComplete: () {
//         setState(() {
//           _isDiscovering = false;
//         });
//       },
//     );
//   }

//   Future<void> _connectToDevice(BluetoothDevice device) async {
//     try {
//       if (_simulateOBDConnection) {
//         await Future.delayed(const Duration(seconds: 1));
//         setState(() => _connectionStatus = "Connected to OBD (Simulated)");
//       } else {
//         _connection = await BluetoothService.connectToDevice(device);
//         if (_connection?.isConnected ?? false) {
//           setState(() => _connectionStatus = "Connected to OBD");
//         }
//       }

//       if (mounted) {
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) => Dialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset('assets/bluetooth_connected.png', width: 150),
//                   const SizedBox(height: 10),
//                   Text(
//                     _simulateOBDConnection
//                         ? "Simulated Connection!"
//                         : "Connected Successfully!",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );

//         await Future.delayed(const Duration(seconds: 2));

//         if (mounted) {
//           Navigator.of(context).pop();
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ObdDataPage(
//                 connection: _simulateOBDConnection ? null : _connection,
//                 simulated: _simulateOBDConnection,
//               ),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => _connectionStatus = "Disconnected");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to connect: ${e.toString()}')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//             icon: Icon(
//               _simulateOBDConnection
//                   ? Icons.bug_report
//                   : Icons.bug_report_outlined,
//               color: _simulateOBDConnection ? Colors.red : Colors.black,
//             ),
//             onPressed: () {
//               setState(() => _simulateOBDConnection = !_simulateOBDConnection);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(_simulateOBDConnection
//                       ? "Simulation Mode Enabled"
//                       : "Simulation Mode Disabled"),
//                   duration: const Duration(seconds: 2),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _searchAndConnectOBD,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _connectionStatus == "Connected to OBD"
//                     ? Colors.green
//                     : Colors.amber,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//               child: Text(_connectionStatus == "Connected to OBD"
//                   ? "Connected"
//                   : "Search for OBD"),
//             ),
//             const SizedBox(height: 20),
//             _isDiscovering
//                 ? const CircularProgressIndicator()
//                 : _devicesList.isNotEmpty
//                     ? Expanded(
//                         child: ListView.builder(
//                           itemCount: _devicesList.length,
//                           itemBuilder: (context, index) {
//                             final result = _devicesList[index];
//                             return ListTile(
//                               title:
//                                   Text(result.device.name ?? 'Unknown device'),
//                               subtitle: Text(result.device.address),
//                               onTap: () => _connectToDevice(result.device),
//                             );
//                           },
//                         ),
//                       )
//                     : const Text('No devices discovered'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ObdDataPage extends StatelessWidget {
//   final BluetoothConnection? connection;
//   final bool simulated;

//   const ObdDataPage(
//       {super.key, required this.connection, required this.simulated});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('OBD Data')),
//       body: Center(
//         child: connection != null || simulated
//             ? const Text('OBD data will be displayed here')
//             : const Text('No connection established'),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // Root of the application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'OBD Reader HU',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(255, 5, 155, 0),
//         ),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'HUOBD Reader Pro++ Max'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   // Use lowerCamelCase enum values.
//   BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

//   // Fields for discovery functionality.
//   bool _isDiscovering = false;
//   List<BluetoothDiscoveryResult> _devicesList = [];

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   Future<bool> _requestBluetoothPermissions() async {
//     // Request BLUETOOTH_CONNECT and BLUETOOTH_SCAN permissions.
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.bluetoothConnect,
//       Permission.bluetoothScan,
//     ].request();
//     return statuses[Permission.bluetoothConnect]?.isGranted == true &&
//         statuses[Permission.bluetoothScan]?.isGranted == true;
//   }

//   Future<void> _toggleOrDiscoverBluetooth() async {
//     // Ensure permissions are granted.
//     bool permissionsGranted = await _requestBluetoothPermissions();
//     if (!permissionsGranted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Bluetooth permissions not granted')),
//       );
//       return;
//     }

//     // Get current Bluetooth state.
//     BluetoothState state = await FlutterBluetoothSerial.instance.state;

//     // If Bluetooth is off or unknown, request to enable it.
//     if (state == BluetoothState.STATE_OFF || state == BluetoothState.UNKNOWN) {
//       bool? enabled = await FlutterBluetoothSerial.instance.requestEnable();
//       if (enabled == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Bluetooth enabled')),
//         );
//         setState(() {
//           _bluetoothState = BluetoothState.STATE_ON;
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to enable Bluetooth')),
//         );
//       }
//     } else if (state == BluetoothState.STATE_ON) {
//       // If Bluetooth is on, start device discovery if not already searching.
//       if (!_isDiscovering) {
//         setState(() {
//           _isDiscovering = true;
//           _devicesList.clear();
//         });
//         FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
//           setState(() {
//             if (!_devicesList.contains(result)) {
//               _devicesList.add(result);
//             }
//           });
//         }).onDone(() {
//           setState(() {
//             _isDiscovering = false;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Discovery completed')),
//           );
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Searching for devices...')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Already searching for devices')),
//         );
//       }
//     }

//     // Update the displayed Bluetooth state.
//     BluetoothState newState = await FlutterBluetoothSerial.instance.state;
//     setState(() {
//       _bluetoothState = newState;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Determine the button label based on Bluetooth state.
//     String buttonLabel = (_bluetoothState == BluetoothState.STATE_ON)
//         ? 'Search for devices'
//         : 'Turn on Bluetooth';

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Wrap in Center to center horizontally and vertically.
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 onPressed: _toggleOrDiscoverBluetooth,
//                 child: Text(buttonLabel),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Bluetooth state: ${_bluetoothState.toString().split('.').last}',
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 20),
//               _isDiscovering
//                   ? const CircularProgressIndicator()
//                   : _devicesList.isEmpty
//                       ? const Text('No devices discovered')
//                       : Container(
//                           height: 200, // Fixed height for list view.
//                           child: ListView.builder(
//                             itemCount: _devicesList.length,
//                             itemBuilder: (context, index) {
//                               final result = _devicesList[index];
//                               return ListTile(
//                                 title: Text(
//                                     result.device.name ?? 'Unknown device'),
//                                 subtitle: Text(result.device.address),
//                               );
//                             },
//                           ),
//                         ),
//               const SizedBox(height: 20),
//               const Text('You have pushed the button this many times:'),
//               Text(
//                 '$_counter',
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color.fromARGB(255, 5, 155, 0)),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Csak a kettest pls'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
