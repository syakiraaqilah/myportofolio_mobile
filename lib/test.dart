
import 'package:flutter/material.dart';

class TryLayoutBuilder extends StatelessWidget {
  const TryLayoutBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coba responsive')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _box(Colors.red),
                _box(Colors.yellow),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _box(Colors.green),
                _box(Colors.blue),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _box(Color color) {
    return Container(
      width: 100,
      height: 100,
      color: color,
      child: const Center(child: Text('Hello')),
    );
  }
}
