import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.title, this.index = 0});

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title),
          ],
        ),
      ),
    );
  }
}
