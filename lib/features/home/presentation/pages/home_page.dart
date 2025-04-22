import 'package:flutter/material.dart';
import 'package:moi_market/core/widgets/default_custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultCustomScaffold(body: Container(child: const Text('HOMEPAGE'),));
  }
}
