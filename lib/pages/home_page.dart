// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../services/bluetooth_service.dart';
import 'obd_data_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  bool _isDiscovering = false;
  List<BluetoothDiscoveryResult> _devicesList = [];
  String _connectionStatus = "Disconnected";
  BluetoothConnection? _connection;

  /// When true, we skip real Bluetooth and jump straight to the dashboard.
  bool _simulateOBDConnection = false;

  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }

  Future<void> _checkBluetoothState() async {
    _bluetoothState = await BluetoothService.getBluetoothState();
    setState(() {});
  }

  Future<void> _searchAndConnectOBD() async {
    // ── 1) VERY FIRST THING: if we’re in debug/simulate mode, jump to the dashboard ──
    if (_simulateOBDConnection) {
      setState(() {
        _connectionStatus = "Connected to OBD (Simulated)";
        _isDiscovering = false;
        _devicesList.clear();
      });
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      // 🔥 DEBUG MODE: only this push, not pushReplacement
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ObdDataPage(
            connection: null,
            simulated: true,
          ),
        ),
      );
      return;
    }

    // ── 2) ONLY IF NOT SIMULATING do we fall into the real Bluetooth flow ──

    // 1) Permissions
    bool ok = await BluetoothService.requestPermissions();
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bluetooth permissions not granted')),
      );
      return;
    }

    // 2) Check & enable BT if needed
    _bluetoothState = await FlutterBluetoothSerial.instance.state;
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      bool? enabled = await FlutterBluetoothSerial.instance.requestEnable();
      if (enabled == true) {
        setState(() => _bluetoothState = BluetoothState.STATE_ON);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to enable Bluetooth')),
        );
        return;
      }
    }

    // 3) Start discovery…
    setState(() {
      _isDiscovering = true;
      _devicesList.clear();
    });
    BluetoothService.startDiscovery(
      onDeviceFound: (result) async {
        if (!_devicesList.contains(result)) {
          setState(() => _devicesList.add(result));
        }
        if (result.device.name?.contains("OBD") == true) {
          setState(() => _isDiscovering = false);
          await _connectToDevice(result.device);
        }
      },
      onDiscoveryComplete: () {
        setState(() => _isDiscovering = false);
      },
    );
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      if (_simulateOBDConnection) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() => _connectionStatus = "Connected to OBD (Simulated)");
      } else {
        _connection = await BluetoothService.connectToDevice(device);
        if (_connection?.isConnected ?? false) {
          setState(() => _connectionStatus = "Connected to OBD");
        }
      }

      if (!mounted) return;

      // show the “connected” pop-up
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/bluetooth_connected.png', width: 150),
                const SizedBox(height: 10),
                Text(
                  _simulateOBDConnection
                      ? "Simulated Connection!"
                      : "Connected Successfully!",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;

      // show the “connected” dialog
      showDialog(
        context: context,
        barrierDismissible: false, // optional—prevents tap-outside to dismiss
        builder: (BuildContext dialogCtx) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/bluetooth_connected.png', width: 150),
                  const SizedBox(height: 10),
                  Text(
                    _simulateOBDConnection
                        ? "Simulated Connection!"
                        : "Connected Successfully!",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.of(context).pop(); // close dialog

      // 🔵 REAL MODE: only this push, not pushReplacement
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ObdDataPage(
            connection: _connection,
            simulated: _simulateOBDConnection,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _connectionStatus = "Disconnected");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              _simulateOBDConnection
                  ? Icons.bug_report
                  : Icons.bug_report_outlined,
              color: _simulateOBDConnection ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() => _simulateOBDConnection = !_simulateOBDConnection);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_simulateOBDConnection
                      ? "Simulation Mode Enabled"
                      : "Simulation Mode Disabled"),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _searchAndConnectOBD,
              style: ElevatedButton.styleFrom(
                backgroundColor: _connectionStatus == "Connected to OBD"
                    ? Colors.green
                    : Colors.amber,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                _connectionStatus == "Connected to OBD"
                    ? "Connected"
                    : "Search for OBD",
              ),
            ),
            const SizedBox(height: 20),
            if (_isDiscovering)
              const CircularProgressIndicator()
            else if (_devicesList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _devicesList.length,
                  itemBuilder: (_, index) {
                    final r = _devicesList[index];
                    return ListTile(
                      title: Text(r.device.name ?? 'Unknown device'),
                      subtitle: Text(r.device.address),
                      onTap: () => _connectToDevice(r.device),
                    );
                  },
                ),
              )
            else
              const Text('No devices discovered'),
          ],
        ),
      ),
    );
  }
}
