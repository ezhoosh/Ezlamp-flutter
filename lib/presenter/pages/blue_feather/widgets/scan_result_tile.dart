import 'dart:async';

import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/core/resource/my_text_styles.dart';
import 'package:easy_lamp/core/widgets/clickable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScanResultTile extends StatefulWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  @override
  State<ScanResultTile> createState() => _ScanResultTileState();
}

class _ScanResultTileState extends State<ScanResultTile> {
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;
  late AppLocalizations al;

  @override
  void initState() {
    super.initState();

    _connectionStateSubscription =
        widget.result.device.connectionState.listen((state) {
      _connectionState = state;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    super.dispose();
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]';
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    return data.entries
        .map((entry) =>
            '${entry.key.toRadixString(16)}: ${getNiceHexArray(entry.value)}')
        .join(', ')
        .toUpperCase();
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    return data.entries
        .map((v) => '${v.key}: ${getNiceHexArray(v.value)}')
        .join(', ')
        .toUpperCase();
  }

  String getNiceServiceUuids(List<String> serviceUuids) {
    return serviceUuids.isEmpty ? 'N/A' : serviceUuids.join(', ').toUpperCase();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

  Widget _buildTitle(BuildContext context) {
    if (widget.result.device.platformName.isNotEmpty) {
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
        onTap:
            (widget.result.advertisementData.connectable) ? widget.onTap : null,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                widget.result.device.platformName,
                overflow: TextOverflow.ellipsis,
                style: DemiBoldStyle.sm
                    .copyWith(color: MyColors.secondary.shade100),
              ),
            ),
            Text(
              isConnected ? al.connected : al.disconnected,
              style: DemiBoldStyle.sm.copyWith(
                  color: isConnected
                      ? MyColors.secondary.shade300
                      : MyColors.secondary.shade600),
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    al = AppLocalizations.of(context)!;
    var adv = widget.result.advertisementData;
    return _buildTitle(context);
  }
}
