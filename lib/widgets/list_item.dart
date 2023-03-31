import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Text('data'),
          ],
        ),
      ),
    );
  }
}
