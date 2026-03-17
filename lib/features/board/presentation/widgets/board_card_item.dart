import 'package:flutter/material.dart';

class BoardCardItem extends StatelessWidget {
  const BoardCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(child: ListTile(title: Text('Board Item')));
  }
}
