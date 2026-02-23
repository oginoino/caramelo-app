import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title != null ? Text(title!) : null,
      floating: true,
      snap: true,
      pinned: false,
      expandedHeight: UiToken.spacing40,
      actions: [
        // Change theme button
        IconButton(
          icon: Icon(Icons.brightness_6),
          onPressed: () => context.watch<ThemeProvider>().toggleTheme(),
        ),
      ],
    );
  }
}
