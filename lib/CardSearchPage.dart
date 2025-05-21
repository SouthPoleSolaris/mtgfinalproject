import 'package:flutter/material.dart';


class CardSearchPage extends StatelessWidget {
  const CardSearchPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Card Search')),
    body: const Center(child: Text('🔍 Search Scryfall API')),
  );
}