import 'package:flutter/material.dart';

class AddReceipeScreen extends StatelessWidget {
  const AddReceipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Add receipe')),
    );
  }
}
