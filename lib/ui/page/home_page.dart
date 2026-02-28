import 'package:flutter/material.dart';
import '../../util/import/service.dart';
import '../../util/import/ui.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(
          title: LocalizationService.strings.home,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Center(), Search()],
          ),
        ),
      ],
    );
  }
}
