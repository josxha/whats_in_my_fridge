import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:whats_in_my_fridge/models/list_item.dart';
import 'package:opengtindb/opengtindb.dart';
import 'package:whats_in_my_fridge/views/item_list_tile.dart';

import 'services/pref_service.dart';
import 'services/sound_service.dart';
import 'views/list_page.dart';

Future<void> main() async {
  await PrefService.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<ListItem> _items = [];

  @override
  void initState() {
    _items = PrefService.get.loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(title: const Text('Was ist im Kühlschrank?')),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Scannen"),
          icon: const Icon(Icons.camera),
          onPressed: () => _scanBarcodes(),
        ),
        body: ListPage(_items),
      ),
    );
  }

  DateTime _lastScan = DateTime(0);

  Future<void> _scanBarcodes() async {
    final stream = FlutterBarcodeScanner
        .getBarcodeStreamReceiver('#ff0000', 'Zurück', true, ScanMode.BARCODE)!;
    await for (final barcode in stream) {
      final now = DateTime.now();
      if (now.difference(_lastScan).inMilliseconds < 2000) continue;
      _lastScan = now;
      debugPrint(barcode);
      final bc = barcode.toString();
      if (bc.length != 8 && bc.length != 13) continue;
      //if (!isValidBarcode(barcode)) continue;
      SoundService().beep();
      if (mounted) {
        setState(() {
          _items.add(ListItem(barcode));
        });
      }
      await PrefService.get.saveItems(_items);
    }
  }
}
