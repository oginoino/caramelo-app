import '../../util/import/packages.dart';
import '../../util/import/provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, this.title, this.flexibleSpace});

  final String? title;
  final Widget? flexibleSpace;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title != null ? Text(title!) : null,
      floating: true,
      snap: true,
      pinned: false,
      flexibleSpace: flexibleSpace,
      actions: [
        // Change theme button
        IconButton(
          icon: Icon(Icons.brightness_6),
          onPressed: () =>
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
        ),
      ],
    );
  }
}
