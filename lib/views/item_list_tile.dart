import 'package:flutter/material.dart';
import 'package:opengtindb/opengtindb.dart';

import '../models/list_item.dart';

class ItemListTile extends StatefulWidget {
  final BarcodeApi api;
  final ListItem item;

  const ItemListTile(this.api, this.item, {Key? key}) : super(key: key);

  @override
  State<ItemListTile> createState() => _ItemListTileState();
}

class _ItemListTileState extends State<ItemListTile> {
  ApiResponse? response;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.api.requestBarcode(widget.item.barcode),
      builder: (context, snapshot) {
        if (snapshot.hasData || response != null) {
          response ??= snapshot.data!;
          if (response!.products.isEmpty) {
            return ListTile(
              title: const Text("Unbekanntes Produkt"),
              subtitle: Text(widget.item.barcode),
              trailing: Text(_formattedDays()),
            );
          }
          final product = response!.products.first;
          return ListTile(
            title: Text(product.detailName ?? ""),
            subtitle: Text(product.descr ?? ""),
            trailing: Text(_formattedDays()),
            isThreeLine: true,
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return ListTile(
            title: Text(widget.item.barcode),
            subtitle: Text(snapshot.error!.toString()),
            trailing: Text(_formattedDays()),
          );
        }
        return ListTile(
          title: const Text("Neues Produkt"),
          subtitle: const LinearProgressIndicator(),
          trailing: Text(_formattedDays()),
        );
      },
    );
  }

  String _formattedDays() {
    final now = DateTime.now();
    final days = widget.item.added.difference(now).inDays;
    switch (days) {
      case 0:
        return "heute";
      case 1:
        return "gestern";
      default:
        return "vor $days Tagen";
    }
  }
}
