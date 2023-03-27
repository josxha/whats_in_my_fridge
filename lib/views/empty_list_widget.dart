import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.new_releases, color: Colors.blueGrey, size: 35),
        SizedBox(height: 20),
        Text("Du hast noch keine Produkte zu deiner Liste hinzugefügt."),
      ],
    ));
  }
}
