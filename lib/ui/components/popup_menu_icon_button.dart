import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/provider.dart';

class PopupMenuIconButton extends StatelessWidget {
  const PopupMenuIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      itemBuilder: (context) => [
        PopupMenuItem(
          padding: EdgeInsets.symmetric(horizontal: UiToken.spacing16),
          value: 'toggle_theme',
          child: TextButton.icon(
            label: Center(
              child: Text(
                'Toggle Theme',
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
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              Navigator.pop(context);
            },
            autofocus: false,
          ),
        ),
      ],
    );
  }
}
