import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      key: const Key('details_page'),
      body: const Center(
        child: Text('DETALHES'),
      ),
    );
  }
}
