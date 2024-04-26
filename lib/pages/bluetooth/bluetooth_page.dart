import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:gym_app/widgets/action_button.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  final _bluetooth = FlutterBluetoothSerial.instance;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  int times = 0;

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }

  void _receiveData() {
    _connection?.input?.listen((event) {
      if (String.fromCharCodes(event) == "p") {
        setState(() => times = times + 1);
      }
    });
  }

  void _sendData(String data) {
    if (_connection?.isConnected ?? false) {
      _connection?.output.add(ascii.encode(data));
    }
  }

  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  @override
  void initState() {
    super.initState();

    _requestPermission();

    // Get current state
    // FlutterBluetoothSerial.instance.state.then((state) {
    //   setState(() {
    //     _bluetoothState = state.isEnabled;
    //   });
    // });

    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });

    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bluetooth connect"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_left_outlined),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _controlBT(),
          _infoDevide(),
          Expanded(
            child: _listDevices(),
          ),
          _inputSerial(),
          _buttons(),
        ],
      ),
    );
  }

  Widget _controlBT() {
    return SwitchListTile(
      value: _bluetoothState,
      onChanged: (bool value) async {
        if (value) {
          await _bluetooth.requestEnable();
        } else {
          await _bluetooth.requestDisable();
        }
      },
      tileColor: Colors.black26,
      title: Text(_bluetoothState ? "ON" : "OFF"),
    );
  }

  Widget _infoDevide() {
    return ListTile(
      tileColor: Colors.black12,
      title: Text(_deviceConnected != null &&
              _deviceConnected!.name != null &&
              _deviceConnected!.name!.isNotEmpty
          ? "Connected to device ${_deviceConnected!.name}"
          : "Not Connected"),
      trailing: _connection?.isConnected ?? false
          ? TextButton(
              onPressed: () async {
                await _connection?.finish();
                setState(() => _deviceConnected = null);
              },
              child: const Text("Finish connection"),
            )
          : TextButton(
              onPressed: _getDevices,
              child: const Text("See all devices"),
            ),
    );
  }

  Widget _listDevices() {
    return _isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    ...[
                      for (final device in _devices)
                        ListTile(
                          title: Text(device.name ?? device.address),
                          trailing: TextButton(
                            child: const Text('Connect'),
                            onPressed: () async {
                              setState(() => _isConnecting = true);
                              print("DEVICEEEE: ${device.address}");
                              _connection = await BluetoothConnection.toAddress(
                                  device.address);
                              _deviceConnected = device;
                              _devices = [];
                              _isConnecting = false;

                              _receiveData();

                              setState(() {});
                            },
                          ),
                        )
                    ]
                  ],
                )));
  }

  Widget _inputSerial() {
    return ListTile(
      trailing: TextButton(
        child: const Text('hard reset'),
        onPressed: () => setState(() => times = 0),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: Text(
          "Pressed x$times times",
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  Widget _buttons() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
        color: Colors.black12,
        child: Column(
          children: [
            const Text(
              'Send basic data',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    text: "Preset 1",
                    color: Colors.green,
                    onTap: () => _sendData("1"),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: ActionButton(
                    text: "Preset 2",
                    color: Colors.red,
                    onTap: () => _sendData("2"),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
