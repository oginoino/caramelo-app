import 'package:flutter/material.dart';

import '../../util/import/ui.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [CustomSliverAppBar(title: 'Início', child: Search())],
    );
  }
}
