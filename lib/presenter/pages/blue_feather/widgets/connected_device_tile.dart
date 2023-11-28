import 'dart:async';

import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ConnectedDeviceTile extends StatefulWidget {
  final BluetoothDevice device;
  final VoidCallback onDisconnect;
  final VoidCallback onConnect;

  const ConnectedDeviceTile({
    required this.device,
    required this.onDisconnect,
    required this.onConnect,
    Key? key,
  }) : super(key: key);

  @override
  State<ConnectedDeviceTile> createState() => _ConnectedDeviceTileState();
}

class _ConnectedDeviceTileState extends State<ConnectedDeviceTile> {
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;

  @override
  void initState() {
    super.initState();

    _connectionStateSubscription =
        widget.device.connectionState.listen((state) {
      _connectionState = state;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    super.dispose();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

  @override
  Widget build(BuildContext context) {
    return ClickableContainer(
      margin: const EdgeInsets.only(
        left: MySpaces.s24,
        right: MySpaces.s24,
        top: MySpaces.s12,
      ),
      color: MyColors.black.shade600,
      borderRadius: MyRadius.sm,
      padding: const EdgeInsets.symmetric(
          vertical: MySpaces.s16, horizontal: MySpaces.s24),
      onTap: isConnected ? widget.onDisconnect : widget.onConnect,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              widget.device.platformName,
              overflow: TextOverflow.ellipsis,
              style:
                  DemiBoldStyle.sm.copyWith(color: MyColors.secondary.shade100),
            ),
          ),
          Text(
            isConnected ? 'DISCONNECT' : 'CONNECT',
            style: DemiBoldStyle.sm.copyWith(
                color: isConnected
                    ? MyColors.secondary.shade300
                    : MyColors.secondary.shade600),
          )
        ],
      ),
    );
    return ListTile(
      title: Text(widget.device.platformName),
      trailing: ElevatedButton(
        onPressed: isConnected ? widget.onDisconnect : widget.onConnect,
        child: isConnected ? const Text('OPEN') : const Text('CONNECT'),
      ),
    );
  }
}
