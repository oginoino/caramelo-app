import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../../util/import/ui.dart';

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({super.key, this.title, this.child});

  final String? title;
  final Widget? child;

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      backgroundColor: scaffoldColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: LocationSelectorDropdown(initialSelection: widget.title),
      floating: true,
      snap: true,
      pinned: false,
      flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: UiToken.spacing16),
          child: widget.child,
        ),
      ),
      collapsedHeight: 280,
      actions: [
        PopupMenuIconButton(
          icon: CircleAvatar(
            radius: UiToken.shadow16,
            backgroundColor: isLightTheme
                ? UiToken.secondaryDark500
                : UiToken.secondaryLight400,
            child: Icon(
              Icons.person_rounded,
              size: UiToken.textSize24,
              color: isLightTheme
                  ? UiToken.secondaryLight400
                  : UiToken.secondaryDark500,
            ),
          ),
          items: [
            PopupMenuItem(
              padding: EdgeInsets.symmetric(horizontal: UiToken.spacing16),
              value: 'toggle_theme',
              child: TextButton.icon(
                label: Center(
                  child: Text(
                    LocalizationService.strings.toggleTheme,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isLightTheme
                          ? UiToken.secondaryDark500
                          : UiToken.secondaryLight400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                icon: Icon(
                  Icons.brightness_6,
                  color: isLightTheme
                      ? UiToken.secondaryDark500
                      : UiToken.secondaryLight400,
                ),
                onPressed: () {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme();
                  Navigator.pop(context);
                },
                autofocus: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
