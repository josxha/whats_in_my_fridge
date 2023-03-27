import 'package:flutter/material.dart';
import 'package:opengtindb/opengtindb.dart';
import 'package:whats_in_my_fridge/models/list_item.dart';

import '../services/pref_service.dart';
import 'empty_list_widget.dart';
import 'item_list_tile.dart';

class ListPage extends StatefulWidget {
  final List<ListItem> items;

  const ListPage(this.items, {Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final BarcodeApi api = BarcodeApi.guest();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      if (widget.items.isEmpty) {
        return const EmptyListWidget();
      }
      return ListView.builder(
        itemBuilder: (context, index) {
          final item = widget.items[widget.items.length-index-1];
          return Dismissible(
            key: Key(item.hashCode.toString()),
            onDismissed: (direction) {
              setState(() => widget.items.removeAt(index));
              PrefService.get.saveItems(widget.items);
              ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(content: Text('Eintrag entfernt')));
            },
            child: ItemListTile(api, item),
          );
        },
        itemCount: widget.items.length,
      );
    });
  }
}
