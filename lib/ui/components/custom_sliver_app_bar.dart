import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, this.title, this.child});

  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title != null ? Text(title!) : null,
      floating: true,
      snap: true,
      pinned: false,
      flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: UiToken.spacing16),
          child: child,
        ),
      ),
      collapsedHeight: 280,
      actions: [
        IconButton(
          icon: Icon(Icons.brightness_6),
          onPressed: () =>
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
        ),
      ],
    );
  }
}
