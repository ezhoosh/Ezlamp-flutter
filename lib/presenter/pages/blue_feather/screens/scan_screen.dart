import 'dart:async';
import 'dart:developer';

import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/button/primary_button.dart';
import 'package:easy_lamp/core/widgets/top_bar.dart';
import 'package:easy_lamp/presenter/bloc/command_bloc/command_bloc.dart';
import 'package:easy_lamp/presenter/pages/home_feature/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:sizer/sizer.dart';

import 'device_screen.dart';
import '../utils/snackbar.dart';
import '../widgets/connected_device_tile.dart';
import '../widgets/scan_result_tile.dart';
import '../utils/extra.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<BluetoothDevice> _connectedDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;
  BluetoothDevice? deviceConnected;
  late AppLocalizations al;

  @override
  void initState() {
    super.initState();

    FlutterBluePlus.systemDevices.then((devices) {
      _connectedDevices = devices;
      setState(() {});
    });

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;
      _scanResults.removeWhere((element) => element.device.platformName == '');
      _scanResults.removeWhere((element) => !element.device.platformName.contains("Caspian"));
      setState(() {});
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyB,
      child: Scaffold(
        backgroundColor: MyColors.black,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    TopBar(
                      title: al.addNewConnection,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          ),
                          child: Text(al.skip,
                              style: Light300Style.normal.copyWith(
                                color: MyColors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: MySpaces.s24,
                ),
                Image.asset(
                  'assets/images/bg_blue.png',
                  height: 60.w,
                  width: 60.w,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: MySpaces.s24,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.black.shade800,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      )),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_connectedDevices.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, top: 20, left: 20),
                              child: Text(
                                al.connected,
                                style: DemiBoldStyle.normal
                                    .copyWith(color: MyColors.white),
                              ),
                            ),
                          ..._buildConnectedDeviceTiles(context),
                          if (_scanResults.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, top: 20, left: 20),
                              child: Text(
                                al.result,
                                style: DemiBoldStyle.normal
                                    .copyWith(color: MyColors.white),
                              ),
                            ),
                          ..._buildScanResultTiles(context),
                          const SizedBox(height: MySpaces.s60,)
                        ],
                      )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            margin: const EdgeInsets.all(MySpaces.s24),
                            width: double.infinity,
                            child: buildScanButton(context)),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future onScanPressed() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e),
          success: false);
    }
    setState(() {}); // force refresh of systemDevices
  }

  Future onStopPressed() async {
    try {
      FlutterBluePlus.stopScan();
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e),
          success: false);
    }
  }

  void onDisConnectPressed(BluetoothDevice device) {
    device.disconnect();
    onStopPressed();
    setState(() {
      _connectedDevices.remove(device);
    });
  }

  void onConnectPressed(BluetoothDevice device) {
    final t = device.connectAndUpdateStream();
    // t.then((value) {
    setState(() {
      _connectedDevices.add(device);
     _scanResults.removeWhere((element) => device.platformName == element.device.platformName);

    });
    BlocProvider.of<CommandBloc>(context).add(ConnectedBlueEvent(device));
    onStopPressed();
    // });
    // t.catchError((e) {
    //   Snackbar.show(ABC.c, prettyException("Connect Error:", e),
    //       success: false);
    // });
    // MaterialPageRoute route = MaterialPageRoute(
    //     builder: (context) => DeviceScreen(device: device),
    //     settings: RouteSettings(name: '/DeviceScreen'));
    // Navigator.of(context).push(route);
  }

  Future onRefresh() {
    if (_isScanning == false) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    }
    setState(() {});
    return Future.delayed(const Duration(milliseconds: 500));
  }

  Widget buildScanButton(BuildContext context) {
    if (FlutterBluePlus.isScanningNow) {
      return PrimaryButton(
        text: al.stopScan,
        onPress: onStopPressed,
      );
    } else {
      return PrimaryButton(
          onPress: deviceConnected != null ? onDoneClick : onScanPressed,
          text: deviceConnected != null ? al.done : al.scan);
    }
  }

  onDoneClick() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  List<Widget> _buildConnectedDeviceTiles(BuildContext context) {
    return _connectedDevices
        .map(
          (d) => ConnectedDeviceTile(
            device: d,
            onDisconnect: () => onDisConnectPressed(d),
            onConnect: () => onConnectPressed(d),
            connect: true,
          ),
        )
        .toList();
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _scanResults
        .map(
          (d) => ConnectedDeviceTile(
            device: d.device,
            onDisconnect: () => onDisConnectPressed(d.device),
            onConnect: () => onConnectPressed(d.device),
            connect: false,
          ),
        )
        .toList();
  }
}
