import 'dart:ui';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothService {
  static Future<BluetoothState> getBluetoothState() async {
    return await FlutterBluetoothSerial.instance.state;
  }

  static Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
    ].request();
    return statuses[Permission.bluetoothConnect]?.isGranted == true &&
        statuses[Permission.bluetoothScan]?.isGranted == true;
  }

  static Future<bool?> enableBluetooth() async {
    return await FlutterBluetoothSerial.instance.requestEnable();
  }

  static void startDiscovery({
    required Function(BluetoothDiscoveryResult) onDeviceFound,
    required VoidCallback onDiscoveryComplete,
  }) {
    FlutterBluetoothSerial.instance
        .startDiscovery()
        .listen(onDeviceFound)
        .onDone(onDiscoveryComplete);
  }

  static Future<BluetoothConnection> connectToDevice(
      BluetoothDevice device) async {
    return await BluetoothConnection.toAddress(device.address);
  }
}
