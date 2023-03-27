import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:whats_in_my_fridge/models/list_item.dart';
import 'package:opengtindb/opengtindb.dart';
import 'package:whats_in_my_fridge/views/item_list_tile.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final BarcodeApi api = BarcodeApi.guest();
  final List<ListItem> _items = [];

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
        body: Builder(builder: (BuildContext context) {
          if (_items.isEmpty) {
            return Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.new_releases, color: Colors.blueGrey, size: 35),
                SizedBox(height: 20),
                Text("Du hast noch keine Produkte zu deiner Liste hinzugefügt."),
              ],
            ));
          }
          return ListView.builder(
            itemBuilder: (context, index) => Card(
              child: ItemListTile(api, _items[_items.length-index-1]),
            ),
            itemCount: _items.length,
          );
          }
        ),
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
      _playSound();
      if (mounted) {
        setState(() {
          _items.add(ListItem(barcode));
        });
      }
    }
  }

  Future<void> _playSound() async {
    // https://www.soundjay.com/beep-sounds-1.html
    final player = AudioPlayer();
    final source = AssetSource("beep-07a.mp3");
    await player.play(source);
  }
}
